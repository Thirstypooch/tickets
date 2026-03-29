import { ObjectType, Field } from '@nestjs/graphql';

@ObjectType()
export class DashboardStat {
  @Field() title: string;
  @Field() value: string;
  @Field() icon: string;
  @Field() description: string;
  @Field() trend: string;
}
