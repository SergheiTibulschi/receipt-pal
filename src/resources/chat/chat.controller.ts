import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { ChatService } from './chat.service';
import { ApiOperation } from '@nestjs/swagger';
import { ApiGenericResponse } from '../../decorators/api-generic-response.decorator';
import { ReceiptDTO } from '../receipts/dto/receipt.dto';
import { ChatMessageDto } from './dto/chat-message.dto';
import { MessageResponseDto } from './dto/message-response.dto';

@Controller('chat')
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Get(':userId')
  @ApiOperation({ operationId: 'get-chat' })
  @ApiGenericResponse(ReceiptDTO)
  async getChat(@Param('userId') userId: string) {
    return this.chatService.getChat(userId);
  }

  @Post(':userId')
  @ApiOperation({ operationId: 'send-message' })
  @ApiGenericResponse(MessageResponseDto)
  async sendMessage(
    @Param('userId') userId: string,
    @Body() body: ChatMessageDto,
  ) {
    try {
      const response = await this.chatService.sendMessage(userId, body.message);
      return { data: response, error: null };
    } catch {
      return { data: null, error: 'Error sending the message' };
    }
  }
}
