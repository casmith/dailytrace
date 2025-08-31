import { Controller, Get, Inject } from '@nestjs/common';
import { Pool } from 'pg';

@Controller('health')
export class HealthController {
  constructor(@Inject('PG_POOL') private pool: Pool) {}
  @Get()
  async get() {
    const r = await this.pool.query('SELECT now() as now');
    return { ok: true, now: r.rows[0].now };
  }
}
