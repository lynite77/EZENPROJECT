select ORDER_CODE_SEQ.currval from dual;
select QUALITY_CODE_SEQ.currval from dual;
select MEMBER_CODE_SEQ.currval from dual;
select ORDER_CODE_GET('now') from dual;
select QUALITY_CODE_GET('NOW') from dual;
DROP SEQUENCE ORDER_CODE_SEQ;

-- 주문 번호 뒷자리 시퀀스
CREATE SEQUENCE ORDER_CODE_SEQ
	START WITH 1
	MAXVALUE 999
	MINVALUE 1
	NOCYCLE
	CACHE 20;
-- 일별로 주문 번호 뒷자리 초기화 시퀀스
CREATE OR REPLACE PROCEDURE ORDER_CODE_DATE_RESET(SEQ_NAME IN VARCHAR2)
IS
    L_VAL NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_NAME ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_NAME ||' INCREMENT BY -'|| L_VAL ||' MINVALUE 0';
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_NAME ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_NAME ||' INCREMENT BY 1 MINVALUE 0';
END;
-- 프로시저 등록
DECLARE
    X NUMBER;
BEGIN
        SYS.DBMS_JOB.SUBMIT
        (
              job => X
            , what =>
                'BEGIN
                        ORDER_CODE_DATE_RESET(''ORDER_CODE_SEQ'');
                 END;'
            , next_date => to_date('06-28-2023 00:00:00', 'mm/dd/yyyy hh24:mi:ss')
            , interval => 'TRUNC(SYSDATE+1)'
            , no_parse => FALSE
        );
        SYS.DBMS_OUTPUT.PUT_LINE('Job Number is : '|| to_char(X));
END;
-- 함수 생성
CREATE OR REPLACE FUNCTION ORDER_CODE_GET(
    p_type in varchar2
) RETURN VARCHAR2
AS
     v_returnValue VARCHAR2(180);
BEGIN
    BEGIN
 
        select TO_CHAR(SYSDATE, '"O"YYMMDD') || LPAD(ORDER_CODE_SEQ.nextval, 3, 0)
          into v_returnValue
          from dual;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_returnValue := ' ';
      WHEN OTHERS THEN
        v_returnValue := ' ';
    END;
    RETURN v_returnValue;
END;


-- 품질 번호 뒷자리 시퀀스
CREATE SEQUENCE QUALITY_CODE_SEQ
	START WITH 1
	MAXVALUE 999
	MINVALUE 1
	NOCYCLE
	CACHE 20;
-- 일별로 생산 번호 뒷자리 초기화 시퀀스
CREATE OR REPLACE PROCEDURE QUALITY_CODE_DATE_RESET(SEQ_NAME IN VARCHAR2)
IS
    L_VAL NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_NAME ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_NAME ||' INCREMENT BY -'|| L_VAL ||' MINVALUE 0';
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_NAME ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_NAME ||' INCREMENT BY 1 MINVALUE 0';
END;
-- 프로시저 등록
DECLARE
    X NUMBER;
BEGIN
        SYS.DBMS_JOB.SUBMIT
        (
              job => X
            , what =>
                'BEGIN
                        QUALITY_CODE_DATE_RESET(''QUALITY_CODE_SEQ'');
                 END;'
            , next_date => to_date('06-28-2023 00:00:00', 'mm/dd/yyyy hh24:mi:ss')
            , interval => 'TRUNC(SYSDATE+1)'
            , no_parse => FALSE
        );
        SYS.DBMS_OUTPUT.PUT_LINE('Job Number is : '|| to_char(X));
END;
-- 함수 생성
CREATE OR REPLACE FUNCTION QUALITY_CODE_GET(
    p_type in varchar2
) RETURN VARCHAR2
AS
     v_returnValue VARCHAR2(180);
BEGIN
    BEGIN
 
        select TO_CHAR(SYSDATE, '"Q"YYMMDD') || LPAD(QUALITY_CODE_SEQ.nextval, 3, 0)
          into v_returnValue
          from dual;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_returnValue := ' ';
      WHEN OTHERS THEN
        v_returnValue := ' ';
    END;
    RETURN v_returnValue;
END;

-- 회원 번호 뒷자리 시퀀스
CREATE SEQUENCE MEMBER_CODE_SEQ
	START WITH 1
	MAXVALUE 9999
	MINVALUE 1
	NOCYCLE
	CACHE 20;
-- 월별로 회원 번호 뒷자리 초기화 시퀀스
CREATE OR REPLACE PROCEDURE MEMBER_CODE_DATE_RESET(SEQ_NAME IN VARCHAR2)
IS
    L_VAL NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_NAME ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_NAME ||' INCREMENT BY -'|| L_VAL ||' MINVALUE 0';
    EXECUTE IMMEDIATE 'SELECT '|| SEQ_NAME ||'.NEXTVAL FROM DUAL' INTO L_VAL;
    EXECUTE IMMEDIATE 'ALTER SEQUENCE '|| SEQ_NAME ||' INCREMENT BY 1 MINVALUE 0';
END;
-- 프로시저 등록
DECLARE
    X NUMBER;
BEGIN
        SYS.DBMS_JOB.SUBMIT
        (
              job => X
            , what =>
                'BEGIN
                        MEMBER_CODE_DATE_RESET(''MEMBER_CODE_SEQ'');
                 END;'
            , next_date => to_date('06-28-2023 00:00:00', 'mm/dd/yyyy hh24:mi:ss')
            , interval => 'ADD_MONTHS(TRUNC(SYSDATE,''MM''),1)'
            , no_parse => FALSE
        );
        SYS.DBMS_OUTPUT.PUT_LINE('Job Number is : '|| to_char(X));
END;
-- 함수 생성
CREATE OR REPLACE FUNCTION MEMBER_CODE_GET(
    p_type in varchar2
) RETURN VARCHAR2
AS
     v_returnValue VARCHAR2(180);
BEGIN
    BEGIN
 
        select TO_CHAR(SYSDATE, 'YYYYMM') || LPAD(MEMBER_CODE_SEQ.nextval, 4, 0)
          into v_returnValue
          from dual;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_returnValue := ' ';
      WHEN OTHERS THEN
        v_returnValue := ' ';
    END;
    RETURN v_returnValue;
END;
-- 회원번호 등록 쿼리 예시
--MEMBER_CODE_GET('now')