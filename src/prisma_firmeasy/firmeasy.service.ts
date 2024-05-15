import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/clients/bd_postgres';
import { type } from 'os';
import { Interface } from 'readline';

@Injectable()
export class FirmeasyService extends PrismaClient implements OnModuleInit {

  constructor() {
    super({
      log: [
        {
          emit: 'event',
          level: 'query',
        },
      ],
    });

    // @ts-ignore
    this.$on('query' ,(e) => {
      // @ts-ignore
      console.dir(e, { depth: null });
    });
  }

  async onModuleInit() {
    await this.$connect();
  }
}
