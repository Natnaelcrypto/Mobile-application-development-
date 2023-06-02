import { BadRequestException, Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import { User } from './user.model';
import { InjectModel } from '@nestjs/mongoose';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(@InjectModel('User') private usermodel: Model<User>) {}

  async find_users(farmname: any) {
    console.log(farmname);
    return this.usermodel.find({ farmName: farmname });
  }
  async find_user(user: any) {
    console.log(user.userName);
    const get_user = await this.usermodel.findOne({ userName: user.userName });
    if (get_user) {
      return get_user;
    }

    return null;
  }
  async create_User(user: any) {
    if (
      !user.fristName ||
      !user.lastName ||
      !user.userName ||
      !user.password ||
      !user.Role ||
      !user.farmName
    ) {
      throw new BadRequestException('All filled are required');
    }
    const find_user = await this.usermodel.findOne({ userName: user.userName });
    if (find_user) {
      throw new BadRequestException('Username exist');
    }
    const saltOrRounds = await bcrypt.genSalt(15);
    const hashedPassword = await bcrypt.hash(user.password, saltOrRounds);

    const newUser = new this.usermodel({
      fristName: user.fristName,
      lastName: user.lastName,
      userName: user.userName,
      Role: user.Role,
      password: hashedPassword,
      farmName: user.farmName,
    });

    const result = newUser.save();

    if (result) {
      return result;
    }
  }
  async delate_user(id: any) {
    const delated_accunt = await this.usermodel.findByIdAndDelete(id);

    if (delated_accunt) {
      return delated_accunt;
    }
  }

  async update_user(id, user: any) {
    const find_user = await this.usermodel.findById(id);
    if (!find_user) {
      throw new BadRequestException('User does not exist');
    }
    if (user.userName) {
      find_user.userName = user.userName;
    }
    if (user.fristName) {
      find_user.fristName = user.fristName;
    }
    if (user.lastName) {
      find_user.lastName = user.lastName;
    }
    if (user.password) {
      const saltOrRounds = await bcrypt.genSalt(15);
      const hashedPassword = await bcrypt.hash(user.password, saltOrRounds);
      find_user.password = hashedPassword;
    }
    if (user.farmName) {
      find_user.farmName = user.farmName;
    }

    const updated_account = await find_user.save();

    if (updated_account) {
      return updated_account;
    }
  }
}
