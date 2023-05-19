import { BadRequestException, Injectable } from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private readonly useService: UsersService,
    private jwtService: JwtService,
  ) {}
  async login(user: any) {
    const current_user = await this.useService.find_user(user);
    if (!current_user) {
      throw new BadRequestException("user does not exist");
    }

    if (await bcrypt.compare(user.password, current_user.password)) {
      const payload = current_user;
      console.log(payload)
      return {
        access_token: this.jwtService.sign({payload}),
      };
    }
  }
  async signup(user: any) {
    const new_user = await this.useService.create_User(user);
    const payload = new_user;
    console.log(payload);
    if (new_user) {
      return {
        access_token: this.jwtService.sign({payload}),
      };
    }
  }
}


