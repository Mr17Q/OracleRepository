--查询权限
select * from user_sys_privs t where t.privilege like upper('%link%');

--赋权
grant CREATE PUBLIC DATABASE LINK，DROP PUBLIC DATABASE LINK to dlgc;

--创建dblink
create public database link hydatabase  
　　connect to hyoa identified by hyoa  
　　using '(DESCRIPTION =(ADDRESS_LIST =(ADDRESS =(PROTOCOL = TCP)(HOST = 10.232.234.242)(PORT = 1521)))(CONNECT_DATA =(SERVICE_NAME = orcl)))';  

--查询测试
select * from HYOA_DOC_RECEIPT@hydatabase ;

--创建触发器
--机构
CREATE OR REPLACE TRIGGER HYOA_ORG_TRIGGER  
AFTER INSERT OR UPDATE OR DELETE ON SECURITY_ORGANIZATION FOR EACH ROW  
BEGIN  
  CASE  
    WHEN inserting THEN  
        Insert into SECURITY_ORGANIZATION@hydatabase
        (ID, NAME, CODE, TYPE, PARENT_ID, 
        DESCRIPTION, LAYER_ORDER, ORDER_NO, IS_SELF, IS_SYSTEM, 
        ORG_LEVEL, IS_REMOTE_ORG, REMOTE_ADDR, NATURE, ENABLED, 
        RECORDER, RECORD_DATE, MODIFIER, MODIFY_DATE, FUNCTION_TYPER, 
        DATA_SOURCE)Values(:NEW.ID, :NEW.NAME, :NEW.CODE, :NEW.TYPE, :NEW.PARENT_ID, 
        :NEW.DESCRIPTION, :NEW.LAYER_ORDER, :NEW.ORDER_NO, :NEW.IS_SELF, :NEW.IS_SYSTEM, 
        :NEW.ORG_LEVEL, :NEW.IS_REMOTE_ORG, :NEW.REMOTE_ADDR, :NEW.NATURE, :NEW.ENABLED, 
        :NEW.RECORDER, :NEW.RECORD_DATE, :NEW.MODIFIER, :NEW.MODIFY_DATE, :NEW.FUNCTION_TYPER, 
        :NEW.DATA_SOURCE);
    WHEN updating THEN  
      UPDATE SECURITY_ORGANIZATION@hydatabase SET NAME=:NEW.NAME,TYPE=:NEW.TYPE,CODE=:NEW.CODE,PARENT_ID=:NEW.PARENT_ID,DESCRIPTION=:NEW.DESCRIPTION,LAYER_ORDER=:NEW.LAYER_ORDER,ORDER_NO=:NEW.ORDER_NO,IS_SELF=:NEW.IS_SELF,IS_SYSTEM=:NEW.IS_SYSTEM,ORG_LEVEL=:NEW.ORG_LEVEL,ENABLED=:NEW.ENABLED WHERE ID=:old.ID;  
    WHEN deleting THEN  
      DELETE SECURITY_ORGANIZATION@hydatabase WHERE ID=:old.ID;  
  END CASE;  
END; 
--用户
CREATE OR REPLACE TRIGGER HYOA_ACCOUNT_TRIGGER  
AFTER INSERT OR UPDATE OR DELETE ON SECURITY_ACCOUNT FOR EACH ROW  
BEGIN  
  CASE  
    WHEN inserting THEN  
        Insert into SECURITY_ACCOUNT@hydatabase
        (ID, NAME, LOGIN_NAME, PASSWORD, LAST_LOGIN_TIME, 
        EMPLOYEE_ID, STATUS, IS_SYSTEM, TYPE, ENABLED, 
        ORDER_NO, EMAIL, MOBILE, NICK_NAME, RECORDER, 
        RECORD_DATE, MODIFIER, MODIFY_DATE, DATA_SOURCE, PARENT, 
        DESCRIPTION, IS_MASTER, LOCK_DATE, ACCOUNT_LEVEL, IS_CHECK, 
        ATTRIBUTE, ENCRYPTPWD)
        Values
        (:NEW.ID, :NEW.NAME, :NEW.LOGIN_NAME, :NEW.PASSWORD, :NEW.LAST_LOGIN_TIME, 
        :NEW.EMPLOYEE_ID, :NEW.STATUS, :NEW.IS_SYSTEM, :NEW.TYPE, :NEW.ENABLED, 
        :NEW.ORDER_NO, :NEW.EMAIL, :NEW.MOBILE, :NEW.NICK_NAME, :NEW.RECORDER, 
        :NEW.RECORD_DATE, :NEW.MODIFIER, :NEW.MODIFY_DATE, :NEW.DATA_SOURCE, :NEW.PARENT, 
        :NEW.DESCRIPTION, :NEW.IS_MASTER, :NEW.LOCK_DATE, :NEW.ACCOUNT_LEVEL, :NEW.IS_CHECK, 
        :NEW.ATTRIBUTE, :NEW.ENCRYPTPWD);
    WHEN updating THEN  
      UPDATE SECURITY_ACCOUNT@hydatabase SET 
        NAME=:NEW.NAME, LOGIN_NAME=:NEW.LOGIN_NAME, PASSWORD=:NEW.PASSWORD, LAST_LOGIN_TIME=:NEW.LAST_LOGIN_TIME, 
        EMPLOYEE_ID=:NEW.EMPLOYEE_ID, STATUS=:NEW.STATUS, IS_SYSTEM=:NEW.IS_SYSTEM, TYPE=:NEW.TYPE, ENABLED=:NEW.ENABLED, 
        ORDER_NO=:NEW.ORDER_NO, EMAIL=:NEW.EMAIL, MOBILE=:NEW.MOBILE, NICK_NAME=:NEW.NICK_NAME, RECORDER=:NEW.RECORDER, 
        RECORD_DATE=:NEW.RECORD_DATE, MODIFIER=:NEW.MODIFIER, MODIFY_DATE=:NEW.MODIFY_DATE, DATA_SOURCE=:NEW.DATA_SOURCE, PARENT=:NEW.PARENT, 
        DESCRIPTION=:NEW.DESCRIPTION, IS_MASTER=:NEW.IS_MASTER, LOCK_DATE=:NEW.LOCK_DATE, ACCOUNT_LEVEL=:NEW.ACCOUNT_LEVEL, IS_CHECK=:NEW.IS_CHECK, 
        ATTRIBUTE=:NEW.ATTRIBUTE, ENCRYPTPWD=:NEW.ENCRYPTPWD
       WHERE ID=:old.ID;  
    WHEN deleting THEN  
      DELETE SECURITY_ACCOUNT@hydatabase WHERE ID=:old.ID;  
  END CASE;  
