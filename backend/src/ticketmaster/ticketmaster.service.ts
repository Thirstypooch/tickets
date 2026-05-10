import { Injectable, Logger } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { Cache, CACHE_MANAGER } from '@nestjs/cache-manager';
import { Inject } from '@nestjs/common';
import { firstValueFrom } from 'rxjs';
import { TmSearchResponse, TmEvent } from './ticketmaster.types';
import {
  EventSummaryDto,
  EventDetailDto,
  transformToEventSummary,
  transformToEventDetail,
} from './ticketmaster.transformer';

export interface EventSearchParams {
  keyword?: string;
  city?: string;
  category?: string;
  genreId?: string;
  startDate?: string;
  endDate?: string;
  sort?: string;
  page?: number;
  size?: number;
}

export interface PaginatedEvents {
  events: EventSummaryDto[];
  total: number;
  page: number;
  pages: number;
}

@Injectable()
export class TicketmasterService {
  private readonly logger = new Logger(TicketmasterService.name);
  private readonly apiKey: string;
  private readonly baseUrl: string;
  private readonly cacheTtl: number;

  constructor(
    private http: HttpService,
    private config: ConfigService,
    @Inject(CACHE_MANAGER) private cache: Cache,
  ) {
    this.apiKey = this.config.get<string>('ticketmaster.apiKey')!;
    this.baseUrl = this.config.get<string>('ticketmaster.baseUrl')!;
    this.cacheTtl = (this.config.get<number>('cache.ttl') ?? 3600) * 1000;
  }

  async searchEvents(params: EventSearchParams): Promise<PaginatedEvents> {
    const cacheKey = `tm:events:v4:${JSON.stringify(params)}`;
    const cached = await this.cache.get<PaginatedEvents>(cacheKey);
    if (cached) return cached;

    const requestedSize = params.size ?? 20;
    // Pull a much larger pool than requested so dedupe-by-attraction-and-image
    // has headroom. Cities like Miami have thousands of "tour package" events
    // sharing one or two attractions, so we need a deep pool to find variety.
    const tmSize = Math.min(200, Math.max(requestedSize * 10, 100));

    const queryParams: Record<string, string> = {
      apikey: this.apiKey,
      size: String(tmSize),
      page: String(params.page ?? 0),
      sort: params.sort ?? 'date,asc',
    };

    if (params.keyword) queryParams.keyword = params.keyword;
    if (params.city) queryParams.city = params.city;
    if (params.category) queryParams.classificationName = params.category;
    if (params.genreId) queryParams.genreId = params.genreId;
    if (params.startDate)
      queryParams.startDateTime = `${params.startDate}T00:00:00Z`;
    if (params.endDate)
      queryParams.endDateTime = `${params.endDate}T23:59:59Z`;

    try {
      const { data } = await firstValueFrom(
        this.http.get<TmSearchResponse>(`${this.baseUrl}/events.json`, {
          params: queryParams,
        }),
      );

      // GOTCHA: _embedded is MISSING when zero results
      const rawEvents = data._embedded?.events ?? [];

      // Three-layer dedupe to handle different "duplicate" patterns:
      //   1. Same attraction → same tour, multiple dates ("Eagles" × 30 nights).
      //   2. Same first image URL → different attractions sharing one promo
      //      image (Hard Rock Cafe Miami "Ride and Dine" partnerships).
      //   3. Same name-root → festival series with distinct attractions and
      //      distinct venues but the same umbrella ("Netflix Is A Joke
      //      Presents: X" × 6 shows). Only applies when the name-root is ≥3
      //      words — short roots like "Eagles" or "World Cup" are too generic
      //      to assume a shared series.
      const seenAttractions = new Set<string>();
      const seenImages = new Set<string>();
      const seenSeries = new Set<string>();
      const unique: TmEvent[] = [];
      for (const ev of rawEvents) {
        const attractionKey = ev._embedded?.attractions?.[0]?.id ?? ev.name;
        if (seenAttractions.has(attractionKey)) continue;
        const imgKey = ev.images?.[0]?.url ?? '';
        if (imgKey && seenImages.has(imgKey)) continue;
        const nameRoot = ev.name
          .split(/[:\-—]/)[0]
          .trim()
          .toLowerCase();
        const wordCount = nameRoot ? nameRoot.split(/\s+/).length : 0;
        const isSpecificSeries = wordCount >= 3;
        if (isSpecificSeries && seenSeries.has(nameRoot)) continue;
        seenAttractions.add(attractionKey);
        if (imgKey) seenImages.add(imgKey);
        if (isSpecificSeries) seenSeries.add(nameRoot);
        unique.push(ev);
        if (unique.length === requestedSize) break;
      }

      const events = unique.map(transformToEventSummary);

      const result: PaginatedEvents = {
        events,
        total: data.page.totalElements,
        page: data.page.number,
        pages: data.page.totalPages,
      };

      await this.cache.set(cacheKey, result, this.cacheTtl);
      return result;
    } catch (error) {
      this.logger.error(`TM searchEvents failed: ${error.message}`);
      return { events: [], total: 0, page: 0, pages: 0 };
    }
  }

