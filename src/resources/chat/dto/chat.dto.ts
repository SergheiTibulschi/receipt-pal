import { IsNotEmpty, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class ChatMessageDto {
  @IsNotEmpty()
  @ApiProperty({ required: true })
  role: string; // Indicates if it's a message from the user or assistant

  @IsString()
  @IsNotEmpty()
  @ApiProperty({ required: true })
  message: string; // The message content
}

export class ChatDto {
  @IsNotEmpty()
  @IsString()
  @ApiProperty({ required: true })
  userId: string;

  @IsNotEmpty({ each: true })
  @ApiProperty({ type: ChatMessageDto, required: true, isArray: true })
  messages: ChatMessageDto[];
}
