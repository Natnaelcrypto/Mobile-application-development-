import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Request,
} from "@nestjs/common";
import { InformationsService } from "./informations.service";

@Controller("api/v1/informations")
export class InformationsController {
  constructor(private readonly informationService: InformationsService) {}
  @Get()
  find_infos(@Request() req: any) {
    const find_user = req.user;
    return this.informationService.find_infos();
  }
  @Get()
  find_info(@Body() data: any, @Request() req: any) {
    const find_user = req.user;
    return this.informationService.find_info(data);
  }
  @Post()
  create_info(@Body() data:any, @Request() req: any) {
    const find_user = req.user;
    return this.informationService.create(data);
  }
  @Patch(":id")
  update(@Param("id") id: any, @Body() data:any, @Request() req: any) {
    const find_user = req.user;
    return this.informationService.Update_info(id, data);
  }
  @Delete("id")
  delate(@Param("id") id: any, @Request() req: any) {
    const find_user = req.user;
    return this.informationService.delate(id);
  }
}
