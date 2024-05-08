import { Module } from '@nestjs/common';
import { MainController } from './main.controller';
import { MainService } from './main.service';
import { FirmeasyService } from 'src/prisma_firmeasy/firmeasy.service';
import { GirasolService } from 'src/prisma_girasol/girasol.service';

@Module({
  controllers: [MainController],
  providers: [MainService, FirmeasyService, GirasolService],
})
export class MainModule {}
