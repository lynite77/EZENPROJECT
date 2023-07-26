/*사원정보 MEMBER_INFO*/

SELECT * FROM MEMBER_INFO;
DROP TABLE MEMBER_INFO;
CREATE TABLE MEMBER_INFO (
	M_CODE number(10) primary key not null,
	M_NAME varchar2(20) not null,
	M_LEVEL varchar2(10),
	password varchar2(12) not null,
	REGDATE date default sysdate
);

INSERT INTO MEMBER_INFO VALUES (2020030001, '김단군', 'admin', 'admin', default);
INSERT INTO MEMBER_INFO VALUES (2021080001, '고동명', 'super', '1234', default);
INSERT INTO MEMBER_INFO VALUES (2021080002, '백온조', 'super', '1234', default);
INSERT INTO MEMBER_INFO VALUES (2021090001, '혁거세', 'super', '1234', default);
SELECT * FROM MEMBER_INFO;

INSERT INTO MEMBER_INFO VALUES (MEMBER_CODE_GET('now'), '광개토', 'user', '1234', default);
INSERT INTO MEMBER_INFO VALUES (MEMBER_CODE_GET('now'), '이사부', 'user', '1234', default);
INSERT INTO MEMBER_INFO VALUES (MEMBER_CODE_GET('now'), '김유신', 'user', '1234', default);
INSERT INTO MEMBER_INFO VALUES (MEMBER_CODE_GET('now'), '장보고', 'user', '1234', default);
