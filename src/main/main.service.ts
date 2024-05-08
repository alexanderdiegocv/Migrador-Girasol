import { Injectable } from '@nestjs/common';
import { FirmeasyService } from 'src/prisma_firmeasy/firmeasy.service';
import { GirasolService } from 'src/prisma_girasol/girasol.service';
import { users as UserFirmeasy } from '@prisma/clients/bd_postgres';
import { users as UserGirasol } from '@prisma/clients/bd_mysql';

@Injectable()
export class MainService {
    
    constructor(private BD_Firmeasy: FirmeasyService, private BD_Girasol: GirasolService) {}

    async getAllUsersFirmeasy(): Promise<UserFirmeasy []> {
        return await this.BD_Firmeasy.users.findMany();
    }

    async getAllUsersGirasol(): Promise<UserGirasol []> {
        return await this.BD_Girasol.users.findMany();
    }
}
