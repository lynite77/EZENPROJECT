-- 회원 DATA
Insert into MEMBER_INFO (ID,PWD,MEMBER_NAME,RRN,TEL,EMAIL,MEMBER_CODE,REGDATE,ROLE) values ('admin','admin','관 리자','989898-1515151','010-4321-5678','asd@sa.kr',MEMBER_CODE_GET('now'),'23/07/10','admin');
Insert into MEMBER_INFO (ID,PWD,MEMBER_NAME,RRN,TEL,EMAIL,MEMBER_CODE,REGDATE,ROLE) values ('user','user','유 우저','121313-5435345','010-4635-5675','asd@asd.com',MEMBER_CODE_GET('now'),'23/07/11','user');
Insert into MEMBER_INFO (ID,PWD,MEMBER_NAME,RRN,TEL,EMAIL,MEMBER_CODE,REGDATE,ROLE) values ('guest','guest','게 스트','232566-7686455','010-5676-5756','asd@as.com',MEMBER_CODE_GET('now'),'23/07/12','guest');

select member_name from member_info where role !='guest' order by member_name;
SELECT * FROM MEMBER_INFO;

-- 품목 정보
INSERT INTO PRODUCT_INFO VALUES (10000001, '실', 'white','small','long',500,'부재료');
INSERT INTO PRODUCT_INFO VALUES (10000002, '바늘', 'silver','small','short',1000,'도구');
INSERT INTO PRODUCT_INFO VALUES (20000001, '양말', 'black','small','short',1000,'양말');
INSERT INTO PRODUCT_INFO VALUES (20000002, '티셔츠', 'white', 'medium','short', 30000, '상의이너');
INSERT INTO PRODUCT_INFO VALUES (20000003, '폴로셔츠', 'gray','large','middle',50000,'상의이너');
INSERT INTO PRODUCT_INFO VALUES (30000001, '청바지', 'blue','large','long',70000,'하의바지');
INSERT INTO PRODUCT_INFO VALUES (30000002, '슬랙스', 'navy','medium','long',100000,'하의바지');
INSERT INTO PRODUCT_INFO VALUES (32000001, '미니스커트', 'red','medium','short',60000,'하의치마');
INSERT INTO PRODUCT_INFO VALUES (40000001, '운동화', 'green','small','middle',100000,'신발');
INSERT INTO PRODUCT_INFO VALUES (40000002, '캔버스화', 'yellow','medium','middel',50000,'신발');
INSERT INTO PRODUCT_INFO VALUES (50000001, '팬티', 'purple','small','middle',10000,'속옷');
INSERT INTO PRODUCT_INFO VALUES (50000002, '내복', 'white','medium','long',20000,'속옷');

SELECT * FROM PRODUCT_INFO;

-- 작업 지시 정보
INSERT INTO ORDER_INFO(order_code,product_code,order_COUNT) VALUES (ORDER_CODE_GET('now'), 20000002, 20);
INSERT INTO ORDER_INFO(order_code,product_code,order_COUNT) VALUES (ORDER_CODE_GET('now'), 30000001, 15);
INSERT INTO ORDER_INFO(order_code,product_code,order_COUNT) VALUES (ORDER_CODE_GET('now'), 30000002, 25);
INSERT INTO ORDER_INFO(order_code,product_code,order_COUNT) VALUES (ORDER_CODE_GET('now'), 32000001, 30);
INSERT INTO ORDER_INFO(order_code,product_code,order_COUNT) VALUES (ORDER_CODE_GET('now'), 50000001, 10);
INSERT INTO ORDER_INFO(order_code,product_code,order_COUNT) VALUES (ORDER_CODE_GET('now'), 50000002, 10);
INSERT INTO ORDER_INFO(order_code,product_code,order_COUNT) VALUES (ORDER_CODE_GET('now'), 40000001, 20);
INSERT INTO ORDER_INFO(order_code,product_code,order_COUNT) VALUES (ORDER_CODE_GET('now'), 40000002, 20);

DELETE FROM ORDER_INFO;
SELECT * FROM ORDER_INFO;
commit;
-- 에러 정보
INSERT INTO ERROR_INFO VALUES ('00', '이상없음', '문제없음');
INSERT INTO ERROR_INFO VALUES ('01', '기기불량', '기계불량');
INSERT INTO ERROR_INFO VALUES ('02', '작업자실수', '작업자실수');
INSERT INTO ERROR_INFO VALUES ('03', '박음질불량', '품질불량');
INSERT INTO ERROR_INFO VALUES ('04', '탈색불량', '품질불량');
INSERT INTO ERROR_INFO VALUES ('05', '접합불량', '품질불량');
INSERT INTO ERROR_INFO VALUES ('06', '유해물질발견', '품질불량');

SELECT * FROM ERROR_INFO;

DELETE QUALITY_INFO;
SELECT * FROM QUALITY_INFO order by quality_code desc;

SELECT * FROM TEMPORARY_WORKER;
DELETE TEMPORARY_WORKER;
-- 공정 정보

CREATE OR REPLACE TRIGGER INSERTPROCESS
AFTER INSERT ON ORDER_INFO FOR EACH ROW
DECLARE
    AVERAGE NUMBER;
    BEGIN
        declare
			i number:=0;
			begin
				for i in 1..:NEW.ORDER_COUNT
                LOOP
				INSERT INTO QUALITY_INFO(QUALITY_CODE, ORDER_CODE, PRODUCT_CODE)
				VALUES(QUALITY_CODE_GET('now'), :NEW.ORDER_CODE, :NEW.PRODUCT_CODE);
				end loop;
			end;
    END;  
    
-- 임시작업자 테이블에 품질 코드 입력
CREATE OR REPLACE TRIGGER INSERTWORKER
AFTER INSERT ON QUALITY_INFO FOR EACH ROW
DECLARE
    BEGIN
        INSERT INTO TEMPORARY_WORKER(quality_code) VALUES(:NEW.QUALITY_CODE);
    END;