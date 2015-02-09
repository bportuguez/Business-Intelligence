/*==============================================================*/
/* Nombre de la Base de Datos:      OLTP_FITWORLDGYM            */
/* Fecha de creación:               07/09/2014                  */
/*==============================================================*/
USE MASTER;
CREATE DATABASE OLTP_FITWORLDGYM;

USE OLTP_FITWORLDGYM;

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MEMBER') and o.name = 'FK_MEMBER_REFERENCE_MEMBERSH')
alter table MEMBER
   drop constraint FK_MEMBER_REFERENCE_MEMBERSH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ONEDAYPASS') and o.name = 'FK_ONEDAYPA_BUYS_MEMBER')
alter table ONEDAYPASS
   drop constraint FK_ONEDAYPA_BUYS_MEMBER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ONEDAYPASS') and o.name = 'FK_ONEDAYPA_IS_OF_PASSCATE')
alter table ONEDAYPASS
   drop constraint FK_ONEDAYPA_IS_OF_PASSCATE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SALETRANSACT') and o.name = 'FK_SALETRAN_BUYSVIA_MEMBER')
alter table SALETRANSACT
   drop constraint FK_SALETRAN_BUYSVIA_MEMBER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SOLDVIA') and o.name = 'FK_SOLDVIA_SOLDVIA_MERCHAND')
alter table SOLDVIA
   drop constraint FK_SOLDVIA_SOLDVIA_MERCHAND
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SOLDVIA') and o.name = 'FK_SOLDVIA_SOLDVIA2_SALETRAN')
alter table SOLDVIA
   drop constraint FK_SOLDVIA_SOLDVIA2_SALETRAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MEMBER')
            and   type = 'U')
   drop table MEMBER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MEMBERSHIP')
            and   type = 'U')
   drop table MEMBERSHIP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MERCHANDISE')
            and   type = 'U')
   drop table MERCHANDISE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ONEDAYPASS')
            and   name  = 'BUYS_FK'
            and   indid > 0
            and   indid < 255)
   drop index ONEDAYPASS.BUYS_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ONEDAYPASS')
            and   name  = 'IS_OF_FK'
            and   indid > 0
            and   indid < 255)
   drop index ONEDAYPASS.IS_OF_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ONEDAYPASS')
            and   type = 'U')
   drop table ONEDAYPASS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PASSCATEGOY')
            and   type = 'U')
   drop table PASSCATEGOY
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SALETRANSACT')
            and   name  = 'BUYSVIA_FK'
            and   indid > 0
            and   indid < 255)
   drop index SALETRANSACT.BUYSVIA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SALETRANSACT')
            and   type = 'U')
   drop table SALETRANSACT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SOLDVIA')
            and   name  = 'SOLDVIA_FK'
            and   indid > 0
            and   indid < 255)
   drop index SOLDVIA.SOLDVIA_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SOLDVIA')
            and   name  = 'SOLDVIA2_FK'
            and   indid > 0
            and   indid < 255)
   drop index SOLDVIA.SOLDVIA2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SOLDVIA')
            and   type = 'U')
   drop table SOLDVIA
go

/*==============================================================*/
/* Tabla: MEMBER                                                */
/*==============================================================*/
create table MEMBER (
   MEMBID               int                  not null,
   MEMBNAME             varchar(50)              null,
   MEMBZIP              varchar(50)              null,
   MSHPID               varchar(5)               null,
   MSDATEPAYED          date                     null,
   constraint PK_MEMBER primary key nonclustered (MEMBID)
)
go

/*==============================================================*/
/* Tabla: MEMBERSHIP                                            */
/*==============================================================*/
create table MEMBERSHIP (
   MSHPID               varchar(5)           not null,
   MSHPNAME             varchar(50)              null,
   MSHPPRICE            float(5)                 null,
   constraint PK_MEMBERSHIP primary key nonclustered (MSHPID)
)
go

/*==============================================================*/
/* Tabla: MERCHANDISE                                           */
/*==============================================================*/
create table MERCHANDISE (
   MRCHID               varchar(5)           not null,
   MRCHNAME             varchar(50)              null,
   MRCHPRICE            float(5)                 null,
   constraint PK_MERCHANDISE primary key nonclustered (MRCHID)
)
go

