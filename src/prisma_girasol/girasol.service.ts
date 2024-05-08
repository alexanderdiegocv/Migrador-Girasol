import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/clients/bd_mysql';

@Injectable()
export class GirasolService extends PrismaClient implements OnModuleInit {
  async onModuleInit() {
    await this.$connect();
  }
}
