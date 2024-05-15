import { Injectable } from '@nestjs/common';
import { FirmeasyService } from 'src/prisma_firmeasy/firmeasy.service';
import { GirasolService } from 'src/prisma_girasol/girasol.service';
import { users as UserFirmeasy } from '@prisma/clients/bd_postgres';
import { users as UserGirasol } from '@prisma/clients/bd_mysql';
import { apis as APIGirasol } from '@prisma/clients/bd_mysql';
import { plancertificados as PlanCertificadoGirasol } from '@prisma/clients/bd_mysql';
import { certificados as CertificadoGirasol } from '@prisma/clients/bd_mysql';
import { v4 as uuidv4 } from 'uuid';
import { create } from 'domain';
@Injectable()
export class MainService {
    
    constructor(private BD_Firmeasy: FirmeasyService, private BD_Girasol: GirasolService) {}

    async migrateUsersFromGirasolToFirmeasy(): Promise<void> {

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.users.deleteMany();

        await this.resetSequenceUser();

        const usersGirasol = await this.getAllUsersGirasol();

        const chunkSize = 50;

        const chunks = [];

        for (let i = 0; i < usersGirasol.length; i += chunkSize) {
            chunks.push(usersGirasol.slice(i, i + chunkSize));
        }

        await Promise.all(chunks.map(async (chunk) => {

            console.log('Inserting chunks:', chunk.length);

            const usersToInsert = chunk.map(user => ({
                id: user.id,
                plan_id: 1,
                rol_id: (user.tipouser_id === 1) ? 1 : (user.tipouser_id === 10) ? 3 : 2,
                tipo_documento_id: Number(user.tipodocumento_id),
                tipouser_id: (user.tipouser_id === 10) ? 7 : (user.tipouser_id === 13) ? 8 : user.tipouser_id,
                numero_documento: user.document_number,
                nombres: user.name,
                celular: user.phone,
                email: user.email,
                clave_secreta: '123456',
                codigo_afiliacion: user.codigo_afiliacion,
                password: user.password,
                token: uuidv4(),
                tipo: (user.tipouser_id === 1 || user.tipouser_id === 10) ? 'I' : 'E',
                operador_registro: (user.tipouser_id === 10) ? 'SI' : 'NO',
                activo: (user.activo === 'SI') ? 'S' : 'N',
                created_at: new Date(user.created_at),
                updated_at: new Date(user.updated_at),
            }));

            try {
                
                await this.BD_Firmeasy.users.createMany({
                    data: usersToInsert,
                });   

            } catch (error) {
                console.log('Error inserting users:', error);
                console.log('Users to insert:', usersToInsert);    
            }

        }));

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;

        await this.setSequenceUser(usersGirasol.length + 2);
    }

    async migrateAPIFromGirasolToFirmeasy(): Promise<void> {   
        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.apis.deleteMany();

        await this.resetSequenceAPI();

        const apisGirasol = await this.getAllAPIGirasol();

        const chunkSize = 5;

        const chunks = [];

        for (let i = 0; i < apisGirasol.length; i += chunkSize) {
            chunks.push(apisGirasol.slice(i, i + chunkSize));
        }

        await Promise.all(chunks.map(async (chunk) => {

            console.log('Inserting chunks:', chunk.length);

            const apisToInsert = chunk.map(api => ({
                id: api.id,
                nombre: api.descripcion,
                host: api.host,
                url: api.url,
                token: api.token,
                detalle: api.observacion,
                activo: (api.activo === 'SI') ? 'S' : 'N',
                user_id: 1,
                created_at: new Date(api.created_at),
                updated_at: new Date(api.updated_at),
            }));

            try {
                
                await this.BD_Firmeasy.apis.createMany({
                    data: apisToInsert,
                });   

            } catch (error) {
                console.log('Error inserting apis:', error);
                console.log('Apis to insert:', apisToInsert);    
            }

        }));

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;

        await this.setSequenceAPI(apisGirasol.length);
    }

    async migratePlanCertificadoFromGirasolToFirmeasy(): Promise<void> {

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.plan_certificados.deleteMany();

        await this.resetSequencePlanCertificado();

        const planCertificadoGirasol = await this.getAllPlanCertificadoGirasol();

        const chunkSize = 10;

        const chunks = [];

        for (let i = 0; i < planCertificadoGirasol.length; i += chunkSize) {
            chunks.push(planCertificadoGirasol.slice(i, i + chunkSize));
        }

        await Promise.all(chunks.map(async (chunk) => {

            console.log('Inserting chunks:', chunk.length);

            const planCertificadoToInsert = chunk.map(planCertificado => ({
                id: planCertificado.id,
                tipo_certificado_id: planCertificado.tipocertificado_id,
                tipouser: (planCertificado.tipouser_id === 10) ? 7 : (planCertificado.tipouser_id === 13) ? 8 : (planCertificado.tipouser_id === 9) ? 1 : planCertificado.tipouser_id,
                nombre: planCertificado.nombre,
                precio_base: planCertificado.precio_base,
                precio_venta: planCertificado.precio_venta,
                periodo: planCertificado.periodo,
                comentario: planCertificado.comentario,
                user_id: 1,
                created_at: new Date(planCertificado.created_at),
                updated_at: new Date(planCertificado.updated_at),
            }));

            try {
                
                await this.BD_Firmeasy.plan_certificados.createMany({
                    data: planCertificadoToInsert,
                });   

            } catch (error) {
                console.log('Error inserting plan_certificados:', error);
                console.log('Plan_certificados to insert:', planCertificadoToInsert);    
            }

        }));

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;

        await this.setSequencePlanCertificado(planCertificadoGirasol.length);
    }

