import { BadRequestException, Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Info } from "./informations.model";

@Injectable()
export class InformationsService {
  constructor(@InjectModel("Info") private InfoModel: Model<Info>) {}
  

}
