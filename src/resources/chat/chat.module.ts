import { Module } from '@nestjs/common';
import { ChatService } from './chat.service';
import { ChatController } from './chat.controller';
import { SupabaseModule } from '../supabase';
import { AssistantModule } from '../assistant/assistant.module';

@Module({
  controllers: [ChatController],
  providers: [ChatService],
  imports: [AssistantModule, SupabaseModule],
})
export class ChatModule {}
