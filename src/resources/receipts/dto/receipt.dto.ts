import { IsString, IsNumber, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';

class ItemDTO {
  @IsString()
  @ApiProperty()
  description: string;

  @ApiProperty({ type: 'integer' })
  @IsNumber()
  quantity: number;

  @IsNumber()
  @ApiProperty({ type: 'integer' })
  unitPrice: number;

  @IsString()
  @ApiProperty()
  amount: string;
}

class VatDetailDTO {
  @IsString()
  @ApiProperty()
  percentage: string;

  @IsNumber()
  @ApiProperty({ type: 'integer' })
  amount: number;
}

class TotalDTO {
  @IsNumber()
  @ApiProperty({ type: 'integer' })
  amount: number;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => VatDetailDTO)
  @ApiProperty({ type: VatDetailDTO, isArray: true })
  vat: VatDetailDTO[];

  @IsString()
  @ApiProperty()
  paymentMethod: string;
}

class TransactionDetailsDTO {
  @IsString()
  @ApiProperty()
  date: string;

  @IsString()
  @ApiProperty()
  time: string;

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

  @ValidateNested()
  @Type(() => TotalDTO)
  @ApiProperty({ type: TotalDTO })
  total: TotalDTO;

  @ValidateNested()
  @Type(() => TransactionDetailsDTO)
  @ApiProperty({ type: TransactionDetailsDTO })
  transactionDetails: TransactionDetailsDTO;
}
