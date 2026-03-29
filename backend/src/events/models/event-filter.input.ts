import { InputType, Field, Float, Int } from '@nestjs/graphql';

@InputType()
export class EventFilterInput {
  @Field({ nullable: true }) keyword?: string;
  @Field({ nullable: true }) city?: string;
  @Field({ nullable: true }) category?: string;
  @Field({ nullable: true }) genreId?: string;
  @Field(() => Float, { nullable: true }) priceMin?: number;
  @Field(() => Float, { nullable: true }) priceMax?: number;
  @Field({ nullable: true }) startDate?: string;
  @Field({ nullable: true }) endDate?: string;
  @Field({ nullable: true }) sort?: string;
  @Field(() => Int, { nullable: true }) page?: number;
  @Field(() => Int, { nullable: true }) size?: number;
}
