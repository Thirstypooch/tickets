import { Body, Controller, Post, Req } from '@nestjs/common';
import { AuthService } from './auth.service';
import { Public } from '../common/decorators/current-user.decorator';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Public()
  @Post('signup')
  signUp(@Body() body: { email: string; password: string; displayName?: string }) {
    return this.authService.signUp(body.email, body.password, body.displayName);
  }

  @Public()
  @Post('login')
  signIn(@Body() body: { email: string; password: string }) {
    return this.authService.signIn(body.email, body.password);
  }

  @Post('logout')
  signOut(@Req() req: any) {
    return this.authService.signOut(req.accessToken);
  }
}
