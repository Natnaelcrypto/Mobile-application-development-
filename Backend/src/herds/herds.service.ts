import { BadRequestException, Injectable } from '@nestjs/common';
import { Herd } from './herd.model';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

@Injectable()
export class HerdsService {
  constructor(@InjectModel('Herd') private herdModel: Model<Herd>) {}

  async find_herds(farmname: any) {
    console.log(farmname);
    return await this.herdModel.find({ farmname: farmname });
  }
  async find_herd(id: any) {
    return await this.herdModel.findById(id);
  }
  async create_herd(data: any) {
    if (
      !data.farmname ||
      !data.herdID ||
      !data.age ||
      !data.bread ||
      !data.gender
    ) {
      throw new BadRequestException('All fileds are requierd');
    }
    const new_herd = new this.herdModel({
      farmname: data.farmname,
      herdID: data.herdID,
      age: data.age,
      bread: data.bread,
      health_history: data.health_history,
      vaccination: data.vaccination,
      medication: data.medication,
      pregnancy: data.pregnancy,
      gender: data.gender,
    });
    const result = await new_herd.save();
    if (result) {
      return result;
    }
    throw new BadRequestException();
  }
  async Update_herd(id: any, data: any) {
    console.log(data);
    console.log(id);
    const herd = await this.herdModel.findById(id.id);

    if (!herd) {
      throw new BadRequestException('There is no herd');
    }

    if (data.farmname) {
      herd.farmname = data.farmname;
    }

    if (data.herdID) {
      herd.herdID = data.herdID;
    }
    if (data.age) {
      herd.age = data.age;
    }
    if (data.bread) {
      herd.bread = data.bread;
    }
    if (data.health_history) {
      herd.health_history = data.health_history;
    }
    if (data.vaccination) {
      herd.vaccination = data.vaccination;
    }
    if (data.medication) {
      herd.medication = data.medication;
    }
    if (data.gender) {
      herd.gender = data.gender;
    }
    if (data.pregnancy) {
      herd.pregnancy = data.pregnancy;
    }

    const result = await herd.save();
    if (result) {
      return result;
    }
    throw new BadRequestException();
  }
  async delate(id: any) {
    return await this.herdModel.findByIdAndDelete(id);
  }
}
