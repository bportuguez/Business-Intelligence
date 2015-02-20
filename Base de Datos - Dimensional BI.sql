/*==============================================================*/
/* Nombre de la Base de Datos:      BI_FITWORLDGYM              */
/* Fecha de creación:               07/09/2014                  */
/*==============================================================*/
USE MASTER;
GO
CREATE DATABASE BI_FITWORLDGYM;
GO
USE BI_FITWORLDGYM;

/*==============================================================*/
/* Tabla: DIM_CLIENT                                            */
/*==============================================================*/
CREATE TABLE DIM_CLIENT 
(
   SK_CLIENT            INT          identity(1,1) NOT NULL,
   ID_CLIENT			   VARCHAR(25)					   NOT NULL,
   NAME                 VARCHAR(50)                    NULL,
   CATEGORY             VARCHAR(25)                    NULL,
   MEMBERTYPE           VARCHAR(25)                    NULL,
   UBICATION            VARCHAR(50)                    NULL
);

ALTER TABLE DIM_CLIENT
   ADD CONSTRAINT PK_DIM_CLIENT PRIMARY KEY CLUSTERED (SK_CLIENT);

/*==============================================================*/
/* Tabla: DIM_PRODUCT                                           */
/*==============================================================*/
CREATE TABLE DIM_PRODUCT 
(
   SK_PRODUCT           INT          identity(1,1) NOT NULL,
   ID_PRODUCT			   VARCHAR(25)					   NOT NULL,
   NAME                 VARCHAR(50)                    NULL,
   PRICE                FLOAT(5)                       NULL,
   CATEGORY             VARCHAR(25)                    NULL
);

ALTER TABLE DIM_PRODUCT
   ADD CONSTRAINT PK_DIM_PRODUCT PRIMARY KEY CLUSTERED (SK_PRODUCT);

/*==============================================================*/
/* Table: DIM_TIME                                              */
/*==============================================================*/
CREATE TABLE DIM_TIME 
(
   SK_TIME              INT          identity(1,1) NOT NULL,
   YEAR                 INT                            NULL,
   MONTH                INT		                      NULL,
   DAY                  INT                            NULL
);

ALTER TABLE DIM_TIME
   ADD CONSTRAINT PK_DIM_TIME PRIMARY KEY CLUSTERED (SK_TIME);

/*==============================================================*/
/* Table: FACT_SALES                                            */
/*==============================================================*/
CREATE TABLE FACT_SALES 
(
   SK_CLIENT            INT                            NULL,
   SK_PRODUCT           INT                            NULL,
   SK_TIME              INT                            NULL,
   AMOUNTSALES          INT                            NULL
);

/*==============================================================*/
/* FOREING KEYS                                                 */
/*==============================================================*/
ALTER TABLE FACT_SALES
   ADD CONSTRAINT FK_FACT_SAL_REFERENCE_DIM_CLIE FOREIGN KEY (SK_CLIENT)
      REFERENCES DIM_CLIENT (SK_CLIENT);

ALTER TABLE FACT_SALES
   ADD CONSTRAINT FK_FACT_SAL_REFERENCE_DIM_PROD FOREIGN KEY (SK_PRODUCT)
      REFERENCES DIM_PRODUCT (SK_PRODUCT);

ALTER TABLE FACT_SALES
   ADD CONSTRAINT FK_FACT_SAL_REFERENCE_DIM_TIME FOREIGN KEY (SK_TIME)
      REFERENCES DIM_TIME (SK_TIME);