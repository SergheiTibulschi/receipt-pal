import { Injectable } from '@nestjs/common';
import { AssistantService } from '../assistant/assistant.service';

@Injectable()
export class ChatService {
  constructor(private assistantService: AssistantService) {}

  async getChat(userId: string) {
    return this.assistantService.startConversation(userId);
  }

  async sendMessage(userId: string, message: string): Promise<string> {
    return this.assistantService.sendMessage(userId, message);
  }
}
