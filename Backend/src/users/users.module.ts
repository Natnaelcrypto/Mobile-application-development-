import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UserSchema } from './user.model';
import { MongooseModule } from '@nestjs/mongoose';
import { UsersController } from './users.controller';
@Module({
  imports: [MongooseModule.forFeature([{ name: 'User', schema: UserSchema }])],
  controllers: [UsersController],
  providers: [UsersService],
  exports:[UsersService]
})
export class UsersModule {}
