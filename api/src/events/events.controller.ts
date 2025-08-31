import { Body, Controller, Get, Headers, Inject, Param, Post, Query } from '@nestjs/common';
import { fromZodError } from 'zod-validation-error';
import { EventSchema, RecordDailySchema } from './dto';
import { EventsService } from './events.service';

@Controller()
export class EventsController {
  constructor(private svc: EventsService) {}

  @Post('events')
  async postEvent(@Body() body: any, @Headers('idempotency-key') idem?: string) {
    const parsed = EventSchema.safeParse(body);
    if (!parsed.success) {
      throw fromZodError(parsed.error);
    }
    return this.svc.insertEvent({ ...parsed.data, idempotencyKey: idem });
  }

  @Post('commands/record-daily-total')
  async recordDaily(@Body() body: any, @Headers('idempotency-key') idem?: string) {
    const parsed = RecordDailySchema.safeParse(body);
    if (!parsed.success) {
      throw fromZodError(parsed.error);
    }
    return this.svc.recordDailyTotal({ ...parsed.data, idempotencyKey: idem });
  }

  @Get('metrics/:key/series')
  async series(@Param('key') key: string, @Query('from') from?: string, @Query('to') to?: string) {
    return this.svc.series(key, from, to);
  }
}

