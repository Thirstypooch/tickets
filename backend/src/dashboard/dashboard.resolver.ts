import { Resolver, Query } from '@nestjs/graphql';
import { DashboardStat } from './models/dashboard-stat.model';
import { DashboardService } from './dashboard.service';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@Resolver()
export class DashboardResolver {
  constructor(private dashboardService: DashboardService) {}

  @Query(() => [DashboardStat], { name: 'dashboardStats' })
  async getStats(@CurrentUser() user: any): Promise<DashboardStat[]> {
    return this.dashboardService.getStats(user.id);
  }
}
