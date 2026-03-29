import { Body, Controller, Get, Post } from '@nestjs/common';
import { BookingsService } from './bookings.service';
import { CreateBookingDto } from './dto/create-booking.dto';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@Controller('bookings')
export class BookingsController {
  constructor(private bookingsService: BookingsService) {}

  @Post()
  create(@CurrentUser() user: any, @Body() dto: CreateBookingDto) {
    return this.bookingsService.create(user.id, dto);
  }

  @Get('upcoming')
  upcoming(@CurrentUser() user: any) {
    return this.bookingsService.getUpcoming(user.id);
  }

  @Get('past')
  past(@CurrentUser() user: any) {
    return this.bookingsService.getPast(user.id);
  }

  @Get()
  all(@CurrentUser() user: any) {
    return this.bookingsService.getAll(user.id);
  }
}
