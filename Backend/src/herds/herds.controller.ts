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
  UseGuards,
} from '@nestjs/common';

@Controller('api/v1/herds')
export class HerdsController {
  constructor(private readonly herdService: HerdsService) {}

  @UseGuards(AuthGuard('jwt'))
  @Get(':id')
  find_herd(@Param('id') id: any, @Request() req: any) {
    const find_user = req.user;
    return this.herdService.find_herd(id);
  }

  @UseGuards(AuthGuard('jwt'))
  @Get()
  find_herds(@Body() date: any, @Request() req: any) {
    const find_user = req.user;
    return this.herdService.find_herds(date);
  }
  @UseGuards(AuthGuard('jwt'))
  @Post()
  create_herd(@Body() date: any, @Request() req: any) {
    const find_user = req.user;
    return this.herdService.create_herd(date);
  }
  @UseGuards(AuthGuard('jwt'))
  @Patch(':id')
  update_herd(@Body() data: any, @Param() id: any, @Request() req: any) {
    const find_user = req.user;
    return this.herdService.Update_herd(id, data);
  }
  
  @UseGuards(AuthGuard('jwt'))
  @Delete(':id')
  delate_herd(@Param('id') herdId, @Request() req: any) {
    const find_user = req.user;
    return this.herdService.delate(herdId);
  }
}