  async getEvent(id: string): Promise<EventDetailDto | null> {
    const cacheKey = `tm:event:${id}`;
    const cached = await this.cache.get<EventDetailDto>(cacheKey);
    if (cached) return cached;

    try {
      const { data } = await firstValueFrom(
        this.http.get<TmEvent>(`${this.baseUrl}/events/${id}.json`, {
          params: { apikey: this.apiKey },
        }),
      );

      const result = transformToEventDetail(data);
      await this.cache.set(cacheKey, result, this.cacheTtl);
      return result;
    } catch (error) {
      this.logger.error(`TM getEvent(${id}) failed: ${error.message}`);
      return null;
    }
  }

  async getFeaturedEvents(): Promise<EventSummaryDto[]> {
    const cacheKey = 'tm:featured:dedupe-v4';
    const cached = await this.cache.get<EventSummaryDto[]>(cacheKey);
    if (cached) return cached;

    try {
      const nowIso = new Date().toISOString().split('.')[0] + 'Z';
      const [trendingRes, upcomingRes] = await Promise.all([
        firstValueFrom(
          this.http.get<TmSearchResponse>(`${this.baseUrl}/events.json`, {
            params: {
              apikey: this.apiKey,
              size: '40',
              sort: 'relevance,desc',
            },
          }),
        ),
        firstValueFrom(
          this.http.get<TmSearchResponse>(`${this.baseUrl}/events.json`, {
            params: {
              apikey: this.apiKey,
              size: '40',
              sort: 'date,asc',
              startDateTime: nowIso,
            },
          }),
        ),
      ]);

      const trending = trendingRes.data._embedded?.events ?? [];
      const upcoming = upcomingRes.data._embedded?.events ?? [];

      // Interleave: alternate one from trending, one from upcoming for variety.
      const interleaved: TmEvent[] = [];
      const max = Math.max(trending.length, upcoming.length);
      for (let i = 0; i < max; i++) {
        if (trending[i]) interleaved.push(trending[i]);
        if (upcoming[i]) interleaved.push(upcoming[i]);
      }

      const seen = new Set<string>();
      const unique: TmEvent[] = [];
      for (const ev of interleaved) {
        const key = ev._embedded?.attractions?.[0]?.id ?? ev.name;
        if (seen.has(key)) continue;
        seen.add(key);
        unique.push(ev);
        if (unique.length === 8) break;
      }

      const result = unique.map(transformToEventSummary);
      await this.cache.set(cacheKey, result, this.cacheTtl);
      return result;
    } catch (error) {
      this.logger.error(`TM getFeaturedEvents failed: ${error.message}`);
      return [];
    }
  }
}
