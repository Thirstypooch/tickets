import { Injectable, UnauthorizedException } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';

@Injectable()
export class AuthService {
  constructor(private supabase: SupabaseService) {}

  async signUp(email: string, password: string, displayName?: string) {
    const { data, error } = await this.supabase.admin.auth.signUp({
      email,
      password,
      options: {
        data: { display_name: displayName ?? email.split('@')[0] },
      },
    });
    if (error) throw new UnauthorizedException(error.message);
    return { user: data.user, session: data.session };
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

  async signOut(accessToken: string) {
    const { error } = await this.supabase.admin.auth.admin.signOut(accessToken);
    if (error) throw new UnauthorizedException(error.message);
    return { message: 'Signed out' };
  }
}
