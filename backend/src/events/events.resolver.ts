import { Resolver, Query, Args, ResolveField, Parent } from '@nestjs/graphql';
import {
  Event,
  EventDetail,
  PaginatedEvents,
  Review,
  Venue,
} from './models/event.model';
import { EventFilterInput } from './models/event-filter.input';
import { EventsService } from './events.service';
import { ReviewsService } from '../reviews/reviews.service';
import { FavoritesService } from '../favorites/favorites.service';
import { TicketmasterService } from '../ticketmaster/ticketmaster.service';
import { Public, OptionalAuth } from '../common/decorators/current-user.decorator';

@Resolver(() => Event)
export class EventsResolver {
  constructor(
    private eventsService: EventsService,
    private tm: TicketmasterService,
    private reviewsService: ReviewsService,
    private favoritesService: FavoritesService,
  ) {}

  @Public()
  @Query(() => PaginatedEvents, { name: 'events' })
  async getEvents(
    @Args('filter', { nullable: true }) filter?: EventFilterInput,
  ): Promise<PaginatedEvents> {
    return this.eventsService.search(filter ?? {});
  }

  @Public()
  @Query(() => [Event], { name: 'featuredEvents' })
  async getFeatured(): Promise<Event[]> {
    return this.eventsService.getFeatured() as any;
  }

  @Public()
  @Query(() => EventDetail, { name: 'eventDetail' })
  async getEventDetail(@Args('id') id: string): Promise<EventDetail> {
    const detail = await this.eventsService.getById(id);

    // Fetch reviews + stats from our DB
    const [reviews, reviewCount, averageRating] = await Promise.all([
      this.reviewsService.getByEventId(id),
      this.reviewsService.getCountByEventId(id),
      this.reviewsService.getAverageRatingByEventId(id),
    ]);

    // Fetch similar events from TM (same category + city)
    let similarEvents: Event[] = [];
    try {
      const similar = await this.tm.searchEvents({
        category: detail.category,
        city: detail.city,
        size: 5,
      });
      similarEvents = (similar.events as any[]).filter((e) => e.id !== id).slice(0, 4);
    } catch {
      // Non-critical — return empty if TM fails
    }

    return {
      ...detail,
      reviews: reviews as any,
      reviewCount,
      averageRating,
      similarEvents,
      isFavorited: undefined, // resolved per-user below if needed
    } as any;
  }
}
