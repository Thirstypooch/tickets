import { ObjectType, Field, Float, Int, ID } from '@nestjs/graphql';

@ObjectType()
export class EventSnapshot {
  @Field() name: string;
  @Field() date: string;
  @Field() venueName: string;
  @Field() city: string;
  @Field() image: string;
}

@ObjectType()
export class Booking {
  @Field(() => ID) id: string;
  @Field() userId: string;
  @Field() tmEventId: string;
  @Field(() => Int) quantity: number;
  @Field(() => Float) unitPrice: number;
  @Field(() => Float) totalPrice: number;
  @Field() status: string;
  @Field() createdAt: string;
  @Field(() => EventSnapshot) eventSnapshot: EventSnapshot;
}
