import { ObjectType, Field, Float, Int } from '@nestjs/graphql';

@ObjectType()
export class Attraction {
  @Field() id: string;
  @Field() name: string;
}

@ObjectType()
export class Venue {
  @Field() id: string;
  @Field() name: string;
  @Field() address: string;
  @Field() city: string;
  @Field() state: string;
  @Field() country: string;
  @Field(() => Float, { nullable: true }) latitude?: number;
  @Field(() => Float, { nullable: true }) longitude?: number;
  @Field() timezone: string;
  @Field({ nullable: true }) imageUrl?: string;
}

@ObjectType()
export class Event {
  @Field() id: string;
  @Field() name: string;
  @Field() date: string;
  @Field({ nullable: true }) time?: string;
  @Field() image: string;
  @Field() city: string;
  @Field() state: string;
  @Field() venueName: string;
  @Field() category: string;
  @Field({ nullable: true }) genre?: string;
  @Field(() => Float, { nullable: true }) priceMin?: number;
  @Field(() => Float, { nullable: true }) priceMax?: number;
  @Field() currency: string;
  @Field() status: string;
  @Field() url: string;
  @Field({ nullable: true }) isFavorited?: boolean;
}

@ObjectType()
export class EventDetail extends Event {
  @Field({ nullable: true }) dateTime?: string;
  @Field() dateTBD: boolean;
  @Field(() => [String]) images: string[];
  @Field() description: string;
  @Field({ nullable: true }) note?: string;
  @Field({ nullable: true }) salesStart?: string;
  @Field({ nullable: true }) salesEnd?: string;
  @Field(() => [Attraction]) attractions: Attraction[];
  @Field(() => Venue, { nullable: true }) venue?: Venue;
  @Field(() => [Review]) reviews: Review[];
  @Field(() => Int) reviewCount: number;
  @Field(() => Float, { nullable: true }) averageRating?: number;
  @Field(() => [Event]) similarEvents: Event[];
}

// Forward reference — Review defined here to avoid circular imports
@ObjectType()
export class Review {
  @Field() id: string;
  @Field() userId: string;
  @Field() userName: string;
  @Field({ nullable: true }) userAvatar?: string;
  @Field() tmEventId: string;
  @Field(() => Int) rating: number;
  @Field() comment: string;
  @Field() createdAt: string;
}

@ObjectType()
export class PaginatedEvents {
  @Field(() => [Event]) events: Event[];
  @Field(() => Int) total: number;
  @Field(() => Int) page: number;
  @Field(() => Int) pages: number;
}
