import { Module } from "@nestjs/common";
import { InformationsController } from "./informations.controller";
import { InformationsService } from "./informations.service";


@Module({
  imports: [],
  controllers: [InformationsController],
  providers: [InformationsService],
})
export class InformationsModule {}
