-- Generated by Oracle SQL Developer Data Modeler 17.3.0.261.1541
--   at:        2018-01-10 13:40:39 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



CREATE TABLE bilety (
    id_imprezy      NUMBER NOT NULL,
    id_stadionu     NUMBER NOT NULL,
    id_sektora      NUMBER NOT NULL,
    rzad            NUMBER NOT NULL,
    nr_miejsca      NUMBER NOT NULL,
    id_rezerwacji   NUMBER,
    id_zakupu       NUMBER
);

ALTER TABLE bilety
    ADD CONSTRAINT bilety_pk PRIMARY KEY ( id_imprezy,
    id_stadionu,
    id_sektora,
    rzad,
    nr_miejsca );

CREATE TABLE cena (
    cena              NUMBER(20,2) NOT NULL,
    id_typu_sektora   NUMBER NOT NULL,
    id_imprezy        NUMBER NOT NULL,
    id_typu_imprezy   NUMBER NOT NULL
);

ALTER TABLE cena ADD CONSTRAINT ceny_pk PRIMARY KEY ( id_imprezy,
id_typu_sektora );

CREATE TABLE imprezy (
    id_imprezy    NUMBER NOT NULL,
    nazwa         VARCHAR2(30 CHAR) NOT NULL,
    data          DATE NOT NULL,
    id_stadionu   NUMBER NOT NULL,
    id_typu       NUMBER NOT NULL,
    opis          VARCHAR2(150)
);

ALTER TABLE imprezy ADD CONSTRAINT imprezy_pk PRIMARY KEY ( id_imprezy );

CREATE TABLE karnety (
    id_karnetu              NUMBER(20,2) NOT NULL,
    data_wystawienia        DATE NOT NULL,
    data_waznosci           DATE NOT NULL,
    cena                    NUMBER(2) NOT NULL,
    klienci_id_klienta      NUMBER NOT NULL,
    id_typu_klienta         NUMBER NOT NULL,
    typy_karnetow_id_typu   NUMBER NOT NULL,
    id_promocji             NUMBER
);

ALTER TABLE karnety ADD CONSTRAINT karnet_pk PRIMARY KEY ( id_karnetu );

CREATE TABLE klienci (
    id_klienta              NUMBER NOT NULL,
    nazwisko                VARCHAR2(30 CHAR) NOT NULL,
    imie                    VARCHAR2(30 CHAR) NOT NULL,
    pesel                   VARCHAR2(11 CHAR),
    zdjecie                 BLOB NOT NULL,
    telefon_kontaktowy      VARCHAR2(16 CHAR),
    typy_klientow_id_typu   NUMBER NOT NULL
);

ALTER TABLE klienci ADD CONSTRAINT klienci_pk PRIMARY KEY ( id_klienta );

CREATE TABLE miejsca (
    rzad          NUMBER NOT NULL,
    nr_miejsca    NUMBER NOT NULL,
    id_sektora    NUMBER NOT NULL,
    id_stadionu   NUMBER NOT NULL
);

ALTER TABLE miejsca
    ADD CONSTRAINT miejsca_pk PRIMARY KEY ( id_stadionu,
    id_sektora,
    rzad,
    nr_miejsca );

CREATE TABLE promocje (
    id_promocji             NUMBER NOT NULL,
    nazwa                   VARCHAR2(30 CHAR) NOT NULL,
    rabat                   NUMBER NOT NULL,
    opis                    VARCHAR2(150 CHAR),
    typy_klientow_id_typu   NUMBER
);

ALTER TABLE promocje ADD CONSTRAINT promocja_pk PRIMARY KEY ( id_promocji );

CREATE TABLE rezerwacje (
    id_rezerwacji   NUMBER NOT NULL,
    data            DATE NOT NULL,
    okres           DATE NOT NULL,
    id_klienta      NUMBER NOT NULL
);

ALTER TABLE rezerwacje ADD CONSTRAINT rezerwacje_pk PRIMARY KEY ( id_rezerwacji );

CREATE TABLE sektory (
    id_sektora    NUMBER NOT NULL,
    id_typu       NUMBER NOT NULL,
    id_stadionu   NUMBER NOT NULL
);

ALTER TABLE sektory ADD CONSTRAINT sektory_pk PRIMARY KEY ( id_stadionu,
id_sektora );

CREATE TABLE stadiony (
    id_stadionu     NUMBER NOT NULL,
    nazwa_obiektu   VARCHAR2(150 CHAR) NOT NULL
);

ALTER TABLE stadiony ADD CONSTRAINT stadiony_pk PRIMARY KEY ( id_stadionu );

