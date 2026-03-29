import { Controller, Get } from '@nestjs/common';
import { Public } from './common/decorators/current-user.decorator';

@Controller()
export class AppController {
  @Public()
  @Get()
  healthCheck() {
    return { status: 'ok', service: 'tickets-api', timestamp: new Date().toISOString() };
  }
}
