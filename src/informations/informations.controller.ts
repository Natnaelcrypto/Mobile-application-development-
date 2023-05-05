import { Controller, Get } from "@nestjs/common";
import { InformationsService } from "./informations.service";

@Controller("api/v1/informations")
export class InformationsController {
  constructor(private readonly informationService: InformationsService) {}

}
