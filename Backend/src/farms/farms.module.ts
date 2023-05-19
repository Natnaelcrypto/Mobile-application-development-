import { Module } from '@nestjs/common';
import { FarmsController } from './farms.controller';
import { FarmsService } from './farms.service';
import { farmSchema } from './farm.model';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [MongooseModule.forFeature([{ name: 'Farm', schema: farmSchema }]),AuthModule],
  controllers: [FarmsController],
  providers: [FarmsService],
})
export class FarmsModule {}
