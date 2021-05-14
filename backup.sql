--------------------------------------------------------
--  File created - �������-���-14-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table DEPARTMENTS
--------------------------------------------------------

  CREATE TABLE "C##VAL"."DEPARTMENTS" 
   (	"ID" NUMBER(*,0) GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"NAME" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DEPARTMENTS_EMPLOYEES
--------------------------------------------------------

  CREATE TABLE "C##VAL"."DEPARTMENTS_EMPLOYEES" 
   (	"ID" NUMBER(*,0) GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"DEPARTMENT_ID" NUMBER(*,0), 
	"EMPLOYEE_ID" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table EMPLOYEES
--------------------------------------------------------

  CREATE TABLE "C##VAL"."EMPLOYEES" 
   (	"ID" NUMBER(*,0) GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"FIRST_NAME" VARCHAR2(40 BYTE), 
	"LAST_NAME" VARCHAR2(40 BYTE), 
	"FATHER_NAME" VARCHAR2(40 BYTE), 
	"POSITION" VARCHAR2(50 BYTE), 
	"SALARY" NUMBER(18,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PROJECTS
--------------------------------------------------------

  CREATE TABLE "C##VAL"."PROJECTS" 
   (	"ID" NUMBER(*,0) GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"NAME" VARCHAR2(200 BYTE), 
	"COST" NUMBER(18,2), 
	"DEPARTMENT_ID" NUMBER(*,0), 
	"DATE_BEG" DATE, 
	"DATE_END" DATE, 
	"DATE_END_REAL" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table USERS
--------------------------------------------------------

  CREATE TABLE "C##VAL"."USERS" 
   (	"ID" NUMBER(*,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"LOGIN" VARCHAR2(50 BYTE), 
	"PASSWORD" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for View EMPLOYEES_IN_INTERVAL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##VAL"."EMPLOYEES_IN_INTERVAL" ("FIRST_NAME", "LAST_NAME", "FATHER_NAME") AS 
  SELECT FIRST_NAME, LAST_NAME, FATHER_NAME
FROM PROJECTS
         JOIN DEPARTMENTS_EMPLOYEES DE ON PROJECTS.DEPARTMENT_ID = DE.DEPARTMENT_ID
         JOIN EMPLOYEES E ON DE.EMPLOYEE_ID = E.ID
WHERE '01.01.2021' <= NVL(DATE_END_REAL, DATE_END) AND '01.05.2021' >= DATE_BEG
GROUP BY FIRST_NAME, LAST_NAME, FATHER_NAME
;
--------------------------------------------------------
--  DDL for View SPENDING_PER_MONTH
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "C##VAL"."SPENDING_PER_MONTH" ("NAME", "SPENDING") AS 
  SELECT NAME, SALARIES.SALARY SPENDING
    FROM PROJECTS
        LEFT JOIN (SELECT DEPARTMENT_ID, SUM(SALARY) SALARY FROM EMPLOYEES
                        JOIN DEPARTMENTS_EMPLOYEES ON EMPLOYEES.ID = DEPARTMENTS_EMPLOYEES.EMPLOYEE_ID
                        GROUP BY (DEPARTMENT_ID)) SALARIES
                       ON SALARIES.DEPARTMENT_ID=PROJECTS.DEPARTMENT_ID
    WHERE DATE_END_REAL>ADD_MONTHS(SYSDATE,-1) OR DATE_END_REAL IS NULL
;
REM INSERTING into C##VAL.DEPARTMENTS
SET DEFINE OFF;
Insert into C##VAL.DEPARTMENTS (ID,NAME) values ('25','����� 4');
Insert into C##VAL.DEPARTMENTS (ID,NAME) values ('26','����� 5');
Insert into C##VAL.DEPARTMENTS (ID,NAME) values ('29','����� 8');
Insert into C##VAL.DEPARTMENTS (ID,NAME) values ('1','����� 1');
Insert into C##VAL.DEPARTMENTS (ID,NAME) values ('2','����� 2');
Insert into C##VAL.DEPARTMENTS (ID,NAME) values ('3','����� 3');
REM INSERTING into C##VAL.DEPARTMENTS_EMPLOYEES
SET DEFINE OFF;
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('23','1','2');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('1','26','21');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('2','1','1');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('3','2','3');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('5','26','2');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('9','2','1');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('10','2','2');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('15','29','7');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('39','1','3');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('40','2','5');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('41','3','82');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('42','3','7');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('31','29','4');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('35','3','102');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('36','25','7');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('43','1','5');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('38','25','82');
Insert into C##VAL.DEPARTMENTS_EMPLOYEES (ID,DEPARTMENT_ID,EMPLOYEE_ID) values ('44','29','3');
REM INSERTING into C##VAL.EMPLOYEES
SET DEFINE OFF;
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('21','������','��������','����������','��������','35000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('82','������','����������','���������','�������','7000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('101','������','����������','����������','������','30000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('102','�����','������','��������','��������','100000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('1','�����','�������','���������','�����������','30000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('2','������','��������','����������','��������','12000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('3','������','�������','��������','��������','20000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('4','������','��������','����������','�����������','40000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('5','����','������','��������','��������','30000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('7','������','������','�������������','�����������','1000000');
Insert into C##VAL.EMPLOYEES (ID,FIRST_NAME,LAST_NAME,FATHER_NAME,POSITION,SALARY) values ('8','�������','��������','����������','������','10000');
REM INSERTING into C##VAL.PROJECTS
SET DEFINE OFF;
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('15','������ 9','300000','1',to_date('02.04.21','DD.MM.RR'),to_date('03.06.21','DD.MM.RR'),null);
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('16','������ 10','300000','26',to_date('02.04.21','DD.MM.RR'),to_date('03.05.21','DD.MM.RR'),null);
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('2','������ 1','232000','29',to_date('20.01.21','DD.MM.RR'),to_date('30.01.21','DD.MM.RR'),to_date('30.03.21','DD.MM.RR'));
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('3','������ 2','4200000','1',to_date('27.03.21','DD.MM.RR'),to_date('09.08.21','DD.MM.RR'),null);
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('4','������ 3','602300','2',to_date('02.04.21','DD.MM.RR'),to_date('24.05.21','DD.MM.RR'),null);
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('5','������ 4','320000','3',to_date('23.03.21','DD.MM.RR'),to_date('15.09.21','DD.MM.RR'),null);
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('6','������ 5','200000','25',to_date('24.03.21','DD.MM.RR'),to_date('01.11.21','DD.MM.RR'),null);
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('7','������ 6','1000000','25',to_date('26.03.21','DD.MM.RR'),to_date('01.05.21','DD.MM.RR'),null);
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('8','������ 7','1500000','26',to_date('28.03.21','DD.MM.RR'),to_date('01.04.21','DD.MM.RR'),null);
Insert into C##VAL.PROJECTS (ID,NAME,COST,DEPARTMENT_ID,DATE_BEG,DATE_END,DATE_END_REAL) values ('61','������ 11','10000000','25',to_date('15.09.21','DD.MM.RR'),to_date('15.09.22','DD.MM.RR'),null);
REM INSERTING into C##VAL.USERS
SET DEFINE OFF;
Insert into C##VAL.USERS (ID,LOGIN,PASSWORD) values ('1','val','1234');
Insert into C##VAL.USERS (ID,LOGIN,PASSWORD) values ('21','@LOGIN','@PASSWORD');
Insert into C##VAL.USERS (ID,LOGIN,PASSWORD) values ('41','t','34');
Insert into C##VAL.USERS (ID,LOGIN,PASSWORD) values ('61','val1','1234');
--------------------------------------------------------
--  DDL for Index DEPARTMENTS_EMPLOYEES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##VAL"."DEPARTMENTS_EMPLOYEES_PK" ON "C##VAL"."DEPARTMENTS_EMPLOYEES" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index DEPARTMENTS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##VAL"."DEPARTMENTS_PK" ON "C##VAL"."DEPARTMENTS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index EMPLOYEES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##VAL"."EMPLOYEES_PK" ON "C##VAL"."EMPLOYEES" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PROJECTS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "C##VAL"."PROJECTS_PK" ON "C##VAL"."PROJECTS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Trigger COMPLETION_WARRANTY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##VAL"."COMPLETION_WARRANTY" 
    BEFORE DELETE
    ON PROJECTS
    FOR EACH ROW
BEGIN
    IF (NVL(:OLD.DATE_END_REAL, :OLD.DATE_END) > SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20000, 'THE PROJECT IS NOT COMPLETED YET');
    END IF;
END;
/
ALTER TRIGGER "C##VAL"."COMPLETION_WARRANTY" ENABLE;
--------------------------------------------------------
--  DDL for Trigger CORRECT_DATES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##VAL"."CORRECT_DATES" 
    BEFORE UPDATE
    ON PROJECTS
    FOR EACH ROW
BEGIN
    IF (:NEW.DATE_BEG > :NEW.DATE_END) THEN
        RAISE_APPLICATION_ERROR(-20000, 'BEG_DATE MUST BE LESS THAN END_DATE');
    END IF;
END;
/
ALTER TRIGGER "C##VAL"."CORRECT_DATES" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DATE_END_REAL_CORRECT_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##VAL"."DATE_END_REAL_CORRECT_INSERT" 
    BEFORE INSERT
    ON PROJECTS
    FOR EACH ROW
BEGIN
    IF (NVL(:NEW.DATE_END_REAL, SYSDATE) > SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20000, 'DATE_END_REAL MUST BE LESS THAN SYSDATE');
    END IF;
END;
/
ALTER TRIGGER "C##VAL"."DATE_END_REAL_CORRECT_INSERT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DATE_END_REAL_CORRECT_UPDATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##VAL"."DATE_END_REAL_CORRECT_UPDATE" 
    BEFORE UPDATE
    ON PROJECTS
    FOR EACH ROW
BEGIN
    IF (NVL(:NEW.DATE_END_REAL, SYSDATE) > SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20000, 'DATE_END_REAL MUST BE LESS THAN SYSDATE');
    END IF;
END;
/
ALTER TRIGGER "C##VAL"."DATE_END_REAL_CORRECT_UPDATE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger UNIQUE_EMPLOYEE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "C##VAL"."UNIQUE_EMPLOYEE" 
    BEFORE INSERT
    ON EMPLOYEES
    FOR EACH ROW
DECLARE
    EMPLOYEES_CNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO EMPLOYEES_CNT
    FROM EMPLOYEES
    WHERE FIRST_NAME = :
        NEW.FIRST_NAME
      AND LAST_NAME = :NEW.LAST_NAME
      AND FATHER_NAME = :NEW.FATHER_NAME;
    IF EMPLOYEES_CNT>0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'THERE IS SUCH EMPLOYEE IN TABLE');
    END IF;
END;
/
ALTER TRIGGER "C##VAL"."UNIQUE_EMPLOYEE" ENABLE;
--------------------------------------------------------
--  DDL for Procedure DEPARTMENTS_AVG_ORK_TIME
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##VAL"."DEPARTMENTS_AVG_ORK_TIME" DEPARTMENTS_AVG_ORK_TIME
    IS
    CURSOR DEP IS
        SELECT DEPARTMENTS.ID ID, NVL(AVG(NVL(DATE_END_REAL, DATE_END) - DATE_BEG), 0) DAYS
        FROM DEPARTMENTS
                 LEFT JOIN PROJECTS
                           ON DEPARTMENTS.ID = PROJECTS.DEPARTMENT_ID
        GROUP BY DEPARTMENTS.ID;
BEGIN
    FOR DEP_RECORD IN DEP
        LOOP
            DBMS_OUTPUT.PUT_LINE('DEP_ID = ' || DEP_RECORD.ID ||
                                 '; DAYS = ' || DEP_RECORD.DAYS);
        END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Procedure EARNINGS_SINCE_DATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##VAL"."EARNINGS_SINCE_DATE" (BEG_D IN DATE, EARNING OUT NUMBER)
    IS
    CURSOR C_EARNINGS IS
        SELECT SUM(COST - SPENDING) EARNINGS_SUM
        FROM (SELECT COST,
                     SALARIES.SALARY * GREATEST((SYSDATE - GREATEST(SYSDATE - DATE_END_REAL, 0))
                                                    - (BEG_D +
                                                       GREATEST(DATE_BEG - BEG_D, 0))
                         , 0) / 30 SPENDING
              FROM PROJECTS
                       LEFT JOIN (SELECT DEPARTMENT_ID, SUM(SALARY) SALARY
                                  FROM EMPLOYEES
                                           JOIN DEPARTMENTS_EMPLOYEES
                                                ON EMPLOYEES.ID = DEPARTMENTS_EMPLOYEES.EMPLOYEE_ID
                                  GROUP BY (DEPARTMENT_ID)) SALARIES
                                 ON SALARIES.DEPARTMENT_ID = PROJECTS.DEPARTMENT_ID
              WHERE DATE_END_REAL < SYSDATE);
BEGIN
    OPEN C_EARNINGS;
    FETCH C_EARNINGS INTO EARNING;
END;

/
--------------------------------------------------------
--  DDL for Procedure GET_COMMON_PROJECTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##VAL"."GET_COMMON_PROJECTS" (EMP1_FIRST_NAME IN EMPLOYEES.FIRST_NAME%TYPE,
                                                EMP1_LAST_NAME IN EMPLOYEES.LAST_NAME%TYPE,
                                                EMP1_FATHER_NAME IN EMPLOYEES.FATHER_NAME%TYPE,
                                                EMP2_FIRST_NAME IN EMPLOYEES.FIRST_NAME%TYPE,
                                                EMP2_LAST_NAME IN EMPLOYEES.LAST_NAME%TYPE,
                                                EMP2_FATHER_NAME IN EMPLOYEES.FATHER_NAME%TYPE)
    IS
    CURSOR PROJ IS
        (SELECT P.ID, P.NAME
         FROM PROJECTS P
                  JOIN DEPARTMENTS_EMPLOYEES DE ON P.DEPARTMENT_ID = DE.DEPARTMENT_ID
                  JOIN EMPLOYEES E ON DE.EMPLOYEE_ID = E.ID
         WHERE E.FIRST_NAME = EMP1_FIRST_NAME
           AND E.LAST_NAME = EMP1_LAST_NAME
           AND E.FATHER_NAME = EMP1_FATHER_NAME)
        INTERSECT
        (SELECT P.ID, P.NAME
         FROM PROJECTS P
                  JOIN DEPARTMENTS_EMPLOYEES DE ON P.DEPARTMENT_ID = DE.DEPARTMENT_ID
                  JOIN EMPLOYEES E ON DE.EMPLOYEE_ID = E.ID
         WHERE E.FIRST_NAME = EMP2_FIRST_NAME
           AND E.LAST_NAME = EMP2_LAST_NAME
           AND E.FATHER_NAME = EMP2_FATHER_NAME);
BEGIN
    FOR PROJ_RECORD IN PROJ
        LOOP
            DBMS_OUTPUT.PUT_LINE('PROJECT_ID = ' || PROJ_RECORD.ID ||
                                 '; PROJECT_NAME = ' || PROJ_RECORD.NAME);
        END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Procedure GET_RECORD_PROJECT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "C##VAL"."GET_RECORD_PROJECT" (DEP_ID IN DEPARTMENTS.ID%TYPE,
                                               DAYS OUT NUMBER,
                                               PROJ OUT PROJECTS%ROWTYPE)
    IS
   PROJ_ID PROJECTS.ID%TYPE;
BEGIN
    SELECT ID
    INTO PROJ_ID
    FROM (SELECT *
          FROM PROJECTS
          WHERE ID = DEP_ID
          ORDER BY TRUNC(NVL(DATE_END_REAL, DATE_END) - DATE_BEG))
    WHERE ROWNUM = 1;
    SELECT * INTO PROJ FROM PROJECTS WHERE ID = PROJ_ID;
    SELECT TRUNC(NVL(DATE_END_REAL, DATE_END) - DATE_BEG) INTO DAYS FROM PROJECTS WHERE ID = PROJ_ID;
END;

/
--------------------------------------------------------
--  Constraints for Table EMPLOYEES
--------------------------------------------------------

  ALTER TABLE "C##VAL"."EMPLOYEES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."EMPLOYEES" MODIFY ("FIRST_NAME" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."EMPLOYEES" MODIFY ("POSITION" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."EMPLOYEES" MODIFY ("SALARY" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."EMPLOYEES" ADD CONSTRAINT "EMPLOYEES_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table DEPARTMENTS
--------------------------------------------------------

  ALTER TABLE "C##VAL"."DEPARTMENTS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."DEPARTMENTS" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."DEPARTMENTS" ADD CONSTRAINT "DEPARTMENTS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table USERS
--------------------------------------------------------

  ALTER TABLE "C##VAL"."USERS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."USERS" MODIFY ("LOGIN" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."USERS" MODIFY ("PASSWORD" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PROJECTS
--------------------------------------------------------

  ALTER TABLE "C##VAL"."PROJECTS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."PROJECTS" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."PROJECTS" MODIFY ("COST" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."PROJECTS" MODIFY ("DEPARTMENT_ID" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."PROJECTS" MODIFY ("DATE_BEG" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."PROJECTS" MODIFY ("DATE_END" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."PROJECTS" ADD CONSTRAINT "PROJECTS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table DEPARTMENTS_EMPLOYEES
--------------------------------------------------------

  ALTER TABLE "C##VAL"."DEPARTMENTS_EMPLOYEES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."DEPARTMENTS_EMPLOYEES" MODIFY ("DEPARTMENT_ID" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."DEPARTMENTS_EMPLOYEES" MODIFY ("EMPLOYEE_ID" NOT NULL ENABLE);
  ALTER TABLE "C##VAL"."DEPARTMENTS_EMPLOYEES" ADD CONSTRAINT "DEPARTMENTS_EMPLOYEES_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DEPARTMENTS_EMPLOYEES
--------------------------------------------------------

  ALTER TABLE "C##VAL"."DEPARTMENTS_EMPLOYEES" ADD CONSTRAINT "FK_DEPARTMENTS_EMPLOYEES_DEPARTMENTS" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "C##VAL"."DEPARTMENTS" ("ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "C##VAL"."DEPARTMENTS_EMPLOYEES" ADD CONSTRAINT "FK_DEPARTMENTS_EMPLOYEES_EMPLOYEES" FOREIGN KEY ("EMPLOYEE_ID")
	  REFERENCES "C##VAL"."EMPLOYEES" ("ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PROJECTS
--------------------------------------------------------

  ALTER TABLE "C##VAL"."PROJECTS" ADD CONSTRAINT "FK_PROJECTS_DEPARTMENTS" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "C##VAL"."DEPARTMENTS" ("ID") ENABLE;
