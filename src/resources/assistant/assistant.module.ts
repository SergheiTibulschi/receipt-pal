import { Module } from '@nestjs/common';
import { AssistantService } from './assistant.service';
import { SupabaseModule } from '../supabase';

@Module({
  imports: [SupabaseModule],
  providers: [AssistantService],
  exports: [AssistantService],
})
export class AssistantModule {}
