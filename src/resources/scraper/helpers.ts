import axios from 'axios';
import * as cheerio from 'cheerio';

export class ScrapeMe {
  constructor(
    public url: string,
    public selector: string,
  ) {}

  async scrape() {
    try {
      const { data } = await axios.get(this.url);
      const $ = cheerio.load(data);
      return $(this.selector).prop('outerHTML');
    } catch (error) {
      throw new Error(`Error scraping the webpage: ${error.message}`);
    }
  }
}
