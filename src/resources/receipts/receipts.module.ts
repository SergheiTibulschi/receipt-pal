import { Module } from '@nestjs/common';
import { ReceiptsService } from './receipts.service';
import { ReceiptsController } from './receipts.controller';
import { ScraperModule } from '../scraper/scraper.module';
import { AssistantModule } from '../assistant/assistant.module';

@Module({
  controllers: [ReceiptsController],
  providers: [ReceiptsService],
  imports: [ScraperModule, AssistantModule],
})
export class ReceiptsModule {}
