/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     02/03/2017 09:06:52                          */
/*==============================================================*/


drop index SITUE_FK;

drop index POSSEDE_FK;

drop index AGENCE_PK;

drop table AGENCE;

drop index BANQUE_PK;

drop table BANQUE;

drop index CLIENT_PK;

drop table CLIENT;

drop index OUVRIR_FK;

drop index CONCERNE_FK;

drop index ETRE_FK;

drop index LOGER_FK;

drop index COMPTE_PK;

drop table COMPTE;

drop index ASSOCIATION_10_FK;

drop index OPERATION_PK;

drop table OPERATION;

drop index TYPE_COMPTE_PK;

drop table TYPE_COMPTE;

drop index TYPE_OPERATION_PK;

drop table TYPE_OPERATION;

drop index VILLE_PK;

drop table VILLE;

/*==============================================================*/
/* Table: AGENCE                                                */
/*==============================================================*/
create table AGENCE (
   ID_AGENCE            SERIAL               not null,
   ID_VILLE             INT4                 not null,
   ID_BANQUE            INT4                 not null,
   NOM                  CHAR(20)             null,
   constraint PK_AGENCE primary key (ID_AGENCE)
);

/*==============================================================*/
/* Index: AGENCE_PK                                             */
/*==============================================================*/
create unique index AGENCE_PK on AGENCE (
ID_AGENCE
);

/*==============================================================*/
/* Index: POSSEDE_FK                                            */
/*==============================================================*/
create  index POSSEDE_FK on AGENCE (
ID_BANQUE
);

/*==============================================================*/
/* Index: SITUE_FK                                              */
/*==============================================================*/
create  index SITUE_FK on AGENCE (
ID_VILLE
);

/*==============================================================*/
/* Table: BANQUE                                                */
/*==============================================================*/
create table BANQUE (
   ID_BANQUE            SERIAL               not null,
   DESIGNATION          CHAR(20)             not null,
   constraint PK_BANQUE primary key (ID_BANQUE)
);

/*==============================================================*/
/* Index: BANQUE_PK                                             */
/*==============================================================*/
create unique index BANQUE_PK on BANQUE (
ID_BANQUE
);

/*==============================================================*/
/* Table: CLIENT                                                */
/*==============================================================*/
create table CLIENT (
   ID_CLIENT            SERIAL               not null,
   NOM                  CHAR(20)             null,
   ADRESSE              CHAR(25)             null,
   PRENOM               CHAR(25)             null,
   DATE_NAISSANCE       DATE                 null,
   MAIL                 CHAR(25)             null,
   SEXE                 CHAR(25)             null,
   constraint PK_CLIENT primary key (ID_CLIENT)
);

/*==============================================================*/
/* Index: CLIENT_PK                                             */
/*==============================================================*/
create unique index CLIENT_PK on CLIENT (
ID_CLIENT
);

/*==============================================================*/
/* Table: COMPTE                                                */
/*==============================================================*/
create table COMPTE (
   ID_COMPTE            SERIAL               not null,
   ID_OPERATION         INT4                 not null,
   ID_TYPE_COMPTE       INT4                 not null,
   ID_AGENCE            INT4                 not null,
   ID_CLIENT            INT4                 not null,
   NUMERO               INT4                 null,
   DATE_CREATION        DATE                 null,
   SOLDE                INT4                 null,
   constraint PK_COMPTE primary key (ID_COMPTE)
);

/*==============================================================*/
/* Index: COMPTE_PK                                             */
/*==============================================================*/
create unique index COMPTE_PK on COMPTE (
ID_COMPTE
);

/*==============================================================*/
/* Index: LOGER_FK                                              */
/*==============================================================*/
create  index LOGER_FK on COMPTE (
ID_AGENCE
);

/*==============================================================*/
/* Index: ETRE_FK                                               */
/*==============================================================*/
create  index ETRE_FK on COMPTE (
ID_TYPE_COMPTE
);

/*==============================================================*/
/* Index: CONCERNE_FK                                           */
/*==============================================================*/
create  index CONCERNE_FK on COMPTE (
ID_OPERATION
);

