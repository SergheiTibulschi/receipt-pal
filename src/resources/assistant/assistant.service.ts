import { Injectable } from '@nestjs/common';
import { OpenAI } from 'openai';
import { ConfigService } from '@nestjs/config';
import { ReceiptDTO } from '../receipts/dto/receipt.dto';
import { Supabase } from '../supabase';
import { ChatDto } from '../chat/dto/chat.dto';

@Injectable()
export class AssistantService {
  client: OpenAI;

  constructor(
    private config: ConfigService,
    private supabase: Supabase,
  ) {
    this.client = new OpenAI({
      apiKey: config.get('OPENAI_API_KEY'),
    });
  }

  async parseHtml(html: string): Promise<ReceiptDTO> {
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
      let receipt: ReceiptDTO;

      for (const message of messages.data.reverse()) {
        if (
          message.content[0].type === 'text' &&
          message.role === 'assistant'
        ) {
          try {
            receipt = JSON.parse(message.content[0].text.value) as ReceiptDTO;
          } catch (error) {
            throw new Error('Error parsing the assistant response');
          }
        }
      }

      return receipt;
    } else {
      throw new Error(`Error running the assistant: ${run.status}`);
    }
  }

  async startConversation(userId: string): Promise<ChatDto> {
    const { data: thread } = await this.supabase
      .getClient()
      .from('threads')
      .select('thread_id, mega_message_id')
      .eq('user_id', userId)
      .single();

    if (thread) {
      const messages = await this.client.beta.threads.messages.list(
        thread.thread_id,
      );

      return {
        userId,
        messages: messages.data
          .filter((message) => message.id !== thread.mega_message_id)
          .map((message) => ({
            role: message.role,
            message:
              message.content[0].type === 'text'
                ? message.content[0].text.value
                : '',
          })),
      };
    }

    const newThread = await this.client.beta.threads.create();

    const { data: receipts, error } = await this.supabase
      .getClient()
      .from('receipts').select(`
      *,
      receipt_items (
        description, quantity, unit_price, amount, vat_percentage, vat_amount, product_type
      )
    `);

    if (error) {
      throw new Error('Error fetching receipts');
    }

    let message = '';
    for (const receipt of receipts) {
      let receiptMessage = `
      RECEIPT_${receipt.id}_START:
      Receipt ID: ${receipt.id}
      Date: ${receipt.purchased_at}
      Total Amount: ${receipt.total_amount}
    `;

      await this.client.beta.threads.messages.create(newThread.id, {
        role: 'assistant',
        content: receiptMessage,
      });

      // Insert each receipt item as a message in the thread
      for (const item of receipt.receipt_items) {
        const itemMessage = `
        ITEM_START:
        Item: ${item.description},
        Quantity: ${item.quantity},
        Unit Price: ${item.unit_price},
        Amount: ${item.amount},
        VAT Percentage: ${item.vat_percentage},
        VAT Amount: ${item.vat_amount},
        Product Type: ${item.product_type}:ITEM_END;
      `;

        receiptMessage += itemMessage;
      }

      receiptMessage += `RECEIPT_${receipt}_END;`;
      message += receiptMessage;
    }

    const megaMessage = await this.client.beta.threads.messages.create(
      newThread.id,
      {
        role: 'user', // Add this as a user message, adjust role if needed
        content: message,
      },
    );

    await this.supabase.getClient().from('threads').insert({
      user_id: userId,
      thread_id: newThread.id,
      mega_message_id: megaMessage.id,
    });

    return {
      userId,
      messages: [],
    };
  }

  async sendMessage(userId: string, message: string): Promise<string> {
    const { data: thread } = await this.supabase
      .getClient()
      .from('threads')
      .select('thread_id')
      .eq('user_id', userId)
      .single();

    if (!thread) {
      throw new Error('Thread not found');
    }

    const assistant = await this.client.beta.assistants.retrieve(
      this.config.get('OPENAI_CHAT_ASSISTANT_ID'),
    );

    await this.client.beta.threads.messages.create(thread.thread_id, {
      role: 'user',
      content: message,
    });

    const run = await this.client.beta.threads.runs.createAndPoll(
      thread.thread_id,
      {
        assistant_id: assistant.id,
      },
    );

    if (run.status === 'completed') {
      const messages = await this.client.beta.threads.messages.list(
        run.thread_id,
      );
      const message = messages.data[0].content[0];
      return message.type === 'text' ? message.text.value : '';
    } else {
      throw new Error(`Error running the assistant: ${run.status}`);
    }
  }
}
