import { Injectable, NotFoundException } from '@nestjs/common';
import { TicketmasterService } from '../ticketmaster/ticketmaster.service';
import { EventFilterDto } from './dto/event-filter.dto';

@Injectable()
export class EventsService {
  constructor(private tm: TicketmasterService) {}

  async search(filter: EventFilterDto) {
    return this.tm.searchEvents({
      keyword: filter.keyword,
      city: filter.city,
      category: filter.category,
      genreId: filter.genreId,
      startDate: filter.startDate,
      endDate: filter.endDate,
      sort: filter.sort,
      page: filter.page,
      size: filter.size,
    });
  }

  async getFeatured() {
    return this.tm.getFeaturedEvents();
  }

  async getById(id: string) {
    const event = await this.tm.getEvent(id);
    if (!event) throw new NotFoundException(`Event ${id} not found`);
    return event;
  }
}
