import { Injectable } from '@nestjs/common';
import { FirmeasyService } from 'src/prisma_firmeasy/firmeasy.service';
import { GirasolService } from 'src/prisma_girasol/girasol.service';
import { users as UserFirmeasy } from '@prisma/clients/bd_postgres';
import { users as UserGirasol } from '@prisma/clients/bd_mysql';
import { apis as APIGirasol } from '@prisma/clients/bd_mysql';
import { plancertificados as PlanCertificadoGirasol } from '@prisma/clients/bd_mysql';
import { certificados as CertificadoGirasol } from '@prisma/clients/bd_mysql';
import { historialcertificados as HistoriaCertificadoGirasol } from '@prisma/clients/bd_mysql';
import { archivoscertificados as ArchivoCertificadoGirasol } from '@prisma/clients/bd_mysql';
import { seriebillings as SerieBillingGirasol } from '@prisma/clients/bd_mysql';
import { billings as BillingGirasol } from '@prisma/clients/bd_mysql';
import { pagocertificados as PagoCertificadoGirasol } from '@prisma/clients/bd_mysql';
import { ventas as VentaGirasol } from '@prisma/clients/bd_mysql';
import { v4 as uuidv4 } from 'uuid';
@Injectable()
export class MainService {
    constructor(
        private BD_Firmeasy: FirmeasyService,
        private BD_Girasol: GirasolService,
    ) { }

    // Migrations