END; 
--员工
CREATE OR REPLACE TRIGGER HYOA_EMPLOYEE_TRIGGER  
AFTER INSERT OR UPDATE OR DELETE ON SECURITY_EMPLOYEE FOR EACH ROW  
BEGIN  
  CASE  
    WHEN inserting THEN  
        Insert into SECURITY_EMPLOYEE@hydatabase
        (ID, NAME, CODE, COMP_ID, DEPT_ID, 
        STATION_NAMES, ACCOUNT_ID, PINYIN, DESCRIPTION, IS_SYSTEM, 
        ORDER_NO, ENABLED, WORK_CARD, SEX, OFFICE_PHONE, 
        PLOITICAL, EDUCATION, EMAIL, MOBILE, RECORDER, 
        RECORD_DATE, MODIFIER, MODIFY_DATE, PARENT_EMPLOYEE_ID, DATA_SOURCE)
        Values
        (:NEW.ID, :NEW.NAME, :NEW.CODE, :NEW.COMP_ID, :NEW.DEPT_ID, 
        :NEW.STATION_NAMES, :NEW.ACCOUNT_ID, :NEW.PINYIN, :NEW.DESCRIPTION, :NEW.IS_SYSTEM, 
        :NEW.ORDER_NO, :NEW.ENABLED, :NEW.WORK_CARD, :NEW.SEX, :NEW.OFFICE_PHONE, 
        :NEW.PLOITICAL, :NEW.EDUCATION, :NEW.EMAIL, :NEW.MOBILE, :NEW.RECORDER, 
        :NEW.RECORD_DATE, :NEW.MODIFIER, :NEW.MODIFY_DATE, :NEW.PARENT_EMPLOYEE_ID, :NEW.DATA_SOURCE);
    WHEN updating THEN  
      UPDATE SECURITY_EMPLOYEE@hydatabase SET 
        NAME=:NEW.NAME, CODE=:NEW.CODE, COMP_ID=:NEW.COMP_ID, DEPT_ID=:NEW.DEPT_ID, 
        STATION_NAMES=:NEW.STATION_NAMES, ACCOUNT_ID=:NEW.ACCOUNT_ID, PINYIN=:NEW.PINYIN, DESCRIPTION=:NEW.DESCRIPTION, IS_SYSTEM=:NEW.IS_SYSTEM, 
        ORDER_NO=:NEW.ORDER_NO, ENABLED=:NEW.ENABLED, WORK_CARD=:NEW.WORK_CARD, SEX=:NEW.SEX, OFFICE_PHONE=:NEW.OFFICE_PHONE, 
        PLOITICAL=:NEW.PLOITICAL, EDUCATION=:NEW.EDUCATION, EMAIL=:NEW.EMAIL, MOBILE=:NEW.MOBILE, RECORDER=:NEW.RECORDER, 
        RECORD_DATE=:NEW.RECORD_DATE, MODIFIER=:NEW.MODIFIER, MODIFY_DATE=:NEW.MODIFY_DATE, PARENT_EMPLOYEE_ID=:NEW.PARENT_EMPLOYEE_ID, DATA_SOURCE=:NEW.DATA_SOURCE
       WHERE ID=:old.ID;  
    WHEN deleting THEN  
      DELETE SECURITY_EMPLOYEE@hydatabase WHERE ID=:old.ID;  
  END CASE;  
END; 

--系统关联

--员工
CREATE OR REPLACE TRIGGER HYOA_SYSACCOUNT_TRIGGER  
AFTER INSERT OR UPDATE OR DELETE ON SECURITY_BUSINESS_SYS_ACCOUNT FOR EACH ROW  
BEGIN  
  CASE  
    WHEN inserting THEN  
        Insert into SECURITY_BUSINESS_SYS_ACCOUNT@hydatabase
        (BUSINESS_SYSTEM_ID, ACCOUNT_ID)
        Values
        (:NEW.BUSINESS_SYSTEM_ID, :NEW.ACCOUNT_ID);
    WHEN updating THEN  
      UPDATE SECURITY_BUSINESS_SYS_ACCOUNT@hydatabase SET 
        BUSINESS_SYSTEM_ID=:NEW.BUSINESS_SYSTEM_ID
       WHERE ACCOUNT_ID=:old.ACCOUNT_ID;  
    WHEN deleting THEN  
      DELETE SECURITY_BUSINESS_SYS_ACCOUNT@hydatabase WHERE ACCOUNT_ID=:old.ACCOUNT_ID;  
  END CASE;  
END; 