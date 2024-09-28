import {
  IsString,
  IsNumber,
  IsArray,
  ValidateNested,
  IsDateString,
} from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';

class ItemDTO {
  @IsString()
  @ApiProperty()
  description: string;

  @IsNumber()
  @ApiProperty({ type: 'number' })
  quantity: number;

  @IsNumber()
  @ApiProperty({ type: 'number' })
  unitPrice: number;

  @IsString()
  @ApiProperty()
  amount: string;

  @IsString()
  @ApiProperty()
  vatPercentage: string;

  @IsNumber()
  @ApiProperty({ type: 'number' })
  vatAmount: number;
}

class TransactionDetailsDTO {
  @IsDateString()
  @ApiProperty({ type: 'string', format: 'date-time' })
  purchasedAt: string;

  @IsString()
  @ApiProperty()
  fiscalReceiptNumber: string;

  @IsString()
  @ApiProperty()
  manufacturingNumber: string;
}

export class ReceiptDTO {
  @IsString()
  @ApiProperty()
  companyName: string;

  @IsString()
  @ApiProperty()
  fiscalCode: string;

  @IsString()
  @ApiProperty()
  address: string;

  @IsString()
  @ApiProperty()
  registrationNumber: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ItemDTO)
  @ApiProperty({ type: ItemDTO, isArray: true })
  items: ItemDTO[];

  @IsNumber()
  @ApiProperty({ type: 'number' })
  totalAmount: number;

  @IsString()
  @ApiProperty()
  paymentMethod: string;

  @ValidateNested()
  @Type(() => TransactionDetailsDTO)
  @ApiProperty({ type: TransactionDetailsDTO })
  transactionDetails: TransactionDetailsDTO;

  @IsString()
  @ApiProperty()
  receiptId: string;
}
