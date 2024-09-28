import { Injectable } from '@nestjs/common';
import { ScraperService } from '../scraper/scraper.service';
import { ReceiptUrlDTO } from './dto/receipt-url.dto';
import { ScrapeMe } from '../scraper/helpers';
import { AssistantService } from '../assistant/assistant.service';
import { Supabase } from '../supabase';
import { ReceiptItemInsert } from '../../types/receipts';
import { PaginationQueryDto } from '../../models/paginatio-query.dto';
import { ReceiptDTO } from './dto/receipt.dto';

@Injectable()
export class ReceiptsService {
  constructor(
    private scrapperService: ScraperService,
    private assistantService: AssistantService,
    private supabase: Supabase,
  ) {}

  async create(createReceiptDto: ReceiptUrlDTO) {
    const { data: existingReceipt } = await this.supabase
      .getClient()
      .from('receipts')
      .select('receipt_id')
      .eq('receipt_id', createReceiptDto.url)
      .single();

    if (existingReceipt) {
      throw new Error('Receipt already exists');
    }

    const html = await this.scrapperService.getHtml(
      new ScrapeMe(createReceiptDto.url, '#newFormTest'),
    );
    const receipt = await this.assistantService.parseHtml(html);

    const { error: receiptError } = await this.supabase
      .getClient()
      .from('receipts')
      .insert([
        {
          company_name: receipt.companyName,
          fiscal_code: receipt.fiscalCode,
          address: receipt.address,
          registration_number: receipt.registrationNumber,
          fiscal_receipt_number: receipt.transactionDetails.fiscalReceiptNumber,
          manufacturing_number: receipt.transactionDetails.manufacturingNumber,
          receipt_id: createReceiptDto.url,
          purchased_at: receipt.transactionDetails.purchasedAt,
          payment_method: receipt.paymentMethod,
          total_amount: receipt.totalAmount,
        },
      ]);

    if (receiptError) {
      throw new Error(`Failed to insert receipt: ${receiptError.message}`);
    }

    const items: ReceiptItemInsert[] = receipt.items.map((item) => ({
      receipt_id: createReceiptDto.url, // Assuming receiptData contains the inserted receipt with ID
      description: item.description,
      quantity: item.quantity,
      unit_price: item.unitPrice,
      amount: item.amount,
      vat_amount: item.vatAmount,
      vat_percentage: item.vatPercentage,
    }));

    const { error: itemsError } = await this.supabase
      .getClient()
      .from('receipt_items')
      .insert(items);

    if (itemsError) {
      throw new Error(`Failed to insert receipt items: ${itemsError.message}`);
    }

    return {
      ...receipt,
      receiptId: createReceiptDto.url,
    };
  }

  async findAll(paginationQuery: PaginationQueryDto): Promise<ReceiptDTO[]> {
    const { page, limit } = paginationQuery;

    const { data, error } = await this.supabase
      .getClient()
      .from('receipts')
      .select(
        `
    *,
    receipt_items (
      description, quantity, unit_price, amount, vat_percentage, vat_amount
    )
  `,
      )
      .range(page, limit);

    if (error) {
      throw new Error(`We failed to fetch your receipts. Sorry...`);
    }

    return data.map(
      (receipt) =>
        ({
          companyName: receipt.company_name,
          fiscalCode: receipt.fiscal_code,
          address: receipt.address,
          registrationNumber: receipt.registration_number,
          receiptId: receipt.receipt_id,
          transactionDetails: {
            purchasedAt: receipt.purchased_at,
            fiscalReceiptNumber: receipt.fiscal_receipt_number,
            manufacturingNumber: receipt.manufacturing_number,
          },
          totalAmount: receipt.total_amount,
          paymentMethod: receipt.payment_method,
          items: receipt.receipt_items.map((item) => ({
            description: item.description,
            quantity: item.quantity,
            unitPrice: item.unit_price,
            amount: item.amount,
            vatAmount: item.vat_amount,
            vatPercentage: item.vat_percentage,
          })),
        }) as ReceiptDTO,
    );
  }

  findOne(id: number) {
    return `This action returns a #${id} receipt`;
  }

  remove(id: number) {
    return `This action removes a #${id} receipt`;
  }
}
