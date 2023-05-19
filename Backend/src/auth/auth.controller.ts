import {
  Body,
  Controller,
  Get,
  Post,
  UseGuards,
  Request,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { AuthService } from './auth.service';

@Controller('api/v1/auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  login(@Body() user: any) {
    return this.authService.login(user);
  }

  @Post('signup')
  signup(@Body() user: any) {
    return this.authService.signup(user);
  }

  @UseGuards(AuthGuard('jwt'))
  @Get('user')
  async user(@Request() req: any) {
    return req.user;
  }
}
