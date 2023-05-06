import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { InformationsModule } from './informations/informations.module';
import { UsersModule } from './users/users.module';

@Module({
  imports: [InformationsModule, UsersModule ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
