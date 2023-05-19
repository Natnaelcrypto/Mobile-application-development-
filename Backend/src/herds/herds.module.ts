import { Module } from '@nestjs/common';
import { HerdsController } from './herds.controller';
import { HerdsService } from './herds.service';
import { herdSchema } from './herd.model';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  imports: [MongooseModule.forFeature([{ name: 'Herd', schema: herdSchema }])],
  controllers: [HerdsController],
  providers: [HerdsService],
})
export class HerdsModule {}
