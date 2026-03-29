import { IsString, IsNumber, Min } from 'class-validator';

export class CreateBookingDto {
  @IsString()
  tmEventId: string;

  @IsNumber()
  @Min(1)
  quantity: number;

  @IsNumber()
  @Min(0)
  unitPrice: number;
}
