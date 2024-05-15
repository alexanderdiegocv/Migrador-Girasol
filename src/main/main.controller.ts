import { Controller, Get,HttpCode,HttpException,HttpStatus,Response } from '@nestjs/common';
import { MainService } from './main.service';

@Controller()
export class MainController {
  constructor(private readonly mainService: MainService) {}

  @Get('users')
  @HttpCode(200)
  async updateUsers() {

    try {

      await this.mainService.migrateUsersFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Users migrated successfully'
      }

    } catch (error) {

      console.log(error);

      throw new HttpException({
        status: HttpStatus.INTERNAL_SERVER_ERROR,
        error: error.message,
      }, HttpStatus.INTERNAL_SERVER_ERROR, {
        cause: error,
      });
    }

  }

  @Get('api')
  @HttpCode(200)
  async updateAPI() {

    try {

      await this.mainService.migrateAPIFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'API migrated successfully'
      }

    } catch (error) {
        
        console.log(error);
  
        throw new HttpException({
          status: HttpStatus.INTERNAL_SERVER_ERROR,
          error: error.message,
        }, HttpStatus.INTERNAL_SERVER_ERROR, {
          cause: error,
        })

    }
  }

  @Get('plan_certificados')
  @HttpCode(200)
  async updatePlanCertificados() {

    try {

      await this.mainService.migratePlanCertificadoFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Plan certificados migrated successfully'
      }

    } catch (error) {
        
        console.log(error);
  
        throw new HttpException({
          status: HttpStatus.INTERNAL_SERVER_ERROR,
          error: error.message,
        }, HttpStatus.INTERNAL_SERVER_ERROR, {
          cause: error,
        });
    }

  }  

  @Get('certificados')
  @HttpCode(200)
  async updateCertificados() {

    try {

      return await this.mainService.migrateCertificadosFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Certificados migrated successfully'
      }

    } catch (error) {
        
        console.log(error);
  
        throw new HttpException({
          status: HttpStatus.INTERNAL_SERVER_ERROR,
          error: error.message,
        }, HttpStatus.INTERNAL_SERVER_ERROR, {
          cause: error,
        });
    }

  }
}
