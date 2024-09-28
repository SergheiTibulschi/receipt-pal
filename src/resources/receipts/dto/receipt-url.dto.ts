import { IsString, Matches } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class ReceiptUrlDTO {
  @IsString()
  @Matches(/https:\/\/([a-zA-Z0-9-]+)?mev\.sfs\.md/i, {
    message:
      "Hey there! It looks like the link you've entered doesn't match a valid receipt. Please double-check the URL, my friend!",
  })
  @ApiProperty()
  url: string;
}