/*==============================================================*/
/* Index: OUVRIR_FK                                             */
/*==============================================================*/
create  index OUVRIR_FK on COMPTE (
ID_CLIENT
);

/*==============================================================*/
/* Table: OPERATION                                             */
/*==============================================================*/
create table OPERATION (
   ID_OPERATION         SERIAL               not null,
   ID_TYPE_OPERATION    INT4                 not null,
   DATE_OPERATION       DATE                 null,
   MONTANT              INT4                 null,
   constraint PK_OPERATION primary key (ID_OPERATION)
);

/*==============================================================*/
/* Index: OPERATION_PK                                          */
/*==============================================================*/
create unique index OPERATION_PK on OPERATION (
ID_OPERATION
);

/*==============================================================*/
/* Index: ASSOCIATION_10_FK                                     */
/*==============================================================*/
create  index ASSOCIATION_10_FK on OPERATION (
ID_TYPE_OPERATION
);

/*==============================================================*/
/* Table: TYPE_COMPTE                                           */
/*==============================================================*/
create table TYPE_COMPTE (
   ID_TYPE_COMPTE       SERIAL               not null,
   DESIGNATION          CHAR(20)             null,
   constraint PK_TYPE_COMPTE primary key (ID_TYPE_COMPTE)
);

/*==============================================================*/
/* Index: TYPE_COMPTE_PK                                        */
/*==============================================================*/
create unique index TYPE_COMPTE_PK on TYPE_COMPTE (
ID_TYPE_COMPTE
);

/*==============================================================*/
/* Table: TYPE_OPERATION                                        */
/*==============================================================*/
create table TYPE_OPERATION (
   ID_TYPE_OPERATION    SERIAL               not null,
   DESIGNATION          CHAR(20)             null,
   constraint PK_TYPE_OPERATION primary key (ID_TYPE_OPERATION)
);

/*==============================================================*/
/* Index: TYPE_OPERATION_PK                                     */
/*==============================================================*/
create unique index TYPE_OPERATION_PK on TYPE_OPERATION (
ID_TYPE_OPERATION
);

/*==============================================================*/
/* Table: VILLE                                                 */
/*==============================================================*/
create table VILLE (
   ID_VILLE             SERIAL               not null,
   DESIGNATION          CHAR(20)             not null,
   constraint PK_VILLE primary key (ID_VILLE)
);

/*==============================================================*/
/* Index: VILLE_PK                                              */
/*==============================================================*/
create unique index VILLE_PK on VILLE (
ID_VILLE
);

alter table AGENCE
   add constraint FK_AGENCE_POSSEDE_BANQUE foreign key (ID_BANQUE)
      references BANQUE (ID_BANQUE)
      on delete restrict on update restrict;

alter table AGENCE
   add constraint FK_AGENCE_SITUE_VILLE foreign key (ID_VILLE)
      references VILLE (ID_VILLE)
      on delete restrict on update restrict;

alter table COMPTE
   add constraint FK_COMPTE_CONCERNE_OPERATIO foreign key (ID_OPERATION)
      references OPERATION (ID_OPERATION)
      on delete restrict on update restrict;

alter table COMPTE
   add constraint FK_COMPTE_ETRE_TYPE_COM foreign key (ID_TYPE_COMPTE)
      references TYPE_COMPTE (ID_TYPE_COMPTE)
      on delete restrict on update restrict;

alter table COMPTE
   add constraint FK_COMPTE_LOGER_AGENCE foreign key (ID_AGENCE)
      references AGENCE (ID_AGENCE)
      on delete restrict on update restrict;

alter table COMPTE
   add constraint FK_COMPTE_OUVRIR_CLIENT foreign key (ID_CLIENT)
      references CLIENT (ID_CLIENT)
      on delete restrict on update restrict;

alter table OPERATION
   add constraint FK_OPERATIO_ASSOCIATI_TYPE_OPE foreign key (ID_TYPE_OPERATION)
      references TYPE_OPERATION (ID_TYPE_OPERATION)
      on delete restrict on update restrict;

