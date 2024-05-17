import { Controller, Get,HttpCode,HttpException,HttpStatus,Response } from '@nestjs/common';
import { MainService } from './main.service';

@Controller()
export class MainController {
  constructor(private readonly mainService: MainService) {}

  @Get('migrar')
  @HttpCode(200)
  async update() {

    try {

      await this.mainService.migrateUsersFromGirasolToFirmeasy();

      await this.mainService.migrateAPIFromGirasolToFirmeasy();

      await this.mainService.migratePlanCertificadoFromGirasolToFirmeasy();

      await this.mainService.migrateCertificadosFromGirasolToFirmeasy();

      await this.mainService.migrateHistoriaCertificadoFromGirasolToFirmeasy();

      await this.mainService.migrateArchivosCertificadosFromGirasolToFirmeasy();

      await this.mainService.migrateSerieBillingFromGirasolToFirmeasy();

      await this.mainService.migrateBillingsFromGirasolToFirmeasy();

      await this.mainService.migratePagoCertificadoFromGirasolToFirmeasy();

      await this.mainService.migrateVentasFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Data migrated successfully'
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

      await this.mainService.migrateCertificadosFromGirasolToFirmeasy();

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

  @Get('historialCertificados')
  @HttpCode(200)
  async updateHistorialCertificados() {

    try {

      await this.mainService.migrateHistoriaCertificadoFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Historial Certificados migrated successfully'
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

  @Get('archivoCertificados')
  @HttpCode(200)
  async updateArchivoCertificados() {

    try {

      await this.mainService.migrateArchivosCertificadosFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Archivos Certificados migrated successfully'
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

  @Get('series')
  @HttpCode(200)
  async updateSeries() {

    try {

      await this.mainService.migrateSerieBillingFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Series migrated successfully'
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

  @Get('billings')
  @HttpCode(200)
  async updateBilling() {

    try {

      await this.mainService.migrateBillingsFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Billings migrated successfully'
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

  @Get('pagosCertificados')
  @HttpCode(200)
  async updatePagosCertificados() {

    try {

      await this.mainService.migratePagoCertificadoFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Pagos Certificados migrated successfully'
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

  @Get('ventas')
  @HttpCode(200)
  async updateVentas() {

    try {

      await this.mainService.migrateVentasFromGirasolToFirmeasy();

      return {
        status: HttpStatus.OK,
        message: 'Ventas migrated successfully'
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
