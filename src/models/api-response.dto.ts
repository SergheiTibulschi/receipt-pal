import { ApiProperty } from '@nestjs/swagger';
import { IsOptional } from 'class-validator';

export class ApiResponseDto<T> {
  @ApiProperty({ nullable: true })
  data: T | null;

  @ApiProperty({ nullable: true })
  @IsOptional()
  error?: string | null;
}
