CREATE TABLE IPSS_XY.TEST_SUBJECT
(
  CLASS    VARCHAR2(40 BYTE),
  NAME     VARCHAR2(40 BYTE),
  SUBJECT  VARCHAR2(40 BYTE),
  CORE     VARCHAR2(100 BYTE)
)
TABLESPACE DB_DATA
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

select * from (select class,name,subject,RANK() OVER(PARTITION BY c.class,c.subject ORDER BY c.core DESC) test  from TEST_SUBJECT c) where test=1

select class,name,subject,core from TEST_SUBJECT t1 where not exists (select * from TEST_SUBJECT where  class=t1.class and subject=t1.subject and core>t1.core)