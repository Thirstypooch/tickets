import { Resolver, Query, Mutation, Args } from '@nestjs/graphql';
import { Booking } from './models/booking.model';
import { BookingsService } from './bookings.service';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@Resolver(() => Booking)
export class BookingsResolver {
  constructor(private bookingsService: BookingsService) {}

  @Query(() => [Booking], { name: 'upcomingBookings' })
  async getUpcoming(@CurrentUser() user: any): Promise<Booking[]> {
    const rows = await this.bookingsService.getUpcoming(user.id);
    return rows.map(this.mapRow);
  }

  @Query(() => [Booking], { name: 'pastBookings' })
  async getPast(@CurrentUser() user: any): Promise<Booking[]> {
    const rows = await this.bookingsService.getPast(user.id);
    return rows.map(this.mapRow);
  }

  @Query(() => [Booking], { name: 'myBookings' })
  async getAll(@CurrentUser() user: any): Promise<Booking[]> {
    const rows = await this.bookingsService.getAll(user.id);
    return rows.map(this.mapRow);
  }

  @Mutation(() => Booking)
  async createBooking(
    @CurrentUser() user: any,
    @Args('tmEventId') tmEventId: string,
    @Args('quantity') quantity: number,
    @Args('unitPrice') unitPrice: number,
  ): Promise<Booking> {
    const row = await this.bookingsService.create(user.id, {
      tmEventId,
      quantity,
      unitPrice,
    });
    return this.mapRow(row);
  }

  private mapRow(row: any): Booking {
    return {
      id: row.id,
      userId: row.user_id,
      tmEventId: row.tm_event_id,
      quantity: row.quantity,
      unitPrice: parseFloat(row.unit_price),
      totalPrice: parseFloat(row.total_price),
      status: row.status,
      createdAt: row.created_at,
      eventSnapshot: {
        name: row.event_name,
        date: row.event_date,
        venueName: row.event_venue_name,
        city: row.event_city,
        image: row.event_image,
      },
    };
  }
}
