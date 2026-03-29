import { Body, Controller, Get, Post } from '@nestjs/common';
import { FavoritesService } from './favorites.service';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@Controller('favorites')
export class FavoritesController {
  constructor(private favoritesService: FavoritesService) {}

  @Post('toggle')
  toggle(@CurrentUser() user: any, @Body() body: { tmEventId: string }) {
    return this.favoritesService.toggle(user.id, body.tmEventId);
  }

  @Get()
  list(@CurrentUser() user: any) {
    return this.favoritesService.getUserFavorites(user.id);
  }
}
