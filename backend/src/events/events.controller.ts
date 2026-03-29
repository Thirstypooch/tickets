import { Controller, Get, Param, Query } from '@nestjs/common';
import { EventsService } from './events.service';
import { EventFilterDto } from './dto/event-filter.dto';
import { Public } from '../common/decorators/current-user.decorator';

@Public()
@Controller('events')
export class EventsController {
  constructor(private eventsService: EventsService) {}

  @Get()
  search(@Query() filter: EventFilterDto) {
    return this.eventsService.search(filter);
  }

  @Get('featured')
  featured() {
    return this.eventsService.getFeatured();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.eventsService.getById(id);
  }
}
