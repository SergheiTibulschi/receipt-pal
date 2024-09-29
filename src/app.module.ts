import { MiddlewareConsumer, Module } from '@nestjs/common';
import { SupabaseModule } from './resources/supabase';
import { ConfigModule } from '@nestjs/config';
import { ReceiptsModule } from './resources/receipts/receipts.module';
import { ScraperService } from './resources/scraper/scraper.service';
import { ScraperModule } from './resources/scraper/scraper.module';
import { AssistantService } from './resources/assistant/assistant.service';
import { AssistantModule } from './resources/assistant/assistant.module';
import { ChatModule } from './resources/chat/chat.module';
import { LoggingMiddleware } from './middleware/logging.middleware';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    SupabaseModule,
    ReceiptsModule,
    ScraperModule,
    AssistantModule,
    ChatModule,
  ],
  controllers: [],
  providers: [ScraperService, AssistantService],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(LoggingMiddleware).forRoutes('*');
  }
}