CREATE TABLE typy_imprez (
    id_typu   NUMBER NOT NULL,
    nazwa     VARCHAR2(150 CHAR) NOT NULL,
    opis      VARCHAR2(150 CHAR)
);

ALTER TABLE typy_imprez ADD CONSTRAINT typy_imprez_pk PRIMARY KEY ( id_typu );

CREATE TABLE typy_karnetow (
    id_typu_karnetu         NUMBER NOT NULL,
    nazwa                   VARCHAR2(30 CHAR) NOT NULL,
    cena                    NUMBER(20,2) NOT NULL,
    okres_waznosci          DATE NOT NULL,
    opis                    VARCHAR2(150 CHAR),
    typy_sektorow_id_typu   NUMBER NOT NULL,
    typy_imprez_id_typu     NUMBER NOT NULL
);

ALTER TABLE typy_karnetow ADD CONSTRAINT typy_karnetow_pk PRIMARY KEY ( id_typu_karnetu );

CREATE TABLE typy_klientow (
    id_typu   NUMBER NOT NULL,
    nazwa     VARCHAR2(30 CHAR) NOT NULL,
    rabat     NUMBER NOT NULL,
    opis      VARCHAR2(150 CHAR)
);

ALTER TABLE typy_klientow ADD CONSTRAINT typy_klientow_pk PRIMARY KEY ( id_typu );

CREATE TABLE typy_sektorow (
    id_typu   NUMBER NOT NULL,
    nazwa     VARCHAR2(30 CHAR) NOT NULL,
    opis      VARCHAR2(150 CHAR)
);

ALTER TABLE typy_sektorow ADD CONSTRAINT typy_sektorow_pk PRIMARY KEY ( id_typu );

CREATE TABLE zakupy (
    id_zakupu              NUMBER NOT NULL,
    data                   DATE NOT NULL,
    id_klienta             NUMBER NOT NULL,
    promocja_id_promocji   NUMBER
);

ALTER TABLE zakupy ADD CONSTRAINT zakupy_pk PRIMARY KEY ( id_zakupu );

ALTER TABLE bilety
    ADD CONSTRAINT bilety_imprezy_fk FOREIGN KEY ( id_imprezy )
        REFERENCES imprezy ( id_imprezy )
            ON DELETE CASCADE;

ALTER TABLE bilety
    ADD CONSTRAINT bilety_miejsca_fk FOREIGN KEY ( id_stadionu,
    id_sektora,
    rzad,
    nr_miejsca )
        REFERENCES miejsca ( id_stadionu,
        id_sektora,
        rzad,
        nr_miejsca )
            ON DELETE CASCADE;

ALTER TABLE bilety
    ADD CONSTRAINT bilety_rezerwacje_fk FOREIGN KEY ( id_rezerwacji )
        REFERENCES rezerwacje ( id_rezerwacji );

ALTER TABLE bilety
    ADD CONSTRAINT bilety_zakupy_fk FOREIGN KEY ( id_zakupu )
        REFERENCES zakupy ( id_zakupu );

ALTER TABLE cena
    ADD CONSTRAINT ceny_imprezy_fk FOREIGN KEY ( id_imprezy )
        REFERENCES imprezy ( id_imprezy )
            ON DELETE CASCADE;

ALTER TABLE cena
    ADD CONSTRAINT ceny_typy_sektorow_fk FOREIGN KEY ( id_typu_sektora )
        REFERENCES typy_sektorow ( id_typu );

ALTER TABLE imprezy
    ADD CONSTRAINT imprezy_stadiony_fk FOREIGN KEY ( id_stadionu )
        REFERENCES stadiony ( id_stadionu )
            ON DELETE CASCADE;

ALTER TABLE imprezy
    ADD CONSTRAINT imprezy_typy_imprez_fk FOREIGN KEY ( id_typu )
        REFERENCES typy_imprez ( id_typu )
            ON DELETE CASCADE;

ALTER TABLE karnety
    ADD CONSTRAINT karnet_klienci_fk FOREIGN KEY ( klienci_id_klienta )
        REFERENCES klienci ( id_klienta );

ALTER TABLE karnety
    ADD CONSTRAINT karnet_promocja_fk FOREIGN KEY ( id_promocji )
        REFERENCES promocje ( id_promocji );

ALTER TABLE karnety
    ADD CONSTRAINT karnet_typy_karnetow_fk FOREIGN KEY ( typy_karnetow_id_typu )
        REFERENCES typy_karnetow ( id_typu_karnetu )
            ON DELETE CASCADE;