    async migrateCertificadosFromGirasolToFirmeasy() {   
        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.certificados.deleteMany();

        await this.resetSequenceCertificado();

        const certificadosGirasol = await this.getAllCertificadosGirasol();

        return certificadosGirasol.map(certificado => ({
            ...certificado,
            id: Number(certificado.id),
            tipo_certificado_id: certificado.tipocertificado_id,
            tipo_documento_id: certificado.tipodocumento_id,
            departamento: certificado.departamento,
            provincia: certificado.provincia,
            distrito: certificado.distrito,
            pais: certificado.pais,
            fecha_inicio: (certificado.fecha_inicio) ? new Date(certificado.fecha_inicio) : null,
            created_at: new Date(certificado.created_at),
            updated_at: new Date(certificado.updated_at),
        }));

        const chunkSize = 50;

        const chunks = [];

        for (let i = 0; i < certificadosGirasol.length; i += chunkSize) {
            chunks.push(certificadosGirasol.slice(i, i + chunkSize));
        }

        await Promise.all(chunks.map(async (chunk) => {

            console.log('Inserting chunks:', chunk.length);

            const certificadosToInsert = chunk.map(certificado => ({
                id: certificado.id,
                plan_certificado_id: certificado.plancertificado_id,
                user_id: certificado.user_id,
                tipo_certificado_id: certificado.tipocertificado_id,
                tipo_documento_id: certificado.tipodocumento_id,
                numero_documento: certificado.document_number,
                nombres: certificado.name,
                email: certificado.email,
                celular: certificado.phone,
                fecha_nacimiento: certificado.fecha_nacimiento,
                sexo: certificado.sexo,
                direccion: certificado.direccion,
                departamento: certificado.departamento,
                provincia: certificado.provincia,
                distrito: certificado.distrito,
                pais: certificado.pais,
                codigo_postal: certificado.codigo_postal,
                comentario: certificado.comentario,
                activo: (certificado.activo === 'SI') ? 'S' : 'N',
                created_at: new Date(certificado.created_at),
                updated_at: new Date(certificado.updated_at),
            }));

            try {
                
                await this.BD_Firmeasy.certificados.createMany({
                    data: certificadosToInsert,
                });   

            } catch (error) {
                console.log('Error inserting certificados:', error);
                console.log('Certificados to insert:', certificadosToInsert);    
            }

        }));

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;

        await this.setSequenceCertificado(certificadosGirasol.length);  
    }

    private async getAllUsersGirasol(): Promise<UserGirasol []> {
        return await this.BD_Girasol.users.findMany();
    }

    private async getAllAPIGirasol(): Promise<APIGirasol []> {
        return await this.BD_Girasol.apis.findMany();
    }

    private async getAllPlanCertificadoGirasol(): Promise<PlanCertificadoGirasol []> {
        return await this.BD_Girasol.plancertificados.findMany();
    }

    private async getAllCertificadosGirasol(): Promise<CertificadoGirasol []> {
        return await this.BD_Girasol.certificados.findMany();
    }

    private async resetSequenceUser(): Promise<void> {
        await this.BD_Firmeasy.$executeRaw`ALTER SEQUENCE users_id_seq RESTART WITH 1;`;
    }

    private async setSequenceUser(value: number): Promise<void> {   
        await this.BD_Firmeasy.$queryRaw`SELECT setval('users_id_seq', ${value});`;
    }

    private async resetSequenceAPI(): Promise<void> {
        await this.BD_Firmeasy.$executeRaw`ALTER SEQUENCE apis_id_seq RESTART WITH 1;`;
    }

    private async setSequenceAPI(value: number): Promise<void> {   
        await this.BD_Firmeasy.$queryRaw`SELECT setval('apis_id_seq', ${value});`;
    }

    private async resetSequencePlanCertificado(): Promise<void> {
        await this.BD_Firmeasy.$executeRaw`ALTER SEQUENCE plan_certificados_id_seq RESTART WITH 1;`;
    }

    private async setSequencePlanCertificado(value: number): Promise<void> {   
        await this.BD_Firmeasy.$queryRaw`SELECT setval('plan_certificados_id_seq', ${value});`;
    }

    private async resetSequenceCertificado(): Promise<void> {
        await this.BD_Firmeasy.$executeRaw`ALTER SEQUENCE certificados_id_seq RESTART WITH 1;`;
    }

    private async setSequenceCertificado(value: number): Promise<void> {   
        await this.BD_Firmeasy.$queryRaw`SELECT setval('certificados_id_seq', ${value});`;
    }
}
