import { IsNotEmpty, IsString, MaxLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class ChatMessageDto {
  @IsNotEmpty()
  @IsString()
  @MaxLength(500)
  @ApiProperty({ required: true })
  message: string;
}
