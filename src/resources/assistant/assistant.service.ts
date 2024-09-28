import { Injectable } from '@nestjs/common';
import { Configuration, OpenAIApi } from 'openai';

@Injectable()
export class AssistantService {
  private openai: OpenAIApi;

  constructor() {
    const configuration = new Configuration({
      apiKey: process.env.OPENAI_API_KEY, // Make sure to set this in your .env file
    });
    this.openai = new OpenAIApi(configuration);
  }

  async formatReceiptHtmlToJSON(html: string): Promise<string> {
    const prompt = `Here is the receipt HTML: ${html}. Format it into the correct JSON structure according to the following DTO structure: [provide the DTO structure here].`;

    try {
      const response = await this.openai.createChatCompletion({
        model: 'gpt-4',
        messages: [
          {
            role: 'system',
            content:
              'You are an expert in formatting receipts into JSON according to a specific DTO structure.',
          },
          { role: 'user', content: prompt },
        ],
      });

      // Get the AI's response and extract the formatted JSON
      const assistantResponse = response.data.choices[0].message.content;
      return assistantResponse;
    } catch (error) {
      throw new Error(
        `Failed to generate JSON from receipt HTML: ${error.message}`,
      );
    }
  }
}
