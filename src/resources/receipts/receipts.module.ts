import { Module } from '@nestjs/common';
import { ReceiptsService } from './receipts.service';
import { ReceiptsController } from './receipts.controller';
import { ScraperModule } from '../scraper/scraper.module';

@Module({
  controllers: [ReceiptsController],
  providers: [ReceiptsService],
  imports: [ScraperModule],
})
export class ReceiptsModule {}
