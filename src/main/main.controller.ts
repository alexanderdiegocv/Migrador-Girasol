import { Controller, Get,Response } from '@nestjs/common';
import { MainService } from './main.service';
import { v4 as uuidv4 } from 'uuid';
import { json } from 'stream/consumers';

@Controller()
export class MainController {
  constructor(private readonly mainService: MainService) {}

  @Get('users')
  async getAllUsersGirasol() {

    try {

      const users = await this.mainService.getAllUsersGirasol();

      const sanitizedUsers = users.map(user => ({
        id: Number(user.id),
        plan_id: 1,
        rol_id: (user.tipouser_id === 1) ? 1 : (user.tipouser_id === 10) ? 3 : 2,
        tipo_documento_id: Number(user.tipodocumento_id),
        tipouser_id: (user.tipouser_id === 10) ? 7 : user.tipouser_id,
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
        created_at: user.created_at,
        updated_at: user.updated_at,
      }));

      return {
        'cantidad' : sanitizedUsers.filter(user => user.tipouser_id === 5).length,
        'usuarios' : sanitizedUsers.filter(user => user.tipouser_id === 5)
      }

    } catch (error) {
      return Response.caller(error);
    }

  }
}
