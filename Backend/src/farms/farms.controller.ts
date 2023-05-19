import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
  Request,
} from '@nestjs/common';
import { FarmsService } from './farms.service';
import { AuthGuard } from '@nestjs/passport';

@Controller('api/v1/farms')
export class FarmsController {
  constructor(private readonly farmService: FarmsService) {}

  @UseGuards(AuthGuard('jwt')) 
  //  we used the jwt authtication to check the requestes 
  //  are made by valid user by taking the authtiaction token 
  //  for all end pointes to privent unauthorized access.

  @Get(':id')
  find_farm(@Param('id') userID: any, @Request() req: any) {
    const find_user = req.user;
    return this.farmService.find_farme(userID);
  }

  @UseGuards(AuthGuard('jwt'))
  @Get()
  find_farms(@Request() req: any) {
    const find_user = req.user;
    return this.farmService.find_farmes();
  }
  
  @UseGuards(AuthGuard('jwt'))
  @Post()
  create_farm(@Body() date: any, @Request() req: any) {
    const find_user = req.user;
    return this.farmService.create_farm(date);
  }

  @UseGuards(AuthGuard('jwt'))
  @Patch(':id')
  update_farm(@Body() data: any, @Param() id: any, @Request() req: any) {
    const find_user = req.user;
    return this.farmService.update(data, id);
  }

  @UseGuards(AuthGuard('jwt'))
  @Delete(':id')
  delate_farm(@Param('id') farmId, @Request() req: any) {
    const find_user = req.user;
    return this.farmService.delate_farm(farmId);
  }
}
