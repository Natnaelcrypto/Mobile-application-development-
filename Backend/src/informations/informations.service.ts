import { BadRequestException, Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { Info } from "./informations.model";

@Injectable()
export class InformationsService {
  constructor(@InjectModel("Info") private InfoModel: Model<Info>) {}
  async find_infos() {
    return await this.InfoModel.find();
  }
  async find_info(date: any) {
    return await this.InfoModel.find({ bread: date.bread });
  }
  async create(data: any) {
    if (!data.bread || !data.age || !data.detaile) {
      throw new BadRequestException("All fildes are required");
    }
    const new_info = new this.InfoModel({
      bread: data.bread,
      age: data.age,
      detaile: data.detaile,
    });
    const result = await new_info.save();
    if (result) {
      return result;
    }
    throw new BadRequestException();
  }

  async Update_info(id: any, data: any) {
    const info = await this.InfoModel.findById(id);
    if (!info) {
      throw new BadRequestException("There is no info");
    }
    if (info.detail) {
      info.detail = data.detaile;
    }
    const result = info.save();
    if (result) {
      return result;
    }
    throw new BadRequestException();
  }
  async delate(id: any) {
    return this.InfoModel.findByIdAndDelete(id);
  }
}
