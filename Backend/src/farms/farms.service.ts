import { BadRequestException, Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import { Farm } from './farm.model';
import { InjectModel } from '@nestjs/mongoose';

@Injectable()
export class FarmsService {
  constructor(@InjectModel('Farm') private farmModel: Model<Farm>) {}

  async find_farme(userId: any) {
    const farm = await this.farmModel.findOne({ userID: userId });
    if (farm) {
      return farm;
    }
    throw new BadRequestException('farm dose not exist');
  }

  async find_farmes(farmname: any) {
    const farms = await this.farmModel.find({ farmName: farmname });
    if (farms) {
      return farms;
    }
    throw new BadRequestException('There is no farm');
  }

  async create_farm(data: any) {
    const new_farm = new this.farmModel({
      farmName: data.farmName,
      userID: data.userID,
      expirationDate: data.expirationDate,
      itemName: data.itemName,
      dosage: data.dosage,
      instructions: data.instructions,
      brand: data.brand,
      type: data.type,
      quantity: data.quantity,
      isfeed: data.isfeed,
      ismedication: data.ismedication,
    });

    const result = await new_farm.save();
    return result;
  }

  async update(data: any, id: any) {
    const farm = await this.farmModel.findById(id);
    if (!farm) {
      throw new BadRequestException('farm does not exist');
    }
    if (data.brand) {
      farm.brand = data.brand;
    }
    if (data.type) {
      farm.type = data.type;
    }
    if (data.expirationDate) {
      farm.expirationDate = data.expirationDate;
    }
    if (data.dosage) {
      farm.dosage = data.dosage;
    }
    if (data.farmName) {
      farm.farmName = data.farmName;
    }
    if (data.itemName) {
      farm.itemName = data.itemName;
    }

    const result = await farm.save();
    return result;
  }

  async delate_farm(farm_Id: any) {
    const farm = await this.farmModel.findById(farm_Id);
    if (farm) {
      return 'farm delated';
    }
    throw new BadRequestException('Error occured');
  }
}
