import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { CacheModule } from '@nestjs/cache-manager';
import { TicketmasterService } from './ticketmaster.service';

@Module({
  imports: [
    HttpModule.register({ timeout: 10000 }),
    CacheModule.register(),
  ],
  providers: [TicketmasterService],
  exports: [TicketmasterService],
})
export class TicketmasterModule {}
