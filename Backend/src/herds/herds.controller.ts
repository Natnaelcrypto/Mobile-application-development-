import { AuthGuard } from '@nestjs/passport';
import { HerdsService } from './herds.service';
import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Request,
} from '@nestjs/common';

@Controller('api/v1/herds')
export class HerdsController {
  constructor(private readonly herdService: HerdsService) {}

  @Get('single/:id')
  find_herd(@Param('id') id: any, @Request() req: any) {
    return this.herdService.find_herd(id);
  }

  @Get(':farmname')
  find_herds(@Param('farmname') farmname: any) {
    return this.herdService.find_herds(farmname);
  }

  @Post()
  create_herd(@Body() date: any, @Request() req: any) {
    return this.herdService.create_herd(date);
  }
  @Patch(':id')
  update_herd(@Body() data: any, @Param() id: any) {
    return this.herdService.Update_herd(id, data);
  }


  @Delete(':id')
  delate_herd(@Param('id') herdId, @Request() req: any) {
    return this.herdService.delate(herdId);
  }
}