    async migrateUsersFromGirasolToFirmeasy(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.users.deleteMany();

        await this.resetSequenceUser();

        const usersGirasol: UserGirasol[] = await this.getAllUsersGirasol();

        const chunkSize = 50;

        const chunks_users: UserGirasol[][] = [];

        for (let i = 0; i < usersGirasol.length; i += chunkSize) {
            chunks_users.push(usersGirasol.slice(i, i + chunkSize));
        }

        for await (const users of chunks_users) {
            console.log(`Inserting ${users.length} usuarios`);

            const usersToInsert = users.map((user) => ({
                id: user.id,
                plan_id: 1,
                rol_id: user.tipouser_id === 1 ? 1 : user.tipouser_id === 10 ? 3 : 2,
                tipo_documento_id: Number(user.tipodocumento_id),
                tipouser_id:
                    user.tipouser_id === 10
                        ? 7
                        : user.tipouser_id === 13
                            ? 8
                            : user.tipouser_id,
                numero_documento: user.document_number,
                nombres: user.name,
                celular: user.phone,
                email: user.email,
                clave_secreta: '123456',
                codigo_afiliacion: user.codigo_afiliacion,
                password: user.password,
                token: uuidv4(),
                tipo: user.tipouser_id === 1 || user.tipouser_id === 10 ? 'I' : 'E',
                operador_registro: user.tipouser_id === 10 ? 'SI' : 'NO',
                activo: user.activo === 'SI' ? 'S' : 'N',
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
        }

        const lastUser = await this.BD_Firmeasy.users.findFirst({
            select: { id: true },
            orderBy: { id: 'desc' },
        });

        const lastUserId = lastUser ? lastUser.id : 1;

        await this.BD_Firmeasy
            .$executeRaw`SET session_replication_role = 'origin';`;

        await this.setSequenceUser(Number(lastUserId));
    }

    async migrateAPIFromGirasolToFirmeasy(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.apis.deleteMany();

        await this.resetSequenceAPI();

        const apisGirasol = await this.getAllAPIGirasol();

        const chunkSize = 5;

        const chunks = [];

        for (let i = 0; i < apisGirasol.length; i += chunkSize) {
            chunks.push(apisGirasol.slice(i, i + chunkSize));
        }

        await Promise.all(
            chunks.map(async (chunk) => {
                console.log(`Inserting ${chunk.length} apis`);

                const apisToInsert = chunk.map((api) => ({
                    id: api.id,
                    nombre: api.descripcion,
                    host: api.host,
                    url: api.url,
                    token: api.token,
                    detalle: api.observacion,
                    activo: api.activo === 'SI' ? 'S' : 'N',
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
            }),
        );

        await this.BD_Firmeasy
            .$executeRaw`SET session_replication_role = 'origin';`;

        await this.setSequenceAPI(apisGirasol.length);
    }

    async migratePlanCertificadoFromGirasolToFirmeasy(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.plan_certificados.deleteMany();

        await this.resetSequencePlanCertificado();

        const planCertificadoGirasol = await this.getAllPlanCertificadoGirasol();

        const chunkSize = 10;

        const chunks = [];

        for (let i = 0; i < planCertificadoGirasol.length; i += chunkSize) {
            chunks.push(planCertificadoGirasol.slice(i, i + chunkSize));
        }

        await Promise.all(
            chunks.map(async (chunk) => {
                console.log(`Inserting ${chunk.length} plan_certificados`);

                const planCertificadoToInsert = chunk.map((planCertificado) => ({
                    id: planCertificado.id,
                    tipo_certificado_id: planCertificado.tipocertificado_id,
                    tipouser:
                        planCertificado.tipouser_id === 10
                            ? 7
                            : planCertificado.tipouser_id === 13
                                ? 8
                                : planCertificado.tipouser_id === 9
                                    ? 1
                                    : planCertificado.tipouser_id,
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
            }),
        );

        await this.BD_Firmeasy
            .$executeRaw`SET session_replication_role = 'origin';`;

        await this.setSequencePlanCertificado(planCertificadoGirasol.length);
    }

    async migrateCertificadosFromGirasolToFirmeasy(): Promise<void> {
        
        await this.BD_Firmeasy
            .$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.certificados.deleteMany();

        await this.resetSequenceCertificado();

        const certificadosGirasol: CertificadoGirasol[] =
            await this.getAllCertificadosGirasol();

        const chunkSize = 500;

        const chunks_certificados: CertificadoGirasol[][] = [];

        for (let i = 0; i < certificadosGirasol.length; i += chunkSize) {
            chunks_certificados.push(certificadosGirasol.slice(i, i + chunkSize));
        }

        for await (const certificados of chunks_certificados) {
            console.log(`Inserting ${certificados.length} certificados`);

            const UsersId = await this.getUsersIdFromEmpresasId(
                certificados.map((certificado) => Number(certificado.empresa_id)),
            );

            const certificadosToInsert = certificados.map((certificado) => ({
                id: Number(certificado.id),
                tipo_certificado_id: certificado.tipocertificado_id,
                contador: Number(certificado.contador),
                anio: certificado.anio,
                pedido: `PD${String(certificado.anio)}${String(certificado.contador).padStart(7, '0')}`,
                numero_documento: certificado.numero_documento,
                denominacion: certificado.denominacion,
                direccion_fiscal: certificado.direccion_fiscal,
                pais: certificado.pais,
                ubigeo: certificado.ubigeo,
                departamento: certificado.departamento,
                provincia: certificado.provincia,
                distrito: certificado.distrito,
                representante: certificado.eres_representante,
                dni_representante: certificado.dni_representante,
                nombre_representante: certificado.nombre_representante,
                tipo_documento_id: certificado.tipodocumento_id,
                numero_documento_titular: certificado.numero_documento_titular,
                denominacion_titular: certificado.nombre_completo,
                cargo_titular: certificado.cargo,
                area_titular: certificado.area,
                email_envio: certificado.email_envio,
                telefono_codigo: certificado.telefono_codigo,
                telefono_validacion: certificado.telefono_validacion,
                codigo_sunat: (certificado.tipodocumento_sunat)
                    ? String(certificado.tipodocumento_sunat)
                    : null,
                numero_documento_facturacion: certificado.rucfacturacion,
                denominacion_facturacion: certificado.denominacion_facturacion,
                direccion_facturacion: certificado.direccion_facturacion,
                ubigeo_facturacion: certificado.ubigeo_facturacion,
                acepto_contrato: certificado.acepto_contrato === 'SI' ? 'SI' : 'NO',
                periodo_certificado: String(certificado.periodo_certificado),
                fecha_solicitud: certificado.fecha_solicitud
                    ? new Date(certificado.fecha_solicitud)
                    : null,
                fecha_inicio: certificado.fecha_inicio
                    ? new Date(certificado.fecha_inicio)
                    : null,
                fecha_vencimiento: certificado.fecha_vencimiento
                    ? new Date(certificado.fecha_vencimiento)
                    : null,
                // fecha_revocado: (certificado.fecha_revocado) ? new Date(certificado.fecha_revocado) : null,
                archivo_cer: certificado.archivo_cer,
                token_cer: certificado.token_cer,
                anterior_certificado_id: certificado.certificado_anterior_id,
                numero_colegiatura: certificado.numero_colegiatura,
                poder: certificado.poder,
                rne: certificado.rne,
                // rne_rna: certificado.rne_rna,
                fecha_llamada: certificado.fecha_llamada
                    ? new Date(certificado.fecha_llamada)
                    : null,
                estado_llamada: certificado.estado_llamada,
                link_video_llamada: certificado.link_video_llamada,
                operador_user_id: certificado.operador,
                observacion: certificado.observacion,
                observacion_voucher: certificado.observacion_voucher,
                codec: certificado.codec,
                anulado: certificado.anulado === 'SI' ? 'SI' : 'NO',
                token_criptografico: certificado.token_criptografico,
                fecha_voucher: certificado.fecha_voucher
                    ? new Date(certificado.fecha_voucher)
                    : null,
                renovado: certificado.renovado === 'SI' ? 'SI' : 'NO',
                verificado: certificado.verificado === 'SI' ? 'SI' : 'NO',
                observacion_operador: certificado.observacion_operador,
                costo: certificado.costo,
                descuento: certificado.descuento ? 'SI' : 'NO',
                monto_descuento: certificado.descuento,
                descuento_autorizado: certificado.descuento_autorizado,
                activo: 'S',
                user_id: UsersId[String(certificado.empresa_id)],
                token: uuidv4(),
                // token_api: uuidv4(),
                // cod_horavalidacion: certificado.cod_horavalidacion,
                // empresa_id: Number(certificado.empresa_id),
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
        }

        const lastCertificado = await this.BD_Firmeasy.certificados.findFirst({
            select: { id: true },
            orderBy: { id: 'desc' },
        });

        const lastCertificadoId = lastCertificado ? lastCertificado.id : 1;

        await this.BD_Firmeasy
            .$executeRaw`SET session_replication_role = 'origin';`;

        await this.setSequenceCertificado(Number(lastCertificadoId));
    }

    async migrateHistoriaCertificadoFromGirasolToFirmeasy(): Promise<void> {
        
        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.historial_certificados.deleteMany();

        await this.resetSequenceHistoriaCertificado();

        const historiaCertificadoGirasol: HistoriaCertificadoGirasol[] = await this.getAllHistoriaCertificadoGirasol();

        const chunkSize = 5000;

        const chunks_historiaCertificados: HistoriaCertificadoGirasol[][] = [];

        for (let i = 0; i < historiaCertificadoGirasol.length; i += chunkSize) {
            chunks_historiaCertificados.push(historiaCertificadoGirasol.slice(i, i + chunkSize));
        }

        for await (const historiaCertificados of chunks_historiaCertificados) {
            console.log(`Inserting ${historiaCertificados.length} historiaCertificados`);

            const UsersId = await this.getUsersIdFromCertificadosId(
                historiaCertificados.map((certificado) => Number(certificado.certificado_id)),
            );

            const historiaCertificadosToInsert = historiaCertificados.map((historiaCertificado) => ({
                id: Number(historiaCertificado.id),
                certificado_id: Number(historiaCertificado.certificado_id),
                estado: historiaCertificado.estado,
                codigo: historiaCertificado.codigo,
                comentario: historiaCertificado.comentario,
                activo: historiaCertificado.activo === 'SI' ? 'S' : 'N',
                user_id: (UsersId[String(historiaCertificado.certificado_id)] === undefined) ? 1 : UsersId[String(historiaCertificado.certificado_id)],
                created_at: new Date(historiaCertificado.created_at),
                updated_at: new Date(historiaCertificado.updated_at),
            }));

            try {
                await this.BD_Firmeasy.historial_certificados.createMany({
                    data: historiaCertificadosToInsert,
                });
            } catch (error) {
                console.log('Error inserting historiaCertificados:', error);
                console.log('HistoriaCertificados to insert:', historiaCertificadosToInsert);

                throw error;
            }
        }

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;

        const lastHistoriaCertificado = await this.BD_Firmeasy.historial_certificados.findFirst({
            select: { id: true },
            orderBy: { id: 'desc' },
        });

        const lastHistoriaCertificadoId = lastHistoriaCertificado ? lastHistoriaCertificado.id : 1;

        await this.setSequenceHistoriaCertificado(Number(lastHistoriaCertificadoId));
    }

    async migrateArchivosCertificadosFromGirasolToFirmeasy(): Promise<void> {
        
        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.archivo_certificados.deleteMany();

        await this.resetSequenceArchivoCertificado();

        const archivosCertificadosGirasol: ArchivoCertificadoGirasol[] = await this.getAllArchivosCertificadosGirasol();

        const chunkSize = 5000;

        const chunks_archivosCertificados: ArchivoCertificadoGirasol[][] = [];

        for (let i = 0; i < archivosCertificadosGirasol.length; i += chunkSize) {
            chunks_archivosCertificados.push(archivosCertificadosGirasol.slice(i, i + chunkSize));
        }

        for await (const archivosCertificados of chunks_archivosCertificados) {
            console.log(`Inserting ${archivosCertificados.length} archivosCertificados`);

            const UsersId = await this.getUsersIdFromCertificadosId(archivosCertificados.map((archivo_certificado) => Number(archivo_certificado.certificado_id)));

            const archivosCertificadosToInsert = archivosCertificados.map((archivoCertificado) => {

                let file_ruta = archivoCertificado.ruta?.replace("public/", "")
                    file_ruta = file_ruta?.substring(0, file_ruta.lastIndexOf('/'));

                let file_name = archivoCertificado.ruta?.substring(archivoCertificado.ruta.lastIndexOf('/') + 1);

                return {
                    id: Number(archivoCertificado.id),
                    certificado_id: Number(archivoCertificado.certificado_id),
                    // file_nombre: archivoCertificado.archivo,
                    file_nombre: file_name,
                    file_ruta: file_ruta,
                    file_token: uuidv4(),
                    tipo: (archivoCertificado.tipo === 'DNI ANVERSO')
                        ? 'DNI_ANEVERSO'
                        : (archivoCertificado.tipo === 'DNI REVERSO')
                            ? 'DNI_REVERSO'
                            : (archivoCertificado.tipo === 'FICHA RUC')
                                ? 'FICHA_RUC'
                                : (archivoCertificado.tipo === 'VIGENCIA PODER')
                                    ? 'VIGENCIA_PODER'
                                    : archivoCertificado.tipo,
                    firma_validar: archivoCertificado.firma_validar,
                    // detalle: archivoCertificado.descripcion,
                    detalle: archivoCertificado.numero_operacion,
                    // numero_operacion: archivoCertificado.numero_operacion,
                    numero_operacion: archivoCertificado.descripcion,
                    activo: 'S',
                    user_id: (UsersId[String(archivoCertificado.certificado_id)] === undefined) ? 1 : UsersId[String(archivoCertificado.certificado_id)],
                    // file_image_qr: archivoCertificado.archivo_qr,
                    // file: archivoCertificado.archivo,
                    // file_qr: archivoCertificado.archivo,
                    // file_code: archivoCertificado.archivo_code,
                    // file_old: archivoCertificado.archivo_old,
                    created_at: new Date(archivoCertificado.created_at),
                    updated_at: new Date(archivoCertificado.updated_at),
                }
            });

            try {
                await this.BD_Firmeasy.archivo_certificados.createMany({
                    data: archivosCertificadosToInsert,
                });
            } catch (error) {
                console.log('Error inserting archivosCertificados:', error);
                console.log('ArchivosCertificados to insert:', archivosCertificadosToInsert);

                throw error;
            }
        }

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;

        const lastArchivoCertificado = await this.BD_Firmeasy.archivo_certificados.findFirst({
            select: { id: true },
            orderBy: { id: 'desc' },
        });

        const lastArchivoCertificadoId = lastArchivoCertificado ? lastArchivoCertificado.id : 1;

        await this.setSequenceArchivoCertificado(Number(lastArchivoCertificadoId));
    }

    async migrateSerieBillingFromGirasolToFirmeasy(): Promise<void> {
    
        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.series.deleteMany();

        await this.resetSequenceSerieBilling();

        const serieBillingGirasol: SerieBillingGirasol[] = await this.getAllSerieBillingGirasol();

        try {

            await this.BD_Firmeasy.series.createMany({
                data: serieBillingGirasol.map((serie) => ({
                    id: serie.id,
                    description: serie.description,
                    typedocument_id: serie.typedocument_id,
                    affected_igv: serie.affected_igv,
                    affected_description: serie.affected_description,
                    activo: serie.active === 'SI' ? 'S' : 'N',
                    user_id: 1,
                    created_at: new Date(serie.created_at),
                    updated_at: new Date(serie.updated_at),
                })),
            });
    
            await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;
    
            const lastSerieBilling = await this.BD_Firmeasy.series.findFirst({
                select: { id: true },
                orderBy: { id: 'desc' },
            });
    
            const lastSerieBillingId = lastSerieBilling ? lastSerieBilling.id : 1;
    
            await this.setSequenceSerieBilling(Number(lastSerieBillingId));   

            console.log('====================================');
            console.log('SerieBilling migrated successfully');
            console.log('====================================');

        } catch (error) {   
            console.log('Error inserting serieBilling:', error);
            console.log('serieBilling to insert:', serieBillingGirasol);

            throw error;
        }
    }

    async migrateBillingsFromGirasolToFirmeasy(): Promise<void> {
    
        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.factura_certificados.deleteMany();

        await this.resetSequenceBilling();

        const billingGirasol: BillingGirasol[] = await this.getAllBillingGirasol();

        const chunkSize = 500;

        const chunks_billings: BillingGirasol[][] = [];

        for (let i = 0; i < billingGirasol.length; i += chunkSize) {
            chunks_billings.push(billingGirasol.slice(i, i + chunkSize));
        }

        for await (const billings of chunks_billings) {
            console.log(`Inserting ${billings.length} billings`);

            const UsersId = await this.getUsersIdFromCertificadosId(
                billings.map((billing) => Number(billing.certificado_id)),
            );

            const billingsToInsert = billings.map((billing) => ({
                id: billing.id,
                certificado_id: billing.certificado_id,
                serie_id: billing.serie_id,
                fecha_emision: new Date(billing.created_at),
                // subtotal: billing.subtotal,
                subtotal: 0.00,
                // igv: billing.igv,
                igv: 0.00,
                // total: billing.total,
                total: 0.00,
                external_id: billing.external_id,
                file_name: billing.file_name,
                hash: billing.hash, 
                number: billing.number,
                number_to_letter: billing.number_to_letter,
                file_cdr: billing.file_cdr?.replace("storage/", ""),
                file_xml: billing.file_xml?.replace("storage/", ""),
                file_pdf: billing.file_pdf?.replace("storage/", ""),
                image_qr: billing.image_qr,
                serial_number: billing.serial_number,
                serial: billing.serial,
                state_sunat: billing.state_type_description,
                message_sunat: billing.message,
                observacion: billing.observation,
                anulado: 'NO',
                // ticket_anulado: billing.ticket_anulado,
                // external_id_anulado: billing.external_id_anulado,
                // codigo_anulado: billing.codigo_anulado,
                // mensaje_anulado: billing.mensaje_anulado,
                // xml_anulado: billing.xml_anulado,
                // cdr_anulado: billing.cdr_anulado,
                // activo: 'S',
                user_id: UsersId[String(billing.certificado_id)],
            }));

            try {
                await this.BD_Firmeasy.factura_certificados.createMany({
                    data: billingsToInsert,
                });
            } catch (error) {
                console.log('Error inserting billings:', error);
                console.log('Billings to insert:', billingsToInsert);

                throw error;
            }
        }

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;

        const lastBilling = await this.BD_Firmeasy.factura_certificados.findFirst({
            select: { id: true },
            orderBy: { id: 'desc' },
        });

        const lastBillingId = lastBilling ? lastBilling.id : 1;

        await this.setSequenceBilling(Number(lastBillingId));
    }

    async migratePagoCertificadoFromGirasolToFirmeasy(): Promise<void> {
    
        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.pago_certificados.deleteMany();

        await this.resetSequencePagoCertificado();

        const pagoCertificadoGirasol: PagoCertificadoGirasol[] = await this.getAllPagoCertificadoGirasol();

        const chunkSize = 500;

        const chunks_pagos: PagoCertificadoGirasol[][] = [];

        for (let i = 0; i < pagoCertificadoGirasol.length; i += chunkSize) {
            chunks_pagos.push(pagoCertificadoGirasol.slice(i, i + chunkSize));
        }

        for await (const pagos of chunks_pagos) {
            console.log(`Inserting ${pagos.length} pagos`);

            const UsersId = await this.getUsersIdFromCertificadosId(
                pagos.map((pago) => Number(pago.certificado_id)),
            );

            const pagosToInsert = pagos.map((pago) => ({
                id: pago.id,
                certificado_id: pago.certificado_id,
                medio_pago: pago.medio_pago,
                numero_operacion: pago.numero_operacion,
                descripcion: pago.descripcion,
                monto: pago.monto,
                fecha_pago: new Date(pago.fecha_pago),
                observacion: pago.observacion,
                // activo: pago.activo === 'SI' ? 'S' : 'N',
                user_id: UsersId[String(pago.certificado_id)],  
                created_at: new Date(pago.created_at),
                updated_at: new Date(pago.updated_at),
            }));

            try {
                await this.BD_Firmeasy.pago_certificados.createMany({
                    data: pagosToInsert,
                });
            } catch (error) {
                console.log('Error inserting pagos:', error);
                console.log('Pagos to insert:', pagosToInsert);

                throw error;
            }
        }

        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;

        const lastPago = await this.BD_Firmeasy.pago_certificados.findFirst({
            select: { id: true },
            orderBy: { id: 'desc' },
        });

        const lastPagoId = lastPago ? lastPago.id : 1;

        await this.setSequencePagoCertificado(Number(lastPagoId));

    }

    async migrateVentasFromGirasolToFirmeasy(): Promise<void> {
    
        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'replica';`;

        await this.BD_Firmeasy.ventas.deleteMany();

        await this.resetSequenceVenta();

        const ventasGirasol: VentaGirasol[] = await this.getAllVentasGirasol();

        const chunkSize = 10;

        const chunks_ventas: VentaGirasol[][] = [];

        for (let i = 0; i < ventasGirasol.length; i += chunkSize) {
            chunks_ventas.push(ventasGirasol.slice(i, i + chunkSize));
        }

        for await (const ventas of chunks_ventas) {
            console.log(`Inserting ${ventas.length} ventas`);

            const TipoDocumentoId = await this.getTipoDocumentoIdFromUsersId(ventas.map((venta) => Number(venta.user_id)));

            const ventasToInsert = ventas.map((venta) => ({
                id: venta.id,
                tipo_documento_id: TipoDocumentoId[String(venta.user_id)],
                numero_documento: venta.numero_documento,
                nombres: venta.nombres,
                email: venta.email,
                celular: venta.telefono,
                informacion_adicional: venta.informacion_adicional,
                activo: venta.estado === 'ACTIVO' ? 'S' : 'N',
                user_id: venta.user_id,
                created_at: new Date(venta.created_at),
                updated_at: new Date(venta.updated_at),
            }));

            try {
                await this.BD_Firmeasy.ventas.createMany({
                    data: ventasToInsert,
                });
            } catch (error) {
                console.log('Error inserting ventas:', error);
                console.log('Ventas to insert:', ventasToInsert);

                throw error;
            }
        }
        
        await this.BD_Firmeasy.$executeRaw`SET session_replication_role = 'origin';`;

        const lastVenta = await this.BD_Firmeasy.ventas.findFirst({
            select: { id: true },
            orderBy: { id: 'desc' },
        });

        const lastVentaId = lastVenta ? lastVenta.id : 1;

        await this.setSequenceVenta(Number(lastVentaId));
    }

    // Helpers Firmeasy

    private async getUsersIdFromCertificadosId(certificadosId: number[]): Promise<Record<string, bigint>> {
        const certificados = await this.BD_Firmeasy.certificados.findMany({
            where: {
                id: {
                    in: certificadosId,
                },
            },
            select: {
                user_id: true,
                id: true,
            },
        });

        return certificados.reduce(
            (acc, certificado) => {
                acc[String(certificado.id)] = certificado.user_id;
                return acc;
            },
            {} as Record<string, bigint>,
        );
    }

    private async getTipoDocumentoIdFromUsersId(usersId: number[]): Promise<Record<string, bigint>> {   

        const users = await this.BD_Firmeasy.users.findMany({
            where: {
                id: {
                    in: usersId,
                },
            },
            select: {
                tipo_documento_id: true,
                id: true,
            },
        });

        return users.reduce(
            (acc, user) => {
                acc[String(user.id)] = user.tipo_documento_id;
                return acc;
            },
            {} as Record<string, bigint>,
        );
    
    }

    // Helpers Girasol

    private async getUsersIdFromEmpresasId(empresasId: number[]): Promise<Record<string, bigint>> {
        const empresas = await this.BD_Girasol.empresas.findMany({
            where: {
                id: {
                    in: empresasId,
                },
            },
            select: {
                user_id: true,
                id: true,
            },
        });

        return empresas.reduce(
            (acc, empresa) => {
                acc[String(empresa.id)] = empresa.user_id;
                return acc;
            },
            {} as Record<string, bigint>,
        );
    }

    // Getters

    private async getAllUsersGirasol(): Promise<UserGirasol[]> {
        return await this.BD_Girasol.users.findMany({
            orderBy: {
                id: 'asc',
            },
        });
    }

    private async getAllAPIGirasol(): Promise<APIGirasol[]> {
        return await this.BD_Girasol.apis.findMany();
    }

    private async getAllPlanCertificadoGirasol(): Promise<PlanCertificadoGirasol[]> {
        return await this.BD_Girasol.plancertificados.findMany();
    }

    private async getAllCertificadosGirasol(): Promise<CertificadoGirasol[]> {
        return await this.BD_Girasol.certificados.findMany({
            orderBy: {
                id: 'asc',
            },
        });
    }

    private async getAllHistoriaCertificadoGirasol(): Promise<HistoriaCertificadoGirasol[]> {
        return await this.BD_Girasol.historialcertificados.findMany({
            orderBy: {
                id: 'asc',
            },
        });
    }

    private async getAllArchivosCertificadosGirasol(): Promise<ArchivoCertificadoGirasol[]> {
        return await this.BD_Girasol.archivoscertificados.findMany({
            orderBy: {
                id: 'asc',
            },
        });
    }

    private async getAllSerieBillingGirasol(): Promise<SerieBillingGirasol[]> {
        return await this.BD_Girasol.seriebillings.findMany({
            orderBy: {
                id: 'asc',
            },
        });
    }

    private async getAllBillingGirasol(): Promise<BillingGirasol[]> {
        return await this.BD_Girasol.billings.findMany({
            orderBy: {
                id: 'asc',
            },
        });
    }

    private async getAllPagoCertificadoGirasol(): Promise<PagoCertificadoGirasol[]> {
        return await this.BD_Girasol.pagocertificados.findMany({
            orderBy: {
                id: 'asc',
            },
        });
    }

    private async getAllVentasGirasol(): Promise<VentaGirasol[]> {
        return await this.BD_Girasol.ventas.findMany({
            orderBy: {
                id: 'asc',
            },
        });
    }

    // Sequences

    private async resetSequenceUser(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE users_id_seq RESTART WITH 1;`;
    }

    private async setSequenceUser(value: number): Promise<void> {
        await this.BD_Firmeasy.$queryRaw`SELECT setval('users_id_seq', ${value});`;
    }

    private async resetSequenceAPI(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE apis_id_seq RESTART WITH 1;`;
    }

    private async setSequenceAPI(value: number): Promise<void> {
        await this.BD_Firmeasy.$queryRaw`SELECT setval('apis_id_seq', ${value});`;
    }

    private async resetSequencePlanCertificado(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE plan_certificados_id_seq RESTART WITH 1;`;
    }

    private async setSequencePlanCertificado(value: number): Promise<void> {
        await this.BD_Firmeasy
            .$queryRaw`SELECT setval('plan_certificados_id_seq', ${value});`;
    }

    private async resetSequenceCertificado(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE certificados_id_seq RESTART WITH 1;`;
    }

    private async setSequenceCertificado(value: number): Promise<void> {
        await this.BD_Firmeasy
            .$queryRaw`SELECT setval('certificados_id_seq', ${value});`;
    }

    private async resetSequenceHistoriaCertificado(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE historial_certificados_id_seq RESTART WITH 1;`;
    }

    private async setSequenceHistoriaCertificado(value: number): Promise<void> {
        await this.BD_Firmeasy
            .$queryRaw`SELECT setval('historial_certificados_id_seq', ${value});`;
    }

    private async resetSequenceArchivoCertificado(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE archivo_certificados_id_seq RESTART WITH 1;`;
    }

    private async setSequenceArchivoCertificado(value: number): Promise<void> {
        await this.BD_Firmeasy
            .$queryRaw`SELECT setval('archivo_certificados_id_seq', ${value});`;
    }

    private async resetSequenceSerieBilling(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE series_id_seq RESTART WITH 1;`;
    }

    private async setSequenceSerieBilling(value: number): Promise<void> {
        await this.BD_Firmeasy
            .$queryRaw`SELECT setval('series_id_seq', ${value});`;
    }

    private async resetSequenceBilling(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE factura_certificados_id_seq RESTART WITH 1;`;
    }

    private async setSequenceBilling(value: number): Promise<void> {
        await this.BD_Firmeasy
            .$queryRaw`SELECT setval('factura_certificados_id_seq', ${value});`;
    }

    private async resetSequencePagoCertificado(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE pago_certificados_id_seq RESTART WITH 1;`;
    }

    private async setSequencePagoCertificado(value: number): Promise<void> {
        await this.BD_Firmeasy
            .$queryRaw`SELECT setval('pago_certificados_id_seq', ${value});`;
    }

    private async resetSequenceVenta(): Promise<void> {
        await this.BD_Firmeasy
            .$executeRaw`ALTER SEQUENCE ventas_id_seq RESTART WITH 1;`;
    }

    private async setSequenceVenta(value: number): Promise<void> {
        await this.BD_Firmeasy
            .$queryRaw`SELECT setval('ventas_id_seq', ${value});`;
    }

}
