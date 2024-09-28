import { Injectable } from '@nestjs/common';
import { ScraperService } from '../scraper/scraper.service';
import { ReceiptUrlDTO } from './dto/receipt-url.dto';
import { ScrapeMe } from '../scraper/helpers';
import { AssistantService } from '../assistant/assistant.service';

@Injectable()
export class ReceiptsService {
  constructor(
    private scrapperService: ScraperService,
    private assistantService: AssistantService,
  ) {}

  async create(createReceiptDto: ReceiptUrlDTO) {
    const html = await this.scrapperService.getHtml(
      new ScrapeMe(createReceiptDto.url, '#newFormTest'),
    );
    await this.assistantService.parseHtml(html);
    return html;
  }

  findAll() {
    return `This action returns all receipts`;
  }

  findOne(id: number) {
    return `This action returns a #${id} receipt`;
  }

  remove(id: number) {
    return `This action removes a #${id} receipt`;
  }
}
