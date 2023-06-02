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
  Put,
} from '@nestjs/common';
import { FarmsService } from './farms.service';
import { AuthGuard } from '@nestjs/passport';

@Controller('api/v1/farms')
export class FarmsController {
  constructor(private readonly farmService: FarmsService) {}

  // @Get(':id')
  // find_farm(@Param('id') userID: any, @Request() req: any) {
  //   const find_user = req.user;
  //   return this.farmService.find_farme(userID);
  // }

  @Get(':farmname')
  find_farms(@Param('farmname') farmName:any) {
    return this.farmService.find_farmes(farmName);
  }

  @Post()
  create_farm(@Body() date: any, @Request() req: any) {
    return this.farmService.create_farm(date);
  }

  @Put(':id')
  update_farm(@Body() data: any, @Param() id: any, @Request() req: any) {
    return this.farmService.update(data, id.id);
  }

  @Delete(':id')
  delate_farm(@Param('id') farmId, @Request() req: any) {
    const find_user = req.user;
    return this.farmService.delate_farm(farmId);
  }
}
