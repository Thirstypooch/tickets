import { Injectable } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';
import { TicketmasterService } from '../ticketmaster/ticketmaster.service';

@Injectable()
export class FavoritesService {
  constructor(
    private supabase: SupabaseService,
    private tm: TicketmasterService,
  ) {}

  async toggle(userId: string, tmEventId: string): Promise<boolean> {
    // Check if already favorited
    const { data: existing } = await this.supabase.admin
      .from('favorites')
      .select('id')
      .eq('user_id', userId)
      .eq('tm_event_id', tmEventId)
      .single();

    if (existing) {
      await this.supabase.admin
        .from('favorites')
        .delete()
        .eq('id', existing.id);
      return false; // unfavorited
    }

    await this.supabase.admin
      .from('favorites')
      .insert({ user_id: userId, tm_event_id: tmEventId });
    return true; // favorited
  }

  async isFavorited(userId: string, tmEventId: string): Promise<boolean> {
    const { data } = await this.supabase.admin
      .from('favorites')
      .select('id')
      .eq('user_id', userId)
      .eq('tm_event_id', tmEventId)
      .single();
    return !!data;
  }

  async getUserFavorites(userId: string) {
    const { data, error } = await this.supabase.admin
      .from('favorites')
      .select('tm_event_id, created_at')
      .eq('user_id', userId)
      .order('created_at', { ascending: false });

    if (error || !data?.length) return [];

    // Enrich with TM event data (parallel, using cache)
    const enriched = await Promise.all(
      data.map(async (fav) => {
        const event = await this.tm.getEvent(fav.tm_event_id);
        return event ? { ...event, favoritedAt: fav.created_at } : null;
      }),
    );

    return enriched.filter(Boolean);
  }
}
