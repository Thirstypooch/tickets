import { Injectable, UnauthorizedException } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';

@Injectable()
export class AuthService {
  constructor(private supabase: SupabaseService) {}

  async signUp(email: string, password: string, displayName?: string) {
    const name = displayName ?? email.split('@')[0];

    // Use admin API to auto-confirm users (no email verification for demo)
    const { data, error } = await this.supabase.admin.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
      user_metadata: { display_name: name },
    });
    if (error) throw new UnauthorizedException(error.message);

    // Ensure profile has the display_name
    if (data.user) {
      await this.supabase.admin
        .from('profiles')
        .upsert({
          id: data.user.id,
          display_name: name,
          avatar_url: '',
        }, { onConflict: 'id' });
    }

    // Auto-login: return a session with token
    const loginResult = await this.signIn(email, password);
    return loginResult;
  }

  async signIn(email: string, password: string) {
    const { data, error } =
      await this.supabase.admin.auth.signInWithPassword({ email, password });
    if (error) throw new UnauthorizedException(error.message);
    return {
      access_token: data.session.access_token,
      refresh_token: data.session.refresh_token,
      user: data.user,
    };
  }

  async signOut() {
    const { error } = await this.supabase.admin.auth.signOut();
    if (error) throw new UnauthorizedException(error.message);
    return { message: 'Signed out' };
  }
}
