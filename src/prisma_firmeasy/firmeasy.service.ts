import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/clients/bd_postgres';

@Injectable()
export class FirmeasyService extends PrismaClient implements OnModuleInit {
  async onModuleInit() {
    await this.$connect();
  }
}
