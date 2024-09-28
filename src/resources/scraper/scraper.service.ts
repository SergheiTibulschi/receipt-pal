import { Injectable } from '@nestjs/common';
import { ScrapeMe } from './helpers';

@Injectable()
export class ScraperService {
  async getHtml(scraper: ScrapeMe): Promise<string> {
    return await scraper.scrape();
  }
}
