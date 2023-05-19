import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { InformationsModule } from './informations/informations.module';
import { UsersModule } from './users/users.module';
import { MongooseModule } from '@nestjs/mongoose';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { JwtModule } from '@nestjs/jwt';

@Module({
  imports: [InformationsModule,
            UsersModule,
            AuthModule,
            ConfigModule.forRoot({ isGlobal: true }),
            MongooseModule.forRoot(process.env.DB_URL),
            JwtModule.register({
              secret: process.env.secret,
              signOptions: { expiresIn: process.env.token_time },
            }),
           ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
