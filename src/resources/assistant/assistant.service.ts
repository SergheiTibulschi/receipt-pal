import { Injectable } from '@nestjs/common';
import { OpenAI } from 'openai';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AssistantService {
  client: OpenAI;

  constructor(private config: ConfigService) {
    this.client = new OpenAI({
      apiKey: config.get('OPENAI_API_KEY'),
    });
  }

  async parseHtml(html: string) {
    const assistant = await this.client.beta.assistants.retrieve(
      this.config.get('OPENAI_ASSISTANT_ID'),
    );
    const thread = await this.client.beta.threads.create();
    await this.client.beta.threads.messages.create(thread.id, {
      role: 'user',
      content: html,
    });
    const run = await this.client.beta.threads.runs.createAndPoll(thread.id, {
      assistant_id: assistant.id,
    });

    if (run.status === 'completed') {
      const messages = await this.client.beta.threads.messages.list(
        run.thread_id,
      );

      for (const message of messages.data.reverse()) {
        if (
          message.content[0].type === 'text' &&
          message.role === 'assistant'
        ) {
          try {
            const response = JSON.parse(message.content[0].text.value);
            console.log(response);
          } catch {
            throw new Error('Error parsing the assistant response');
          }
        }
      }
    } else {
      throw new Error(`Error running the assistant: ${run.status}`);
    }
  }
}
