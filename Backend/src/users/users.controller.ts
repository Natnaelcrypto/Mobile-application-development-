import {
  Body,
  Controller,
  Get,
  Param,
  Patch,
  Delete,
  Post,
} from '@nestjs/common';
import { UsersService } from './users.service';

@Controller('api/v1/users')
export class UsersController {
  constructor(private readonly userService: UsersService) {}
  @Get(':farmname')
  find_users(@Param('farmname') farmname: any) {
    console.log(farmname);
    return this.userService.find_users(farmname);
  }

  @Patch(':id')
  update_user(@Body() user: any, @Param('id') id: any) {
    return this.userService.update_user(id,user);
  }

  @Post()
  create_user(@Body() user: any) {
    return this.userService.create_User(user);
  }

  @Delete(':id')
  delete_users(@Param('id') id: any) {
    console.log(id);
    return this.userService.delate_user(id);
  }
}
