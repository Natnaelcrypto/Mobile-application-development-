import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { InformationsModule } from './informations/informations.module';

@Module({
  imports: [InformationsModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
