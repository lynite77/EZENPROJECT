DROP TABLE PRODUCT_INFO;
DROP TABLE MEMBER_INFO;
DROP TABLE ORDER_INFO;
DROP TABLE ERROR_INFO;
DROP TABLE QUALITY_INFO;
DROP TABLE TEMPORARY_WORKER;

select * From PRODUCT_INFO;
select * From MEMBER_INFO;
select * From ORDER_INFO;
select * From ERROR_INFO;
select * From QUALITY_INFO;
select * from TEMPORARY_WORKER;

-- 회원 정보
CREATE TABLE MEMBER_INFO (
    ID VARCHAR2(20) unique NOT NULL, 
	PWD VARCHAR2(20) NOT NULL, 
	MEMBER_NAME VARCHAR2(50), 
	RRN VARCHAR2(20), 
	TEL VARCHAR2(20), 
	EMAIL VARCHAR2(100), 
	MEMBER_CODE NUMBER(10) PRIMARY KEY NOT NULL, 
	REGDATE DATE default sysdate, 
	ROLE VARCHAR2(20 BYTE) DEFAULT 'guest' NOT NULL
);

-- 품목 정보
CREATE TABLE PRODUCT_INFO (
	PRODUCT_CODE number(8) primary key not null,
    PRODUCT_NAME varchar2(20),
    PRODUCT_COLOR varchar2(20),
    PRODUCT_SIZE varchar2(20),
    PRODUCT_LENGTH varchar2(20),
    PRODUCT_PRICE number(20),
    PRODUCT_INFO varchar2(50)
);

-- 작업 지시 정보
CREATE TABLE ORDER_INFO (
  ORDER_CODE varchar2(10) primary key not null,
  PRODUCT_CODE number(8) references product_info, 
  ORDER_COUNT number(10) not null,
  ORDER_INFO varchar2(50),
  ORDER_DATE date default sysdate
);

-- 에러정보
CREATE TABLE ERROR_INFO (
	ERROR_CODE varchar2(10) primary key,
	ERROR_NAME varchar(20) not null,
	ERROR_INFO varchar(50)
);

-- 품질검사
CREATE TABLE QUALITY_INFO (
	QUALITY_CODE varchar2(10) primary key,
	ORDER_CODE varchar2(10) references ORDER_INFO,
	PRODUCT_CODE number(8) references PRODUCT_INFO,
	ERROR_CODE varchar2(10) references ERROR_INFO,
    CHECK_INFO varchar(50),
	MEMBER_CODE number(10) references MEMBER_INFO,
    CHECK_DATE date default null
);

CREATE TABLE TEMPORARY_WORKER (
    QUALITY_CODE varchar2(10) references QUALITY_INFO,
    MEMBER_CODE number(10) references MEMBER_INFO,
    MEMBER_NAME varchar2(20)
);

update temporary_worker set member_code = ? where order_code = ?;
select member_code, order_code from order_info;