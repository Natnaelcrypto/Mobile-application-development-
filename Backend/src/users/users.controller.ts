import { Body, Controller, Get, Param, Patch, Delete } from '@nestjs/common';
import { UsersService } from './users.service';

@Controller('api/v1/users')
export class UsersController {
  constructor(private readonly userService: UsersService) {}
  @Get()
  find_users() {
    return this.userService.find_users();
  }

  @Get('user')
  find_user(@Body() user: any) {
    return this.userService.find_user(user);
  }

  @Patch()
  update_user(@Body() user: any) {
    return this.userService.update_user(user);
  }

  @Delete(':id')
  delete_users(@Param('id') id: any) {
    return this.userService.delate_user(id);
  }
}
