import { IsString, Matches } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class ReceiptUrlDTO {
  @IsString()
  @Matches(
    /^https:\/\/mev\.sfs\.md\/receipt-verifier\/[A-Z0-9]+\/\d+\.\d{2}\/\d+\/\d{4}-\d{2}-\d{2}$/,
    {
      message:
        "Hey there! It looks like the link you've entered doesn't match a valid receipt. Please double-check the URL, my friend!",
    },
  )
  @ApiProperty()
  url: string;
}
