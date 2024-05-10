import { Controller, Get, Res } from '@nestjs/common';
import { MainService } from './main.service';
import { v4 as uuidv4 } from 'uuid';

@Controller('users')
export class MainController {
  constructor(private readonly mainService: MainService) {}

  @Get()
  async getAllUsersGirasol() {
    const users = await this.mainService.getAllUsersGirasol();

    const sanitizedUsers = users.map(user => ({
      ...user,
      id: Number(user.id),
      plan_id: 1,
      rol_id: 1, 
      tipo_documento_id: Number(user.tipodocumento_id),
      tipouser_id: Number(user.tipouser_id),  
      numero_documento: user.document_number,
      nombres: user.name,
      celular: user.phone,
      email: user.email,
      clave_secreta: '123456',
      codigo_afiliacion: user.codigo_afiliacion,
      password: user.password,
      token: uuidv4(),
    }));

    return sanitizedUsers;
  }
}
