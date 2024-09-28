import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { ReceiptsService } from './receipts.service';
import { ReceiptUrlDTO } from './dto/receipt-url.dto';

@Controller('receipts')
export class ReceiptsController {
  constructor(private readonly receiptsService: ReceiptsService) {}

  @Post()
  create(@Body() createReceiptDto: ReceiptUrlDTO) {
    return this.receiptsService.create(createReceiptDto);
  }

  @Get()
  findAll() {
    return this.receiptsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.receiptsService.findOne(+id);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.receiptsService.remove(+id);
  }
}
