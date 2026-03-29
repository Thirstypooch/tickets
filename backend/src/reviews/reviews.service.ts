import { Injectable } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';
import { CreateReviewDto } from './dto/create-review.dto';

@Injectable()
export class ReviewsService {
  constructor(private supabase: SupabaseService) {}

  async create(userId: string, dto: CreateReviewDto) {
    const { data, error } = await this.supabase.admin
      .from('reviews')
      .upsert(
        {
          user_id: userId,
          tm_event_id: dto.tmEventId,
          rating: dto.rating,
          comment: dto.comment ?? '',
        },
        { onConflict: 'user_id,tm_event_id' },
      )
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  async getByEventId(tmEventId: string) {
    const { data, error } = await this.supabase.admin
      .from('reviews')
      .select('*, profiles!inner(display_name, avatar_url)')
      .eq('tm_event_id', tmEventId)
      .order('created_at', { ascending: false });

    if (error) throw new Error(error.message);

    return (data ?? []).map((r: any) => ({
      id: r.id,
      userId: r.user_id,
      userName: r.profiles?.display_name ?? 'Anonymous',
      userAvatar: r.profiles?.avatar_url ?? '',
      tmEventId: r.tm_event_id,
      rating: r.rating,
      comment: r.comment,
      createdAt: r.created_at,
    }));
  }

  async getCountByEventId(tmEventId: string): Promise<number> {
    const { count, error } = await this.supabase.admin
      .from('reviews')
      .select('*', { count: 'exact', head: true })
      .eq('tm_event_id', tmEventId);

    if (error) return 0;
    return count ?? 0;
  }

  async getAverageRatingByEventId(tmEventId: string): Promise<number | null> {
    const { data, error } = await this.supabase.admin
      .from('reviews')
      .select('rating')
      .eq('tm_event_id', tmEventId);

    if (error || !data?.length) return null;
    const sum = data.reduce((acc, r) => acc + r.rating, 0);
    return Math.round((sum / data.length) * 10) / 10;
  }
}
