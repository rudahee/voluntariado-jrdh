drop table APTITUD cascade constraints;
drop table ORGANIZACION cascade constraints;
drop table PROYECTO cascade constraints;
drop table TAREA cascade constraints;
drop table RECURSO cascade constraints;
drop table TAREAAPTITUD cascade constraints;
drop table VOLUNTARIO cascade constraints;
drop table VOLUNTARIOAPTITUD cascade constraints;
drop table VOLUNTARIOTAREA cascade constraints;


CREATE TABLE APTITUD (
    ID          NUMBER(10) NOT NULL,
    ADQUIRIBLE  NUMBER(1)  NOT NULL,
    DESCRIPCION VARCHAR2(255 CHAR),
    NOMBRE      VARCHAR2(255 CHAR),
    PRIMARY KEY (ID)
);

CREATE TABLE ORGANIZACION (
    ID     NUMBER(10) NOT NULL,
    NOMBRE VARCHAR2(255 CHAR),
    PRIMARY KEY (ID)
);

CREATE TABLE PROYECTO (
    ID                NUMBER(10) NOT NULL,
    DESCRIPCION       VARCHAR2(255 CHAR),
    FECHAFINALIZACION TIMESTAMP(6),
    FECHAINICIO       TIMESTAMP(6),
    LOCALIZACION      VARCHAR2(255 CHAR),
    NOMBRE            VARCHAR2(255 CHAR),
    ORGANIZACION_ID   NUMBER(10),
    PRIMARY KEY (ID),
    CONSTRAINT FK_ORGANIZACION_PRO
        FOREIGN KEY (ORGANIZACION_ID) REFERENCES ORGANIZACION
);

CREATE TABLE TAREA (
    ID                NUMBER(10) NOT NULL,
    DESCRIPCION       VARCHAR2(255 CHAR),
    ESTADO            NUMBER(10),
    FECHAFINALIZACION TIMESTAMP(6),
    FECHAINICIO       TIMESTAMP(6),
    LOCALIZACION      VARCHAR2(255 CHAR),
    MAXIMOVOLUNTARIO  NUMBER(10) NOT NULL,
    MINIMOVOLUNTARIO  NUMBER(10) NOT NULL,
    NOMBRE            VARCHAR2(255 CHAR),
    TRABAJOINDIVIDUAL NUMBER(1)  NOT NULL,
    PROYECTO_ID       NUMBER(10),
    PRIMARY KEY (ID),
    CONSTRAINT FK_PROYECTO_TAR
        FOREIGN KEY (PROYECTO_ID) REFERENCES PROYECTO
);

CREATE TABLE RECURSO (
    ID       NUMBER(10) NOT NULL,
    CANTIDAD NUMBER(10) NOT NULL,
    NOMBRE   VARCHAR2(255 CHAR),
    TAREA_ID NUMBER(10),
    PRIMARY KEY (ID),
    CONSTRAINT FK_TAREA_REC
        FOREIGN KEY (TAREA_ID) REFERENCES TAREA
);

CREATE TABLE TAREAAPTITUD (
    APTITUD_ID NUMBER(10) NOT NULL,
    TAREA_ID   NUMBER(10) NOT NULL,
    PRIMARY KEY (APTITUD_ID, TAREA_ID),
    CONSTRAINT FK_TAREAAPTITUD_APT
        FOREIGN KEY (APTITUD_ID) REFERENCES APTITUD,
    CONSTRAINT FK_TAREAAPTITUD_TAR
        FOREIGN KEY (TAREA_ID) REFERENCES TAREA
);

CREATE TABLE VOLUNTARIO (
    ID          NUMBER(10) NOT NULL ,
    APELLIDO    VARCHAR2(255 CHAR),
    NOMBRE      VARCHAR2(255 CHAR),
    PROYECTO_ID NUMBER(10),
    PRIMARY KEY (ID),
    CONSTRAINT FK_PROYECTO_VOL
        FOREIGN KEY (PROYECTO_ID) REFERENCES PROYECTO
);

CREATE TABLE VOLUNTARIOAPTITUD (
    APTITUD_ID    NUMBER(10) NOT NULL,
    VOLUNTARIO_ID NUMBER(10) NOT NULL,
    PRIMARY KEY (APTITUD_ID, VOLUNTARIO_ID),
    CONSTRAINT FK_VOLUNTARIOAPTITUD_VOL
        FOREIGN KEY (VOLUNTARIO_ID) REFERENCES VOLUNTARIO,
    CONSTRAINT FK_VOLUNTARIOAPTITUD_APT
        FOREIGN KEY (APTITUD_ID) REFERENCES APTITUD
);

CREATE TABLE VOLUNTARIOTAREA (
    FEEDBACKDETAREA      VARCHAR2(255 CHAR),
    FEEDBACKDEVOLUNTARIO VARCHAR2(255 CHAR),
    TAREA_ID             NUMBER(10) NOT NULL,
    VOLUNTARIO_ID        NUMBER(10) NOT NULL,
    PRIMARY KEY (TAREA_ID, VOLUNTARIO_ID),
    CONSTRAINT FK_VOLUNTARIOTAREA_VOL
        FOREIGN KEY (VOLUNTARIO_ID) REFERENCES VOLUNTARIO,
    CONSTRAINT FK_VOLUNTARIOTAREA_TAR
        FOREIGN KEY (TAREA_ID) REFERENCES TAREA
);

INSERT INTO APTITUD
    VALUES (01, 1, 'descripcion aptitud 01', 'aptitud 01');
INSERT INTO APTITUD
    VALUES (02, 0, 'descripcion aptitud 02', 'aptitud 02');
INSERT INTO APTITUD
    VALUES (03, 0, 'descripcion aptitud 03', 'aptitud 03');
