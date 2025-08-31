import { Module, Global } from '@nestjs/common';
import { Pool } from 'pg';

@Global()
@Module({
  providers: [
    {
      provide: 'PG_POOL',
      useFactory: async () => {
        const pool = new Pool({ connectionString: process.env.DATABASE_URL });
        // fail fast if DB is unreachable
        await pool.query('SELECT 1');
        return pool;
      },
    },
  ],
  exports: ['PG_POOL'],
})
export class PgModule {}