ALTER TABLE klienci
    ADD CONSTRAINT klienci_typy_klientow_fk FOREIGN KEY ( typy_klientow_id_typu )
        REFERENCES typy_klientow ( id_typu );

ALTER TABLE miejsca
    ADD CONSTRAINT miejsca_sektory_fk FOREIGN KEY ( id_stadionu,
    id_sektora )
        REFERENCES sektory ( id_stadionu,
        id_sektora )
            ON DELETE CASCADE;

ALTER TABLE promocje
    ADD CONSTRAINT promocja_typy_klientow_fk FOREIGN KEY ( typy_klientow_id_typu )
        REFERENCES typy_klientow ( id_typu );

ALTER TABLE rezerwacje
    ADD CONSTRAINT rezerwacje_klienci_fk FOREIGN KEY ( id_klienta )
        REFERENCES klienci ( id_klienta );

ALTER TABLE sektory
    ADD CONSTRAINT sektory_stadiony_fk FOREIGN KEY ( id_stadionu )
        REFERENCES stadiony ( id_stadionu )
            ON DELETE CASCADE;

ALTER TABLE sektory
    ADD CONSTRAINT sektory_typy_sektorow_fk FOREIGN KEY ( id_typu )
        REFERENCES typy_sektorow ( id_typu );

ALTER TABLE typy_karnetow
    ADD CONSTRAINT typy_karnetow_typy_imprez_fk FOREIGN KEY ( typy_imprez_id_typu )
        REFERENCES typy_imprez ( id_typu );

ALTER TABLE typy_karnetow
    ADD CONSTRAINT typy_karnetow_typy_sektorow_fk FOREIGN KEY ( typy_sektorow_id_typu )
        REFERENCES typy_sektorow ( id_typu );

ALTER TABLE zakupy
    ADD CONSTRAINT zakupy_klienci_fk FOREIGN KEY ( id_klienta )
        REFERENCES klienci ( id_klienta );

ALTER TABLE zakupy
    ADD CONSTRAINT zakupy_promocja_fk FOREIGN KEY ( promocja_id_promocji )
        REFERENCES promocje ( id_promocji );

CREATE OR REPLACE TRIGGER fknto_bilety BEFORE
    UPDATE OF id_zakupu ON bilety
    FOR EACH ROW
BEGIN
    IF
        :old.id_zakupu IS NOT NULL
    THEN
        raise_application_error(-20225,'Non Transferable FK constraint BILETY_ZAKUPY_FK on table BILETY is violated');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER fkntm_bilety BEFORE
    UPDATE OF id_imprezy ON bilety
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint  on table BILETY is violated');
END;
/

CREATE OR REPLACE TRIGGER fkntm_cena BEFORE
    UPDATE OF id_typu_sektora,id_imprezy ON cena
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint  on table CENA is violated');
END;
/

CREATE OR REPLACE TRIGGER fkntm_imprezy BEFORE
    UPDATE OF id_typu ON imprezy
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint  on table IMPREZY is violated');
END;
/

CREATE OR REPLACE TRIGGER fknto_karnety BEFORE
    UPDATE OF id_promocji ON karnety
    FOR EACH ROW
BEGIN
    IF
        :old.id_promocji IS NOT NULL
    THEN
        raise_application_error(-20225,'Non Transferable FK constraint KARNET_PROMOCJA_FK on table KARNETY is violated');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER fkntm_karnety BEFORE
    UPDATE OF typy_karnetow_id_typu ON karnety
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint  on table KARNETY is violated');
END;
/

CREATE OR REPLACE TRIGGER fkntm_miejsca BEFORE
    UPDATE OF id_stadionu,id_sektora ON miejsca
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint  on table MIEJSCA is violated');
END;
/

CREATE OR REPLACE TRIGGER fkntm_rezerwacje BEFORE
    UPDATE OF id_klienta ON rezerwacje
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint  on table REZERWACJE is violated');
END;
/

CREATE OR REPLACE TRIGGER fkntm_sektory BEFORE
    UPDATE OF id_stadionu,id_typu ON sektory
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint  on table SEKTORY is violated');
END;
/

CREATE OR REPLACE TRIGGER fkntm_typy_karnetow BEFORE
    UPDATE OF typy_imprez_id_typu,typy_sektorow_id_typu ON typy_karnetow
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint  on table TYPY_KARNETOW is violated');
END;
/

CREATE OR REPLACE TRIGGER fkntm_zakupy BEFORE
    UPDATE OF id_klienta ON zakupy
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint  on table ZAKUPY is violated');
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             36
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                          11
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
