import { Injectable, NotFoundException } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';
import { TicketmasterService } from '../ticketmaster/ticketmaster.service';
import { CreateBookingDto } from './dto/create-booking.dto';

@Injectable()
export class BookingsService {
  constructor(
    private supabase: SupabaseService,
    private tm: TicketmasterService,
  ) {}

  async create(userId: string, dto: CreateBookingDto) {
    // Fetch event from TM for snapshot
    const event = await this.tm.getEvent(dto.tmEventId);
    if (!event) throw new NotFoundException('Event not found on Ticketmaster');

    const { data, error } = await this.supabase.admin
      .from('bookings')
      .insert({
        user_id: userId,
        tm_event_id: dto.tmEventId,
        quantity: dto.quantity,
        unit_price: dto.unitPrice,
        event_name: event.name,
        event_date: event.date,
        event_venue_name: event.venueName,
        event_city: event.city,
        event_image: event.image,
      })
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  async getUpcoming(userId: string) {
    const today = new Date().toISOString().split('T')[0];
    const { data, error } = await this.supabase.admin
      .from('bookings')
      .select('*')
      .eq('user_id', userId)
      .gte('event_date', today)
      .in('status', ['confirmed', 'pending'])
      .order('event_date', { ascending: true });

    if (error) throw new Error(error.message);
    return data ?? [];
  }

  async getPast(userId: string) {
    const today = new Date().toISOString().split('T')[0];
    const { data, error } = await this.supabase.admin
      .from('bookings')
      .select('*')
      .eq('user_id', userId)
      .lt('event_date', today)
      .order('event_date', { ascending: false });

    if (error) throw new Error(error.message);
    return data ?? [];
  }

  async getAll(userId: string) {
    const { data, error } = await this.supabase.admin
      .from('bookings')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false });

    if (error) throw new Error(error.message);
    return data ?? [];
  }
}