INSERT INTO APTITUD
    VALUES (04, 1, 'descripcion aptitud 04', 'aptitud 04');

INSERT INTO ORGANIZACION
    VALUES (01, 'Organizacion 01');
INSERT INTO ORGANIZACION
    VALUES (02, 'Organizacion 02');

INSERT INTO PROYECTO
    VALUES (01, 'Descripcion Proyecto 01', TO_DATE('01/01/2021'), TO_DATE('01/01/2020'), 'Localizacion 01', 'Proyecto 01', 01);
INSERT INTO PROYECTO
    VALUES (02, 'Descripcion Proyecto 02', TO_DATE('01/01/2020'), TO_DATE('01/01/2018'), 'Localizacion 01', 'Proyecto 02', 02);
INSERT INTO PROYECTO
    VALUES (03, 'Descripcion Proyecto 03', TO_DATE('01/01/2022'), TO_DATE('01/01/2021'), 'Localizacion 02', 'Proyecto 03', 01);
INSERT INTO PROYECTO
    VALUES (04, 'Descripcion Proyecto 04', TO_DATE('01/01/2021'), TO_DATE('01/01/2020'), 'Localizacion 02', 'Proyecto 04', 02);


INSERT INTO TAREA
    VALUES (01, 'Descripcion Tarea 01', 0,  TO_DATE('12/12/2020'), TO_DATE('01/02/2020'), 'Localizacion 01', 20, 3, 'Tarea 01', 0, 01);
INSERT INTO TAREA
    VALUES (02, 'Descripcion Tarea 02', 0,  TO_DATE('01/01/2019'), TO_DATE('01/02/2018'), 'Localizacion 01', 5, 1, 'Tarea 02', 1, 02);
INSERT INTO TAREA
    VALUES (03, 'Descripcion Tarea 03', 1,  TO_DATE('01/10/2020'), TO_DATE('30/05/2020'), 'Localizacion 02', 7, 2, 'Tarea 03', 0, 01);
INSERT INTO TAREA
    VALUES (04, 'Descripcion Tarea 04', 2,  TO_DATE('12/12/2020'), TO_DATE('01/02/2020'), 'Localizacion 02', 8, 7, 'Tarea 04', 1, 04);
INSERT INTO TAREA
    VALUES (05, 'Descripcion Tarea 05', 3,  TO_DATE('12/12/2020'), TO_DATE('01/02/2020'), 'Localizacion 01', 15, 10, 'Tarea 05', 0, 04);
INSERT INTO TAREA
    VALUES (06, 'Descripcion Tarea 06', 3,  TO_DATE('01/01/2019'), TO_DATE('01/02/2018'), 'Localizacion 02', 40, 1, 'Tarea 06', 1, 02);

INSERT INTO RECURSO
    VALUES (01, 3, 'Recurso 01', 01);
INSERT INTO RECURSO
    VALUES (02, 5, 'Recurso 02', 02);
INSERT INTO RECURSO
    VALUES (03, 1, 'Recurso 02', 03);
INSERT INTO RECURSO
    VALUES (04, 1, 'Recurso 04', 01);

INSERT INTO VOLUNTARIO
    VALUES (01, 'Apellido Voluntario01', 'Voluntario 01', 01);
INSERT INTO VOLUNTARIO
    VALUES (02, 'Apellido Voluntario02', 'Voluntario 02', 01);
INSERT INTO VOLUNTARIO
    VALUES (03, 'Apellido Voluntario03', 'Voluntario 03', 01);
INSERT INTO VOLUNTARIO
    VALUES (04, 'Apellido Voluntario04', 'Voluntario 04', 01);
INSERT INTO VOLUNTARIO
    VALUES (05, 'Apellido Voluntario05', 'Voluntario 05', 02);
INSERT INTO VOLUNTARIO
    VALUES (06, 'Apellido Voluntario06', 'Voluntario 06', 02);
INSERT INTO VOLUNTARIO
    VALUES (07, 'Apellido Voluntario07', 'Voluntario 07', 02);
INSERT INTO VOLUNTARIO
    VALUES (08, 'Apellido Voluntario08', 'Voluntario 08', 03);
INSERT INTO VOLUNTARIO
    VALUES (09, 'Apellido Voluntario08', 'Voluntario 09', 04);
INSERT INTO VOLUNTARIO
    VALUES (10, 'Apellido Voluntario08', 'Voluntario 10', 04);
INSERT INTO VOLUNTARIO(ID, APELLIDO, NOMBRE)
    VALUES (11, 'Apellido Voluntario11', 'Voluntario 11');

INSERT INTO TAREAAPTITUD
    VALUES (01, 01);
INSERT INTO TAREAAPTITUD
    VALUES (01, 02);
INSERT INTO TAREAAPTITUD
    VALUES (02, 01);
INSERT INTO TAREAAPTITUD
    VALUES (03, 03);

INSERT INTO VOLUNTARIOAPTITUD
    VALUES (01, 01);
INSERT INTO VOLUNTARIOAPTITUD
    VALUES (02, 01);
INSERT INTO VOLUNTARIOAPTITUD
    VALUES (01, 03);
INSERT INTO VOLUNTARIOAPTITUD
    VALUES (03, 03);
INSERT INTO VOLUNTARIOAPTITUD
    VALUES (03, 04);


INSERT INTO VOLUNTARIOTAREA
    VALUES ('Feedback01 Tara', 'Feedback01 Voluntario', 01, 01);
INSERT INTO VOLUNTARIOTAREA
    VALUES ('Feedback01 Tara', 'Feedback01 Voluntario', 02, 01);
INSERT INTO VOLUNTARIOTAREA
    VALUES ('Feedback01 Tara', 'Feedback01 Voluntario', 05, 10);