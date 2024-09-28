import { Module } from '@nestjs/common';
import { ReceiptsService } from './receipts.service';
import { ReceiptsController } from './receipts.controller';
import { ScraperModule } from '../scraper/scraper.module';
import { AssistantModule } from '../assistant/assistant.module';
import { SupabaseModule } from '../supabase';

@Module({
  controllers: [ReceiptsController],
  providers: [ReceiptsService],
  imports: [ScraperModule, AssistantModule, SupabaseModule],
})
export class ReceiptsModule {}
