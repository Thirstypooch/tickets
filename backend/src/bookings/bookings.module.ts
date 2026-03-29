import { Module } from '@nestjs/common';
import { TicketmasterModule } from '../ticketmaster/ticketmaster.module';
import { BookingsController } from './bookings.controller';
import { BookingsService } from './bookings.service';
import { BookingsResolver } from './bookings.resolver';

@Module({
  imports: [TicketmasterModule],
  controllers: [BookingsController],
  providers: [BookingsService, BookingsResolver],
  exports: [BookingsService],
})
export class BookingsModule {}
