import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createClient, SupabaseClient } from '@supabase/supabase-js';

@Injectable()
export class SupabaseService {
  private readonly logger = new Logger(SupabaseService.name);
  private adminClient: SupabaseClient | null = null;
  private readonly url: string;
  private readonly anonKey: string;

  constructor(private config: ConfigService) {
    this.url = this.config.get<string>('supabase.url') ?? '';
    this.anonKey = this.config.get<string>('supabase.anonKey') ?? '';
    const serviceKey = this.config.get<string>('supabase.serviceRoleKey') ?? '';

    if (this.url && serviceKey) {
      this.adminClient = createClient(this.url, serviceKey);
    } else {
      this.logger.warn(
        'Supabase not configured — auth, bookings, reviews, favorites will not work. ' +
        'Set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY in .env',
      );
    }
  }

  get admin(): SupabaseClient {
    if (!this.adminClient) {
      throw new Error('Supabase is not configured. Set env vars in .env');
    }
    return this.adminClient;
  }

  get isConfigured(): boolean {
    return this.adminClient !== null;
  }

  forUser(accessToken: string): SupabaseClient {
    if (!this.url || !this.anonKey) {
      throw new Error('Supabase is not configured');
    }
    return createClient(this.url, this.anonKey, {
      global: { headers: { Authorization: `Bearer ${accessToken}` } },
    });
  }
}
