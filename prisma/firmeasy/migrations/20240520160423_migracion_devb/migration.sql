-- CreateTable
CREATE TABLE "anticipos" (
    "id" BIGSERIAL NOT NULL,
    "bolsa_id" BIGINT NOT NULL,
    "cliente_user_id" BIGINT NOT NULL,
    "cantidad" SMALLINT NOT NULL,
    "stock" SMALLINT NOT NULL,
    "subtotal" DOUBLE PRECISION,
    "igv" DOUBLE PRECISION,
    "total" DOUBLE PRECISION,
    "archivo" VARCHAR(100),
    "archivo_token" VARCHAR(255),
    "archivo_ruta" TEXT,
    "pago_medio" VARCHAR(50),
    "pago_operacion" VARCHAR(20),
    "pago_descripcion" VARCHAR(50),
    "pago_monto" DOUBLE PRECISION,
    "pago_observacion" VARCHAR(100),
    "pago_fecha" DATE,
    "codigo_sunat" VARCHAR(10),
    "documento_facturacion" VARCHAR(11),
    "denominacion_facturacion" VARCHAR(255),
    "direccion_facturacion" VARCHAR(150),
    "ubigeo_facturacion" VARCHAR(6),
    "departamento" VARCHAR(100),
    "provincia" VARCHAR(100),
    "distrito" VARCHAR(100),
    "serie_id" BIGINT,
    "external_id" VARCHAR(255),
    "file_name" VARCHAR(255),
    "hash" VARCHAR(255),
    "number" VARCHAR(10),
    "number_to_letter" VARCHAR(255),
    "file_cdr" TEXT,
    "file_xml" TEXT,
    "file_pdf" TEXT,
    "imagen_qr" TEXT,
    "serial_number" VARCHAR(100),
    "serial" VARCHAR(50),
    "state_sunat" VARCHAR(50),
    "message_sunat" VARCHAR(150),
    "observacion" VARCHAR(255),
    "anulado" CHAR(2) NOT NULL DEFAULT 'NO',
    "ticket_anulado" VARCHAR(50),
    "external_id_anulado" VARCHAR(50),
    "codigo_anulado" VARCHAR(50),
    "mensaje_anulado" VARCHAR(255),
    "xml_anulado" TEXT,
    "cdr_anulado" TEXT,
    "fecha_emision" DATE,
    "uso" CHAR(2) NOT NULL DEFAULT 'NO',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "anticipos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "apis" (
    "id" BIGSERIAL NOT NULL,
    "nombre" VARCHAR(255) NOT NULL,
    "host" VARCHAR(255),
    "url" VARCHAR(255) NOT NULL,
    "token" VARCHAR(255) NOT NULL,
    "detalle" VARCHAR(255),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "apis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "archivo_certificados" (
    "id" BIGSERIAL NOT NULL,
    "certificado_id" BIGINT NOT NULL,
    "file_nombre" VARCHAR(255) NOT NULL,
    "file_ruta" VARCHAR(255) NOT NULL,
    "file_token" VARCHAR(255),
    "tipo" VARCHAR(50) NOT NULL,
    "numero_operacion" VARCHAR(50),
    "firma_validar" TEXT,
    "detalle" VARCHAR(255),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),
    "file_imagen_qr" VARCHAR(255),
    "file" VARCHAR(50),
    "file_qr" VARCHAR(50),
    "file_code" VARCHAR(15),
    "file_old" VARCHAR(50),

    CONSTRAINT "archivo_certificados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "archivo_firmantes" (
    "id" BIGSERIAL NOT NULL,
    "archivo_id" BIGINT NOT NULL,
    "nombre" VARCHAR(255) NOT NULL,
    "celular" VARCHAR(255),
    "codigo_pais" VARCHAR(255),
    "email" VARCHAR(255),
    "link" VARCHAR(255),
    "firmado" BOOLEAN NOT NULL DEFAULT false,
    "signed_document" VARCHAR(255),
    "hora" TIME(0),
    "fecha" DATE,
    "token" VARCHAR(255),
    "activo" VARCHAR(255) NOT NULL DEFAULT 'S',
    "imagen" VARCHAR(255),
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),
    "identifier" VARCHAR(255),
    "authCode" VARCHAR(6),
    "OTPSend" BOOLEAN NOT NULL DEFAULT false,
    "OTPWhatsapp" BOOLEAN NOT NULL DEFAULT false,
    "OTPSMS" BOOLEAN NOT NULL DEFAULT false,
    "fecha_acceso_enlace" TIMESTAMP(0),
    "fecha_recepcion_otp" TIMESTAMP(0),
    "fecha_verificacion_otp" TIMESTAMP(0),
    "fecha_inicio_firma" TIMESTAMP(0),
    "fecha_fin_firma" TIMESTAMP(0),
    "Biometrico" BOOLEAN NOT NULL DEFAULT false,
    "imagen_dni_anverso" VARCHAR(255),
    "imagen_dni_reverso" VARCHAR(255),
    "imagen_firmante" VARCHAR(255),
    "link_expiration" INTEGER,
    "signer_identification" VARCHAR(50),
    "id_api" VARCHAR(50),

    CONSTRAINT "archivo_firmantes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "archivos" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "carpeta_id" BIGINT NOT NULL,
    "nombre" VARCHAR(150) NOT NULL,
    "tamanio" VARCHAR(15) NOT NULL,
    "file" VARCHAR(50) NOT NULL,
    "file_imagen_qr" VARCHAR(255),
    "file_qr" VARCHAR(50),
    "file_nombre" VARCHAR(255),
    "file_ruta" VARCHAR(255),
    "file_code" VARCHAR(15),
    "file_token" VARCHAR(255),
    "file_firmado" CHAR(1) NOT NULL DEFAULT 'N',
    "file_sello" CHAR(1) NOT NULL DEFAULT 'N',
    "file_validado" CHAR(1) NOT NULL DEFAULT 'N',
    "json_validado" TEXT,
    "firmas" SMALLINT NOT NULL DEFAULT 0,
    "tipo" CHAR(1) NOT NULL DEFAULT 'D',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),
    "sellos" INTEGER NOT NULL DEFAULT 0,
    "origin_file" VARCHAR(255),
    "summary_file" VARCHAR(255),

    CONSTRAINT "archivos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "asignar_pagos" (
    "id" BIGSERIAL NOT NULL,
    "cliente_user_id" BIGINT NOT NULL,
    "categoria_id" BIGINT NOT NULL,
    "catalogo_id" BIGINT NOT NULL,
    "precio" DOUBLE PRECISION,
    "saldo" DOUBLE PRECISION,
    "precio_anterior" DOUBLE PRECISION,
    "anio" CHAR(4) NOT NULL,
    "vencimiento_pago" DATE,
    "vencimiento_firma" DATE,
    "fecha_pago" DATE,
    "fecha_contrato" DATE,
    "observacion" VARCHAR(255),
    "anulado" CHAR(2) NOT NULL DEFAULT 'NO',
    "forma_pago" VARCHAR(50),
    "banco" VARCHAR(50),
    "banco_operacion" VARCHAR(50),
    "banco_observacion" VARCHAR(255),
    "archivo" VARCHAR(255),
    "archivo_token" VARCHAR(255),
    "validado" CHAR(2),
    "notificado" SMALLINT NOT NULL DEFAULT 0,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "asignar_pagos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "avisos" (
    "id" BIGSERIAL NOT NULL,
    "titulo" VARCHAR(100) NOT NULL,
    "mensaje" TEXT,
    "file" VARCHAR(255),
    "file_nombre" VARCHAR(255),
    "file_ruta" VARCHAR(255),
    "file_token" VARCHAR(255),
    "fecha_inicio" DATE NOT NULL,
    "fecha_fin" DATE NOT NULL,
    "tiempo" SMALLINT,
    "link" VARCHAR(255),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "avisos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bolsas" (
    "id" BIGSERIAL NOT NULL,
    "tipo_certificado_id" BIGINT NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "descripcion" VARCHAR(255),
    "cantidad" SMALLINT NOT NULL,
    "precio_unidad" DOUBLE PRECISION NOT NULL,
    "total" DOUBLE PRECISION NOT NULL,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "bolsas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "carpetas" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "descripcion" VARCHAR(255),
    "token" VARCHAR(255),
    "token_api" VARCHAR(255),
    "tipo" CHAR(1) NOT NULL DEFAULT 'D',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "carpetas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "catalogos" (
    "id" BIGSERIAL NOT NULL,
    "categoria_id" BIGINT NOT NULL,
    "concepto" VARCHAR(50) NOT NULL,
    "descripcion" VARCHAR(100),
    "precio" DOUBLE PRECISION NOT NULL,
    "tipo" VARCHAR(20),
    "cantidad_carpetas" INTEGER NOT NULL DEFAULT 0,
    "cantidad_archivos" INTEGER NOT NULL DEFAULT 0,
    "cantidad_firmas" INTEGER NOT NULL DEFAULT 0,
    "anio" CHAR(4),
    "vencimiento_pago" DATE,
    "vencimiento_firma" DATE,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "catalogos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categorias" (
    "id" BIGSERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "firmas" INTEGER NOT NULL DEFAULT 0,
    "periodo" VARCHAR(100) NOT NULL DEFAULT 'MENSUAL',
    "precio_base" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "certificado" CHAR(1) NOT NULL DEFAULT 'N',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "categorias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "certificados" (
    "id" BIGSERIAL NOT NULL,
    "tipo_certificado_id" BIGINT NOT NULL,
    "contador" BIGINT,
    "anio" VARCHAR(6),
    "pedido" VARCHAR(20),
    "numero_documento" VARCHAR(20),
    "denominacion" VARCHAR(255),
    "direccion_fiscal" VARCHAR(255),
    "pais" VARCHAR(50),
    "ubigeo" VARCHAR(10),
    "departamento" VARCHAR(50),
    "provincia" VARCHAR(50),
    "distrito" VARCHAR(50),
    "representante" CHAR(2) DEFAULT 'NO',
    "dni_representante" VARCHAR(16),
    "nombre_representante" VARCHAR(150),
    "tipo_documento_id" BIGINT NOT NULL,
    "numero_documento_titular" VARCHAR(20) NOT NULL,
    "denominacion_titular" VARCHAR(255) NOT NULL,
    "cargo_titular" VARCHAR(255),
    "area_titular" VARCHAR(255),
    "email_envio" VARCHAR(50) NOT NULL,
    "telefono_codigo" VARCHAR(20) NOT NULL,
    "telefono_validacion" VARCHAR(20),
    "codigo_sunat" VARCHAR(255),
    "numero_documento_facturacion" VARCHAR(20),
    "denominacion_facturacion" VARCHAR(255),
    "direccion_facturacion" VARCHAR(255),
    "ubigeo_facturacion" VARCHAR(8),
    "acepto_contrato" CHAR(2) NOT NULL DEFAULT 'SI',
    "periodo_certificado" VARCHAR(6) NOT NULL DEFAULT '12',
    "fecha_solicitud" TIMESTAMP(0) NOT NULL,
    "fecha_inicio" DATE,
    "fecha_vencimiento" DATE,
    "fecha_revocado" DATE,
    "archivo_cer" TEXT,
    "token_cer" TEXT,
    "anterior_certificado_id" BIGINT,
    "numero_colegiatura" VARCHAR(50),
    "poder" CHAR(2),
    "rne" VARCHAR(10),
    "fecha_llamada" TIMESTAMP(0),
    "estado_llamada" CHAR(2),
    "link_video_llamada" TEXT,
    "operador_user_id" BIGINT NOT NULL,
    "observacion" VARCHAR(255),
    "observacion_voucher" CHAR(2) NOT NULL DEFAULT 'NO',
    "codec" VARCHAR(50),
    "anulado" CHAR(2) NOT NULL DEFAULT 'NO',
    "token_criptografico" CHAR(2) NOT NULL DEFAULT 'NO',
    "fecha_voucher" TIMESTAMP(0),
    "renovado" CHAR(2) NOT NULL DEFAULT 'NO',
    "verificado" CHAR(2) NOT NULL DEFAULT 'NO',
    "observacion_operador" TEXT,
    "costo" DOUBLE PRECISION NOT NULL,
    "descuento" CHAR(2) NOT NULL DEFAULT 'NO',
    "monto_descuento" DOUBLE PRECISION,
    "descuento_autorizado" VARCHAR(255),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),
    "token" VARCHAR(255),
    "token_api" VARCHAR(255),
    "cod_horavalidacion" INTEGER,

    CONSTRAINT "certificados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "compartidos" (
    "id" BIGSERIAL NOT NULL,
    "carpeta_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "destino_user_id" BIGINT NOT NULL,
    "destino_email" VARCHAR(100) NOT NULL,
    "tipo" CHAR(1) NOT NULL DEFAULT 'D',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "compartidos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "configuraciones" (
    "id" BIGSERIAL NOT NULL,
    "nombre_sistema" VARCHAR(100) DEFAULT 'FIRMEASY.TECH',
    "nombre_whatsapp" VARCHAR(255) DEFAULT 'FIRMEASY.TECH CERTIFICADOS',
    "logo_corto" VARCHAR(255),
    "logo_completo" VARCHAR(255),
    "ruc" VARCHAR(20) DEFAULT '20600787595',
    "razon_social" VARCHAR(255) DEFAULT 'CORPORACION PERUANA GTP EIRL',
    "telefono" VARCHAR(100) DEFAULT '+51943503953',
    "email" VARCHAR(100) DEFAULT 'contacto@firmeasy.tech',
    "direccion" VARCHAR(255) DEFAULT 'Jr. Tupac Yupanqui 143, Amarilis - Paucarbamba',
    "cuenta_bcp" VARCHAR(100),
    "cuenta_interbank" VARCHAR(100),
    "cuenta_scotiabank" VARCHAR(100),
    "cuenta_bbva" VARCHAR(100),
    "cuenta_otros" VARCHAR(255),
    "maximo_horas" VARCHAR(20) NOT NULL DEFAULT '2400',
    "maximo_carpetas" VARCHAR(20) NOT NULL DEFAULT '1',
    "maximo_archivos" VARCHAR(20) NOT NULL DEFAULT '5',
    "maximo_firmas" VARCHAR(20) NOT NULL DEFAULT '10',
    "maximo_sellos" VARCHAR(20) NOT NULL DEFAULT '10',
    "maximo_validaciones" VARCHAR(20) NOT NULL DEFAULT '10',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "configuraciones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dato_facturaciones" (
    "id" BIGSERIAL NOT NULL,
    "cliente_user_id" BIGINT NOT NULL,
    "tipo_documento_id" BIGINT NOT NULL,
    "codigo_sunat" VARCHAR(5),
    "numero_documento" VARCHAR(15),
    "razon_social" VARCHAR(255),
    "direccion" VARCHAR(255),
    "ubigeo" VARCHAR(10),
    "departamento" VARCHAR(100),
    "provincia" VARCHAR(100),
    "distrito" VARCHAR(100),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "dato_facturaciones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "departamentos" (
    "id" CHAR(2) NOT NULL,
    "descripcion" VARCHAR(255) NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true
);

-- CreateTable
CREATE TABLE "detalle_anticipos" (
    "id" BIGSERIAL NOT NULL,
    "anticipo_id" BIGINT NOT NULL,
    "certificado_id" BIGINT NOT NULL,
    "cliente_user_id" BIGINT NOT NULL,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "detalle_anticipos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalle_pagos" (
    "id" BIGSERIAL NOT NULL,
    "pago_id" BIGINT NOT NULL,
    "cliente_user_id" BIGINT NOT NULL,
    "catalogo_id" BIGINT NOT NULL,
    "asignar_pago_id" BIGINT,
    "cantidad" SMALLINT NOT NULL DEFAULT 1,
    "monto" DOUBLE PRECISION,
    "importe" DOUBLE PRECISION,
    "anulado" CHAR(2) NOT NULL DEFAULT 'NO',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "detalle_pagos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalles_validacion_identidad" (
    "id" BIGSERIAL NOT NULL,
    "certificado_id" BIGINT NOT NULL,
    "tipo_certificado_id" BIGINT NOT NULL,
    "token_validacion" VARCHAR(255),
    "token_dni_anverso" VARCHAR(255),
    "token_dni_reverso" VARCHAR(255),
    "token_selfie" VARCHAR(255),
    "numero_documento_titular" VARCHAR(100),
    "nombre_completo" VARCHAR(100),
    "ubigeo" VARCHAR(100),
    "fecha_nacimiento" VARCHAR(100),
    "fecha_caducidad" VARCHAR(100),
    "similitud" VARCHAR(255),
    "tiempo" VARCHAR(255),
    "user_id" BIGINT NOT NULL,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "detalles_validacion_identidad_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "distritos" (
    "id" CHAR(6) NOT NULL,
    "provincia_id" CHAR(4) NOT NULL,
    "descripcion" VARCHAR(255) NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "tipoalcance" VARCHAR(100)
);

-- CreateTable
CREATE TABLE "enlace_certificado_validacion" (
    "id" BIGSERIAL NOT NULL,
    "certificado_id" BIGINT NOT NULL,
    "tipo_certificado_id" BIGINT NOT NULL,
    "token" VARCHAR(255),
    "url" VARCHAR(255),
    "tiempo" SMALLINT NOT NULL DEFAULT 1,
    "tiempo_otp" VARCHAR(30),
    "codigo_otp" VARCHAR(30),
    "tipo" CHAR(2),
    "codigo_validador" CHAR(100),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "enlace_certificado_validacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "enlaces" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "carpeta_id" BIGINT,
    "archivo_id" BIGINT,
    "token" VARCHAR(255) NOT NULL,
    "url" VARCHAR(255) NOT NULL,
    "tiempo" SMALLINT NOT NULL DEFAULT 1,
    "firma_electronica" VARCHAR(255),
    "tipo" CHAR(1) NOT NULL DEFAULT 'D',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "enlaces_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "enlaces_cert" (
    "id" BIGSERIAL NOT NULL,
    "certificado_id" BIGINT NOT NULL,
    "token" VARCHAR(255),
    "url" VARCHAR(255),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "enlaces_cert_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "factura_certificados" (
    "id" BIGSERIAL NOT NULL,
    "certificado_id" BIGINT NOT NULL,
    "serie_id" BIGINT NOT NULL,
    "fecha_emision" DATE NOT NULL,
    "subtotal" DOUBLE PRECISION,
    "igv" DOUBLE PRECISION,
    "total" DOUBLE PRECISION,
    "external_id" VARCHAR(255),
    "file_name" VARCHAR(100),
    "hash" VARCHAR(100),
    "number" VARCHAR(10),
    "number_to_letter" VARCHAR(255),
    "file_cdr" TEXT,
    "file_xml" TEXT,
    "file_pdf" TEXT,
    "image_qr" TEXT,
    "serial_number" VARCHAR(100),
    "serial" VARCHAR(50),
    "state_sunat" VARCHAR(50),
    "message_sunat" VARCHAR(150),
    "observacion" VARCHAR(255),
    "anulado" CHAR(2) NOT NULL DEFAULT 'NO',
    "ticket_anulado" VARCHAR(50),
    "external_id_anulado" VARCHAR(50),
    "codigo_anulado" VARCHAR(50),
    "mensaje_anulado" VARCHAR(255),
    "xml_anulado" TEXT,
    "cdr_anulado" TEXT,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "factura_certificados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "historial_certificados" (
    "id" BIGSERIAL NOT NULL,
    "certificado_id" BIGINT NOT NULL,
    "estado" VARCHAR(50) NOT NULL,
    "codigo" CHAR(2),
    "comentario" VARCHAR(100) NOT NULL,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "historial_certificados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "historiales" (
    "id" BIGSERIAL NOT NULL,
    "accion" VARCHAR(50) NOT NULL,
    "carpeta_id" BIGINT,
    "archivo_id" BIGINT,
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "historiales_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "horavalidacion" (
    "id" BIGSERIAL NOT NULL,
    "hora" TIME(0),
    "cod_operador" BIGINT NOT NULL,
    "estado" VARCHAR(255),
    "cod_dia" INTEGER,
    "fecha_llamada" TIMESTAMP(0),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "horavalidacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mensajes" (
    "id" BIGSERIAL NOT NULL,
    "titulo" VARCHAR(100) NOT NULL,
    "mensaje" TEXT NOT NULL,
    "file" VARCHAR(255),
    "file_token" VARCHAR(255),
    "file_link" VARCHAR(255),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "mensajes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "menus" (
    "id" BIGSERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "favicon" VARCHAR(50) NOT NULL,
    "route" VARCHAR(100) NOT NULL,
    "url" VARCHAR(100) NOT NULL,
    "orden" SMALLINT NOT NULL,
    "submenus" CHAR(1) NOT NULL DEFAULT 'N',
    "tipo" CHAR(1) NOT NULL DEFAULT 'E',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "menus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "migrations" (
    "id" SERIAL NOT NULL,
    "migration" VARCHAR(255) NOT NULL,
    "batch" INTEGER NOT NULL,

    CONSTRAINT "migrations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notificaciones" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "tipo_cliente" VARCHAR(100),
    "recibir_notificacion" CHAR(2) NOT NULL DEFAULT 'SI',
    "cantidad" SMALLINT NOT NULL DEFAULT 1,
    "mensaje_id" BIGINT,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "notificaciones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pago_certificados" (
    "id" BIGSERIAL NOT NULL,
    "certificado_id" BIGINT NOT NULL,
    "medio_pago" VARCHAR(50) NOT NULL,
    "numero_operacion" VARCHAR(20) NOT NULL,
    "descripcion" VARCHAR(100),
    "monto" DOUBLE PRECISION NOT NULL,
    "fecha_pago" DATE,
    "observacion" VARCHAR(255),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "pago_certificados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pagos" (
    "id" BIGSERIAL NOT NULL,
    "cliente_user_id" BIGINT NOT NULL,
    "catalogo_id" BIGINT,
    "asignar_pago_id" BIGINT,
    "serie_id" BIGINT NOT NULL,
    "fecha_emision" DATE,
    "subtotal" DOUBLE PRECISION,
    "igv" DOUBLE PRECISION,
    "total" DOUBLE PRECISION,
    "forma_pago" VARCHAR(50),
    "numero_operacion" VARCHAR(50),
    "tipo_documento_sunat" VARCHAR(10),
    "numero_documento" VARCHAR(15),
    "razon_social" VARCHAR(255),
    "external_id" VARCHAR(255),
    "file_name" VARCHAR(100),
    "hash" VARCHAR(100),
    "number" VARCHAR(10),
    "number_to_letter" VARCHAR(255),
    "file_cdr" TEXT,
    "file_xml" TEXT,
    "file_pdf" TEXT,
    "image_qr" TEXT,
    "serial_number" VARCHAR(100),
    "serial" VARCHAR(50),
    "state_sunat" VARCHAR(50),
    "message_sunat" VARCHAR(150),
    "observacion" VARCHAR(255),
    "anulado" CHAR(2) NOT NULL DEFAULT 'NO',
    "ticket_anulado" VARCHAR(50),
    "external_id_anulado" VARCHAR(50),
    "codigo_anulado" VARCHAR(50),
    "mensaje_anulado" VARCHAR(255),
    "xml_anulado" TEXT,
    "cdr_anulado" TEXT,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "pagos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "password_resets" (
    "email" VARCHAR(255) NOT NULL,
    "token" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(0)
);

-- CreateTable
CREATE TABLE "personal_access_tokens" (
    "id" BIGSERIAL NOT NULL,
    "tokenable_type" VARCHAR(255) NOT NULL,
    "tokenable_id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "token" VARCHAR(64) NOT NULL,
    "abilities" TEXT,
    "last_used_at" TIMESTAMP(0),
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "personal_access_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plan_certificados" (
    "id" BIGSERIAL NOT NULL,
    "tipo_certificado_id" BIGINT NOT NULL,
    "tipouser" BIGINT NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "precio_base" DOUBLE PRECISION NOT NULL,
    "precio_venta" DOUBLE PRECISION NOT NULL,
    "periodo" SMALLINT NOT NULL,
    "comentario" VARCHAR(100),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "plan_certificados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "planes_firmeasy_caracteristicas" (
    "id" BIGSERIAL NOT NULL,
    "categoria_id" BIGINT NOT NULL,
    "nombre" VARCHAR(255) NOT NULL,
    "descripcion" TEXT,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "planes_firmeasy_caracteristicas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provincias" (
    "id" CHAR(4) NOT NULL,
    "departamento_id" CHAR(2) NOT NULL,
    "descripcion" VARCHAR(255) NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true
);

-- CreateTable
CREATE TABLE "recargas" (
    "id" BIGSERIAL NOT NULL,
    "cliente_user_id" BIGINT NOT NULL,
    "serie_id" BIGINT NOT NULL,
    "fecha_emision" DATE,
    "subtotal" DOUBLE PRECISION,
    "igv" DOUBLE PRECISION,
    "total" DOUBLE PRECISION,
    "forma_pago" VARCHAR(50),
    "numero_operacion" VARCHAR(50),
    "tipo_documento_sunat" VARCHAR(10),
    "numero_documento" VARCHAR(15),
    "razon_social" VARCHAR(255),
    "external_id" VARCHAR(255),
    "file_name" VARCHAR(100),
    "hash" VARCHAR(100),
    "number" VARCHAR(10),
    "number_to_letter" VARCHAR(255),
    "file_cdr" TEXT,
    "file_xml" TEXT,
    "file_pdf" TEXT,
    "image_qr" TEXT,
    "serial_number" VARCHAR(100),
    "serial" VARCHAR(50),
    "state_sunat" VARCHAR(50),
    "message_sunat" VARCHAR(150),
    "observacion" VARCHAR(255),
    "anulado" CHAR(2) NOT NULL DEFAULT 'NO',
    "ticket_anulado" VARCHAR(50),
    "external_id_anulado" VARCHAR(50),
    "codigo_anulado" VARCHAR(50),
    "mensaje_anulado" VARCHAR(255),
    "xml_anulado" TEXT,
    "cdr_anulado" TEXT,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "recargas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rol_submenus" (
    "id" BIGSERIAL NOT NULL,
    "rol_id" BIGINT NOT NULL,
    "menu_id" BIGINT NOT NULL,
    "submenu_id" BIGINT NOT NULL,
    "crear" CHAR(1) NOT NULL DEFAULT 'N',
    "editar" CHAR(1) NOT NULL DEFAULT 'N',
    "eliminar" CHAR(1) NOT NULL DEFAULT 'N',
    "otros" CHAR(1) NOT NULL DEFAULT 'N',
    "activo" CHAR(1) NOT NULL DEFAULT 'N',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "rol_submenus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" BIGSERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "tipo" CHAR(1) NOT NULL DEFAULT 'E',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "series" (
    "id" BIGSERIAL NOT NULL,
    "description" VARCHAR(50) NOT NULL,
    "typedocument_id" CHAR(2) NOT NULL,
    "affected_igv" CHAR(2) NOT NULL,
    "affected_description" VARCHAR(255),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "series_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sub_users_carpeta" (
    "id" BIGSERIAL NOT NULL,
    "parent_user_id" BIGINT,
    "sub_user_id" BIGINT,
    "carpeta_id" BIGINT,

    CONSTRAINT "sub_users_carpeta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "submenus" (
    "id" BIGSERIAL NOT NULL,
    "menu_id" BIGINT NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "route" VARCHAR(100) NOT NULL,
    "url" VARCHAR(100) NOT NULL,
    "orden" SMALLINT NOT NULL,
    "opciones" CHAR(1) NOT NULL DEFAULT 'N',
    "tipo" CHAR(1) NOT NULL DEFAULT 'E',
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "submenus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tipo_certificados" (
    "id" BIGSERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "descripcion" VARCHAR(100) NOT NULL,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "tipo_certificados_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tipo_documentos" (
    "id" BIGSERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "codigo_sunat" CHAR(2) NOT NULL,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "tipo_documentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tipousers" (
    "id" BIGSERIAL NOT NULL,
    "descripcion" VARCHAR(100) NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "tipousers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" BIGSERIAL NOT NULL,
    "plan_id" BIGINT NOT NULL,
    "rol_id" BIGINT NOT NULL,
    "tipo_documento_id" BIGINT NOT NULL,
    "tipouser_id" BIGINT,
    "firmas_disponibles" INTEGER NOT NULL DEFAULT 0,
    "numero_documento" VARCHAR(15) NOT NULL,
    "nombres" VARCHAR(255) NOT NULL,
    "codigo_celular" VARCHAR(5) NOT NULL DEFAULT '+51',
    "celular" VARCHAR(15) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "clave_secreta" CHAR(6) NOT NULL,
    "codigo_afiliacion" CHAR(10),
    "password" VARCHAR(255),
    "firma" VARCHAR(255),
    "firma_auth" VARCHAR(255),
    "token" VARCHAR(255),
    "token_api" VARCHAR(255),
    "token_soporte" VARCHAR(255),
    "remember_token" VARCHAR(100),
    "supervisor_user_id" BIGINT,
    "tipo" CHAR(1) NOT NULL DEFAULT 'E',
    "operador_registro" CHAR(2) NOT NULL DEFAULT 'NO',
    "config_qr" CHAR(1) NOT NULL DEFAULT 'S',
    "config_logo" CHAR(1) NOT NULL DEFAULT 'N',
    "sign_logo" VARCHAR(255),
    "google2fa_secret" TEXT,
    "code_otp" VARCHAR(255),
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),
    "avatar" VARCHAR(255),
    "external_id" VARCHAR(255),
    "external_auth" VARCHAR(255),
    "two_factor_auth" BOOLEAN NOT NULL DEFAULT false,
    "sellos" INTEGER NOT NULL DEFAULT 0,
    "identifier" VARCHAR(255),
    "parent_user_id" BIGINT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "validacion" (
    "id" BIGSERIAL NOT NULL,
    "dni" TEXT,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "validacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ventas" (
    "id" BIGSERIAL NOT NULL,
    "tipo_documento_id" BIGINT NOT NULL,
    "numero_documento" VARCHAR(15) NOT NULL,
    "nombres" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "celular" VARCHAR(255) NOT NULL,
    "informacion_adicional" TEXT,
    "activo" CHAR(1) NOT NULL DEFAULT 'S',
    "user_id" BIGINT,
    "created_at" TIMESTAMP(0),
    "updated_at" TIMESTAMP(0),

    CONSTRAINT "ventas_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "archivo_firmantes_id_api_unique" ON "archivo_firmantes"("id_api");

-- CreateIndex
CREATE INDEX "departamentos_id_index" ON "departamentos"("id");

-- CreateIndex
CREATE INDEX "distritos_id_index" ON "distritos"("id");

-- CreateIndex
CREATE INDEX "password_resets_email_index" ON "password_resets"("email");

-- CreateIndex
CREATE UNIQUE INDEX "personal_access_tokens_token_unique" ON "personal_access_tokens"("token");

-- CreateIndex
CREATE INDEX "personal_access_tokens_tokenable_type_tokenable_id_index" ON "personal_access_tokens"("tokenable_type", "tokenable_id");

-- CreateIndex
CREATE INDEX "provincias_id_index" ON "provincias"("id");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_unique" ON "users"("email");

-- AddForeignKey
ALTER TABLE "anticipos" ADD CONSTRAINT "anticipos_bolsa_id_foreign" FOREIGN KEY ("bolsa_id") REFERENCES "bolsas"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "anticipos" ADD CONSTRAINT "anticipos_cliente_user_id_foreign" FOREIGN KEY ("cliente_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "anticipos" ADD CONSTRAINT "anticipos_serie_id_foreign" FOREIGN KEY ("serie_id") REFERENCES "series"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "anticipos" ADD CONSTRAINT "anticipos_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "apis" ADD CONSTRAINT "apis_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "archivo_certificados" ADD CONSTRAINT "archivo_certificados_certificado_id_foreign" FOREIGN KEY ("certificado_id") REFERENCES "certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "archivo_certificados" ADD CONSTRAINT "archivo_certificados_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "archivo_firmantes" ADD CONSTRAINT "archivo_firmantes_archivo_id_foreign" FOREIGN KEY ("archivo_id") REFERENCES "archivos"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "archivos" ADD CONSTRAINT "archivos_carpeta_id_foreign" FOREIGN KEY ("carpeta_id") REFERENCES "carpetas"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "archivos" ADD CONSTRAINT "archivos_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "asignar_pagos" ADD CONSTRAINT "asignar_pagos_catalogo_id_foreign" FOREIGN KEY ("catalogo_id") REFERENCES "catalogos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "asignar_pagos" ADD CONSTRAINT "asignar_pagos_categoria_id_foreign" FOREIGN KEY ("categoria_id") REFERENCES "categorias"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "asignar_pagos" ADD CONSTRAINT "asignar_pagos_cliente_user_id_foreign" FOREIGN KEY ("cliente_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "asignar_pagos" ADD CONSTRAINT "asignar_pagos_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "avisos" ADD CONSTRAINT "avisos_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "bolsas" ADD CONSTRAINT "bolsas_tipo_certificado_id_foreign" FOREIGN KEY ("tipo_certificado_id") REFERENCES "tipo_certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "bolsas" ADD CONSTRAINT "bolsas_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "carpetas" ADD CONSTRAINT "carpetas_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "catalogos" ADD CONSTRAINT "catalogos_categoria_id_foreign" FOREIGN KEY ("categoria_id") REFERENCES "categorias"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "catalogos" ADD CONSTRAINT "catalogos_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "certificados" ADD CONSTRAINT "certificados_anterior_certificado_id_foreign" FOREIGN KEY ("anterior_certificado_id") REFERENCES "certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "certificados" ADD CONSTRAINT "certificados_operador_user_id_foreign" FOREIGN KEY ("operador_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "certificados" ADD CONSTRAINT "certificados_tipo_certificado_id_foreign" FOREIGN KEY ("tipo_certificado_id") REFERENCES "tipo_certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "certificados" ADD CONSTRAINT "certificados_tipo_documento_id_foreign" FOREIGN KEY ("tipo_documento_id") REFERENCES "tipo_documentos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "certificados" ADD CONSTRAINT "certificados_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "compartidos" ADD CONSTRAINT "compartidos_carpeta_id_foreign" FOREIGN KEY ("carpeta_id") REFERENCES "carpetas"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "compartidos" ADD CONSTRAINT "compartidos_destino_user_id_foreign" FOREIGN KEY ("destino_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "compartidos" ADD CONSTRAINT "compartidos_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "configuraciones" ADD CONSTRAINT "configuraciones_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dato_facturaciones" ADD CONSTRAINT "dato_facturaciones_cliente_user_id_foreign" FOREIGN KEY ("cliente_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dato_facturaciones" ADD CONSTRAINT "dato_facturaciones_tipo_documento_id_foreign" FOREIGN KEY ("tipo_documento_id") REFERENCES "tipo_documentos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dato_facturaciones" ADD CONSTRAINT "dato_facturaciones_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalle_anticipos" ADD CONSTRAINT "detalle_anticipos_anticipo_id_foreign" FOREIGN KEY ("anticipo_id") REFERENCES "anticipos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalle_anticipos" ADD CONSTRAINT "detalle_anticipos_certificado_id_foreign" FOREIGN KEY ("certificado_id") REFERENCES "certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalle_anticipos" ADD CONSTRAINT "detalle_anticipos_cliente_user_id_foreign" FOREIGN KEY ("cliente_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalle_pagos" ADD CONSTRAINT "detalle_pagos_asignar_pago_id_foreign" FOREIGN KEY ("asignar_pago_id") REFERENCES "asignar_pagos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalle_pagos" ADD CONSTRAINT "detalle_pagos_catalogo_id_foreign" FOREIGN KEY ("catalogo_id") REFERENCES "catalogos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalle_pagos" ADD CONSTRAINT "detalle_pagos_cliente_user_id_foreign" FOREIGN KEY ("cliente_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalle_pagos" ADD CONSTRAINT "detalle_pagos_pago_id_foreign" FOREIGN KEY ("pago_id") REFERENCES "pagos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalle_pagos" ADD CONSTRAINT "detalle_pagos_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_validacion_identidad" ADD CONSTRAINT "detalles_validacion_identidad_certificado_id_foreign" FOREIGN KEY ("certificado_id") REFERENCES "certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_validacion_identidad" ADD CONSTRAINT "detalles_validacion_identidad_tipo_certificado_id_foreign" FOREIGN KEY ("tipo_certificado_id") REFERENCES "tipo_certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "detalles_validacion_identidad" ADD CONSTRAINT "detalles_validacion_identidad_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enlace_certificado_validacion" ADD CONSTRAINT "enlace_certificado_validacion_certificado_id_foreign" FOREIGN KEY ("certificado_id") REFERENCES "certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enlace_certificado_validacion" ADD CONSTRAINT "enlace_certificado_validacion_tipo_certificado_id_foreign" FOREIGN KEY ("tipo_certificado_id") REFERENCES "tipo_certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enlace_certificado_validacion" ADD CONSTRAINT "enlace_certificado_validacion_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enlaces" ADD CONSTRAINT "enlaces_archivo_id_foreign" FOREIGN KEY ("archivo_id") REFERENCES "archivos"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enlaces" ADD CONSTRAINT "enlaces_carpeta_id_foreign" FOREIGN KEY ("carpeta_id") REFERENCES "carpetas"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enlaces" ADD CONSTRAINT "enlaces_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "enlaces_cert" ADD CONSTRAINT "enlaces_cert_certificado_id_foreign" FOREIGN KEY ("certificado_id") REFERENCES "certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "factura_certificados" ADD CONSTRAINT "factura_certificados_certificado_id_foreign" FOREIGN KEY ("certificado_id") REFERENCES "certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "factura_certificados" ADD CONSTRAINT "factura_certificados_serie_id_foreign" FOREIGN KEY ("serie_id") REFERENCES "series"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "factura_certificados" ADD CONSTRAINT "factura_certificados_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "historial_certificados" ADD CONSTRAINT "historial_certificados_certificado_id_foreign" FOREIGN KEY ("certificado_id") REFERENCES "certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "historial_certificados" ADD CONSTRAINT "historial_certificados_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "historiales" ADD CONSTRAINT "historiales_archivo_id_foreign" FOREIGN KEY ("archivo_id") REFERENCES "archivos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "historiales" ADD CONSTRAINT "historiales_carpeta_id_foreign" FOREIGN KEY ("carpeta_id") REFERENCES "carpetas"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "historiales" ADD CONSTRAINT "historiales_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "horavalidacion" ADD CONSTRAINT "horavalidacion_cod_operador_foreign" FOREIGN KEY ("cod_operador") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mensajes" ADD CONSTRAINT "mensajes_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "menus" ADD CONSTRAINT "menus_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "notificaciones" ADD CONSTRAINT "notificaciones_mensaje_id_foreign" FOREIGN KEY ("mensaje_id") REFERENCES "mensajes"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "notificaciones" ADD CONSTRAINT "notificaciones_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pago_certificados" ADD CONSTRAINT "pago_certificados_certificado_id_foreign" FOREIGN KEY ("certificado_id") REFERENCES "certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pago_certificados" ADD CONSTRAINT "pago_certificados_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pagos" ADD CONSTRAINT "pagos_asignar_pago_id_foreign" FOREIGN KEY ("asignar_pago_id") REFERENCES "asignar_pagos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pagos" ADD CONSTRAINT "pagos_catalogo_id_foreign" FOREIGN KEY ("catalogo_id") REFERENCES "catalogos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pagos" ADD CONSTRAINT "pagos_cliente_user_id_foreign" FOREIGN KEY ("cliente_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pagos" ADD CONSTRAINT "pagos_serie_id_foreign" FOREIGN KEY ("serie_id") REFERENCES "series"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pagos" ADD CONSTRAINT "pagos_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "plan_certificados" ADD CONSTRAINT "plan_certificados_tipo_certificado_id_foreign" FOREIGN KEY ("tipo_certificado_id") REFERENCES "tipo_certificados"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "plan_certificados" ADD CONSTRAINT "plan_certificados_tipouser_foreign" FOREIGN KEY ("tipouser") REFERENCES "tipousers"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "plan_certificados" ADD CONSTRAINT "plan_certificados_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "planes_firmeasy_caracteristicas" ADD CONSTRAINT "planes_firmeasy_caracteristicas_categoria_id_foreign" FOREIGN KEY ("categoria_id") REFERENCES "categorias"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "recargas" ADD CONSTRAINT "recargas_cliente_user_id_foreign" FOREIGN KEY ("cliente_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "recargas" ADD CONSTRAINT "recargas_serie_id_foreign" FOREIGN KEY ("serie_id") REFERENCES "series"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "recargas" ADD CONSTRAINT "recargas_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "rol_submenus" ADD CONSTRAINT "rol_submenus_menu_id_foreign" FOREIGN KEY ("menu_id") REFERENCES "menus"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "rol_submenus" ADD CONSTRAINT "rol_submenus_rol_id_foreign" FOREIGN KEY ("rol_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "rol_submenus" ADD CONSTRAINT "rol_submenus_submenu_id_foreign" FOREIGN KEY ("submenu_id") REFERENCES "submenus"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "rol_submenus" ADD CONSTRAINT "rol_submenus_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "series" ADD CONSTRAINT "series_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sub_users_carpeta" ADD CONSTRAINT "sub_users_carpeta_carpeta_id_foreign" FOREIGN KEY ("carpeta_id") REFERENCES "carpetas"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sub_users_carpeta" ADD CONSTRAINT "sub_users_carpeta_parent_user_id_foreign" FOREIGN KEY ("parent_user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sub_users_carpeta" ADD CONSTRAINT "sub_users_carpeta_sub_user_id_foreign" FOREIGN KEY ("sub_user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "submenus" ADD CONSTRAINT "submenus_menu_id_foreign" FOREIGN KEY ("menu_id") REFERENCES "menus"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "submenus" ADD CONSTRAINT "submenus_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tipo_certificados" ADD CONSTRAINT "tipo_certificados_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_parent_user_id_foreign" FOREIGN KEY ("parent_user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_plan_id_foreign" FOREIGN KEY ("plan_id") REFERENCES "categorias"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_rol_id_foreign" FOREIGN KEY ("rol_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_supervisor_user_id_foreign" FOREIGN KEY ("supervisor_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_tipo_documento_id_foreign" FOREIGN KEY ("tipo_documento_id") REFERENCES "tipo_documentos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_tipouser_id_foreign" FOREIGN KEY ("tipouser_id") REFERENCES "tipousers"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "validacion" ADD CONSTRAINT "validacion_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ventas" ADD CONSTRAINT "ventas_tipo_documento_id_foreign" FOREIGN KEY ("tipo_documento_id") REFERENCES "tipo_documentos"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ventas" ADD CONSTRAINT "ventas_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;
