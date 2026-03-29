import { Module } from '@nestjs/common';
import { TicketmasterModule } from '../ticketmaster/ticketmaster.module';
import { ReviewsModule } from '../reviews/reviews.module';
import { FavoritesModule } from '../favorites/favorites.module';
import { EventsController } from './events.controller';
import { EventsService } from './events.service';
import { EventsResolver } from './events.resolver';

@Module({
  imports: [TicketmasterModule, ReviewsModule, FavoritesModule],
  controllers: [EventsController],
  providers: [EventsService, EventsResolver],
  exports: [EventsService],
})
export class EventsModule {}
