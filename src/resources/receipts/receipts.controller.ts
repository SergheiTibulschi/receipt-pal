import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { ReceiptsService } from './receipts.service';
import { ReceiptUrlDTO } from './dto/receipt-url.dto';
import { ApiOperation } from '@nestjs/swagger';
import { ApiGenericResponse } from '../../decorators/api-generic-response.decorator';
import { ReceiptDTO } from './dto/receipt.dto';
import { ApiResponseDto } from '../../models/api-response.dto';

@Controller('receipts')
export class ReceiptsController {
  constructor(private readonly receiptsService: ReceiptsService) {}

  @Post()
  @ApiOperation({ operationId: 'create-receipt' })
  @ApiGenericResponse(ReceiptDTO)
  async create(
    @Body() createReceiptDto: ReceiptUrlDTO,
  ): Promise<ApiResponseDto<ReceiptDTO>> {
    try {
      const data = await this.receiptsService.create(createReceiptDto);
      return { data, error: null };
    } catch (error) {
      return { data: null, error: error.message };
    }
  }

  @Get()
  @ApiOperation({ operationId: 'get-all-receipts' })
  @ApiGenericResponse(ReceiptDTO, true)
  async findAll() {
    try {
      const data = await this.receiptsService.findAll();
      return { data, error: null };
    } catch (error) {
      return { data: null, error: error.message };
    }
  }

  @Get(':id')
  @ApiOperation({ operationId: 'get-receipt-by-id' })
  findOne(@Param('id') id: string) {
    return this.receiptsService.findOne(+id);
  }

  @Delete(':id')
  @ApiOperation({ operationId: 'delete-receipt-by-id' })
  remove(@Param('id') id: string) {
    return this.receiptsService.remove(+id);
  }
}
