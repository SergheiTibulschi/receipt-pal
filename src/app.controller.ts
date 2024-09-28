import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { Supabase } from './resources/supabase';

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private readonly supabase: Supabase,
  ) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('supabase')
  getSupabase() {
    const client = this.supabase.getClient();
    return client.from('receipts').select();
  }
}
