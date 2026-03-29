import { Module } from '@nestjs/common';
import { TicketmasterModule } from '../ticketmaster/ticketmaster.module';
import { FavoritesController } from './favorites.controller';
import { FavoritesService } from './favorites.service';

@Module({
  imports: [TicketmasterModule],
  controllers: [FavoritesController],
  providers: [FavoritesService],
  exports: [FavoritesService],
})
export class FavoritesModule {}
