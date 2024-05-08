import { Controller, Get, Res } from '@nestjs/common';
import { MainService } from './main.service';

@Controller('users')
export class MainController {
  constructor(private readonly mainService: MainService) {}

  @Get()
  async getAllUsersFirmeasy() {
    const users = await this.mainService.getAllUsersGirasol();

    const sanitizedUsers = users.map(user => ({
      ...user,
      id: Number(user.id),
    }));

    return sanitizedUsers;
  }
}
