import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { JwtModule } from '@nestjs/jwt';
import { UsersModule } from 'src/users/users.module';
import { JwtStrategy } from './jwt.strategy';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    JwtModule.register({
      secret: process.env.secret,
      signOptions: { expiresIn: process.env.token_time },
    }),
    UsersModule,
  ],
  controllers: [AuthController],
  providers: [AuthService, JwtModule, JwtStrategy],
  exports: [AuthService],
})
export class AuthModule {}
