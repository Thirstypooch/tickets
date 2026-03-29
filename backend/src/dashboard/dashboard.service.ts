import { Injectable } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';

export interface DashboardStatDto {
  title: string;
  value: string;
  icon: string;
  description: string;
  trend: string;
}

@Injectable()
export class DashboardService {
  constructor(private supabase: SupabaseService) {}

  async getStats(userId: string): Promise<DashboardStatDto[]> {
    const db = this.supabase.admin;

    // Run queries in parallel
    const [bookingsResult, upcomingResult, spentResult, ratingsResult] =
      await Promise.all([
        db
          .from('bookings')
          .select('*', { count: 'exact', head: true })
          .eq('user_id', userId),
        db
          .from('bookings')
          .select('*', { count: 'exact', head: true })
          .eq('user_id', userId)
          .gte('event_date', new Date().toISOString().split('T')[0])
          .in('status', ['confirmed', 'pending']),
        db
          .from('bookings')
          .select('total_price')
          .eq('user_id', userId),
        db
          .from('reviews')
          .select('rating')
          .eq('user_id', userId),
      ]);

    const totalBookings = bookingsResult.count ?? 0;
    const upcomingCount = upcomingResult.count ?? 0;

    const totalSpent = (spentResult.data ?? []).reduce(
      (sum: number, b: any) => sum + parseFloat(b.total_price || '0'),
      0,
    );

    const ratings = ratingsResult.data ?? [];
    const avgRating =
      ratings.length > 0
        ? Math.round(
            (ratings.reduce((sum: number, r: any) => sum + r.rating, 0) /
              ratings.length) *
              10,
          ) / 10
        : 0;

    return [
      {
        title: 'Events Attended',
        value: String(totalBookings),
        icon: 'calendar',
        description: 'Total bookings',
        trend: `${upcomingCount} upcoming`,
      },
      {
        title: 'Upcoming Events',
        value: String(upcomingCount),
        icon: 'ticket',
        description: 'Confirmed reservations',
        trend: upcomingCount > 0 ? 'You have plans!' : 'Browse events',
      },
      {
        title: 'Total Spent',
        value: `$${totalSpent.toLocaleString('en-US', { minimumFractionDigits: 0 })}`,
        icon: 'dollarSign',
        description: 'Lifetime spending',
        trend: totalSpent > 0 ? 'Keep exploring' : 'Book your first event',
      },
      {
        title: 'Average Rating',
        value: avgRating > 0 ? String(avgRating) : '-',
        icon: 'star',
        description: 'Your review average',
        trend:
          ratings.length > 0
            ? `${ratings.length} reviews given`
            : 'No reviews yet',
      },
    ];
  }
}
