import { IsString, IsNumber, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export class ReceiptDTO {
  @IsString()
  companyName: string;

  @IsString()
  fiscalCode: string;

  @IsString()
  address: string;

  @IsString()
  registrationNumber: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ItemDTO)
  items: ItemDTO[];

  @ValidateNested()
  @Type(() => TotalDTO)
  total: TotalDTO;

  @ValidateNested()
  @Type(() => TransactionDetailsDTO)
  transactionDetails: TransactionDetailsDTO;
}

class ItemDTO {
  @IsString()
  description: string;

  @IsNumber()
  quantity: number;

  @IsNumber()
  unitPrice: number;

  @IsString()
  amount: string;
}

class TotalDTO {
  @IsNumber()
  amount: number;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => VatDetailDTO)
  vat: VatDetailDTO[];

  @IsString()
  paymentMethod: string;
}

class VatDetailDTO {
  @IsString()
  percentage: string;

  @IsNumber()
  amount: number;
}

class TransactionDetailsDTO {
  @IsString()
  date: string;

  @IsString()
  time: string;

  @IsString()
  fiscalReceiptNumber: string;

  @IsString()
  manufacturingNumber: string;

  @IsString()
  receiptId: string;
}
