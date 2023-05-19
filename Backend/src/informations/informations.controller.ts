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
  
} from "@nestjs/common";
import { InformationsService } from "./informations.service";
import { AuthGuard } from '@nestjs/passport';

@Controller('api/v1/informations')
export class InformationsController {
  constructor(private readonly informationService: InformationsService) {}
  @UseGuards(AuthGuard('jwt'))
  @Get()
  find_infos(@Request() req: any) {
    const find_user = req.user;
    return this.informationService.find_infos();
  }

  @UseGuards(AuthGuard('jwt'))
  @Get()
  find_info(@Body() data: any, @Request() req: any) {
    const find_user = req.user;
    return this.informationService.find_info(data);
  }

  @UseGuards(AuthGuard('jwt'))
  @Post()
  create_info(@Body() data: any, @Request() req: any) {
    const find_user = req.user;
    return this.informationService.create(data);
  }

  @UseGuards(AuthGuard('jwt'))
  @Patch(':id')
  update(@Param('id') id: any, @Body() data: any, @Request() req: any) {
    const find_user = req.user;
    return this.informationService.Update_info(id, data);
  }

  @UseGuards(AuthGuard('jwt'))
  @Delete('id')
  delate(@Param('id') id: any, @Request() req: any) {
    const find_user = req.user;
    return this.informationService.delate(id);
  }
}
