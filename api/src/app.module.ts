import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { PgModule } from './db/pg.module';
import { EventsModule } from './events/events.module';
import { HealthModule } from './health/health.module';

@Module({
  imports: [    
    ConfigModule.forRoot({ isGlobal: true }), // <-- load .env
    PgModule, 
    EventsModule, 
    HealthModule
  ],
})
export class AppModule {}