/*==============================================================*/
/* Tabla: PASSCATEGORY                                           */
/*==============================================================*/
create table PASSCATEGORY (
   PASSCATID            varchar(5)           not null,
   CATNAME              varchar(50)              null,
   PRICE                float(5)                 null,
   constraint PK_PASSCATEGORY primary key nonclustered (PASSCATID)
)
go

/*==============================================================*/
/* Tabla: ONEDAYPASS                                            */
/*==============================================================*/
create table ONEDAYPASS (
   PASSID               varchar(10)          not null,
   PASSDATE             date                     null,
   PASSCATID            varchar(5)           not null,
   MEMBID               int                  not null,
   constraint PK_ONEDAYPASS primary key nonclustered (PASSID)
)
go

/*==============================================================*/
/* Index: IS_OF_FK                                              */
/*==============================================================*/
create index IS_OF_FK on ONEDAYPASS (
PASSCATID ASC
)
go

/*==============================================================*/
/* Index: BUYS_FK                                               */
/*==============================================================*/
create index BUYS_FK on ONEDAYPASS (
MEMBID ASC
)
go

/*==============================================================*/
/* Tabla: SALETRANSACT                                          */
/*==============================================================*/
create table SALETRANSACT (
   STRID                int                  not null,
   DATES                date                     null,
   MEMBID               int                  not null,
   constraint PK_SALETRANSACT primary key nonclustered (STRID)
)
go

/*==============================================================*/
/* Index: BUYSVIA_FK                                            */
/*==============================================================*/
create index BUYSVIA_FK on SALETRANSACT (
MEMBID ASC
)
go

/*==============================================================*/
/* Tabla: SOLDVIA                                               */
/*==============================================================*/
create table SOLDVIA (
   STRID                int                  not null,
   MRCHID               varchar(5)           not null,
   QUANTITY             int                      null,
   constraint PK_SOLDVIA primary key nonclustered (MRCHID, STRID)
)
go

/*==============================================================*/
/* Index: SOLDVIA2_FK                                           */
/*==============================================================*/
create index SOLDVIA2_FK on SOLDVIA (
STRID ASC
)
go

/*==============================================================*/
/* Index: SOLDVIA_FK                                            */
/*==============================================================*/
create index SOLDVIA_FK on SOLDVIA (
MRCHID ASC
)
go

/*==============================================================*/
/* Tabla: SPECIALEVENTS                                         */
/*==============================================================*/
create table SPECIALEVENTS (
   CUSTOMERID                varchar(5)      not null,
   CUSTOMERNAMELOCATIONS     varchar(50)         null,
   EVENTTYPECODE             varchar(5)          null,
   EVENTTYPE                 varchar(25)         null,
   EVENTDATE   				  date                null,
   AMOUNTCHARGED             float(5)            null,
   constraint PK_SPECIALEVENTS primary key nonclustered (CUSTOMERID)
)
go

/*==============================================================*/
/* FOREING KEYS                                                 */
/*==============================================================*/
alter table MEMBER
   add constraint FK_MEMBER_REFERENCE_MEMBERSH foreign key (MSHPID)
      references MEMBERSHIP (MSHPID)
go

alter table ONEDAYPASS
   add constraint FK_ONEDAYPA_BUYS_MEMBER foreign key (MEMBID)
      references MEMBER (MEMBID)
go

alter table ONEDAYPASS
   add constraint FK_ONEDAYPA_IS_OF_PASSCATE foreign key (PASSCATID)
      references PASSCATEGORY (PASSCATID)
go

alter table SALETRANSACT
   add constraint FK_SALETRAN_BUYSVIA_MEMBER foreign key (MEMBID)
      references MEMBER (MEMBID)
go

alter table SOLDVIA
   add constraint FK_SOLDVIA_SOLDVIA_MERCHAND foreign key (MRCHID)
      references MERCHANDISE (MRCHID)
go

alter table SOLDVIA
   add constraint FK_SOLDVIA_SOLDVIA2_SALETRAN foreign key (STRID)
      references SALETRANSACT (STRID)
go