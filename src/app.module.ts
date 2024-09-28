import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { SupabaseModule } from './resources/supabase';
import { ConfigModule } from '@nestjs/config';
import { ReceiptsModule } from './resources/receipts/receipts.module';
import { ScraperService } from './resources/scraper/scraper.service';
import { ScraperModule } from './resources/scraper/scraper.module';
import { AssistantService } from './resources/assistant/assistant.service';

@Module({
  imports: [
    ConfigModule.forRoot(),
    SupabaseModule,
    ReceiptsModule,
    ScraperModule,
  ],
  controllers: [AppController],
  providers: [AppService, ScraperService, AssistantService],
})
export class AppModule {}
