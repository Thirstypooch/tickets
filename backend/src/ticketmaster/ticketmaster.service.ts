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
    const cacheKey = `tm:events:${JSON.stringify(params)}`;
    const cached = await this.cache.get<PaginatedEvents>(cacheKey);
    if (cached) return cached;

    const queryParams: Record<string, string> = {
      apikey: this.apiKey,
      size: String(params.size ?? 20),
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
      const events = (data._embedded?.events ?? []).map(transformToEventSummary);

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
    const result = await this.searchEvents({
      sort: 'relevance,desc',
      size: 4,
    });
    return result.events;
  }
}
