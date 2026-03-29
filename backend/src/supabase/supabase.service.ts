import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createClient, SupabaseClient } from '@supabase/supabase-js';

@Injectable()
export class SupabaseService {
  private readonly adminClient: SupabaseClient;

  constructor(private config: ConfigService) {
    this.adminClient = createClient(
      this.config.get<string>('supabase.url')!,
      this.config.get<string>('supabase.serviceRoleKey')!,
    );
  }

  /** Admin client — bypasses RLS. Use for server-side operations. */
  get admin(): SupabaseClient {
    return this.adminClient;
  }

  /** Create a client scoped to a user's JWT — respects RLS policies. */
  forUser(accessToken: string): SupabaseClient {
    return createClient(
      this.config.get<string>('supabase.url')!,
      this.config.get<string>('supabase.anonKey')!,
      {
        global: { headers: { Authorization: `Bearer ${accessToken}` } },
      },
    );
  }
}
