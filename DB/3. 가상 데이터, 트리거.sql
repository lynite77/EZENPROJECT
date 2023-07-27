-- 회원 DATA
Insert into MEMBER_INFO (ID,PWD,MEMBER_NAME,RRN,TEL,EMAIL,MEMBER_CODE,REGDATE,ROLE) values ('admin','admin','관 리자','989898-1515151','010-4321-5678','asd@sa.kr',MEMBER_CODE_GET('now'),'23/07/10','admin');
Insert into MEMBER_INFO (ID,PWD,MEMBER_NAME,RRN,TEL,EMAIL,MEMBER_CODE,REGDATE,ROLE) values ('user','user','유 우저','121313-5435345','010-4635-5675','asd@asd.com',MEMBER_CODE_GET('now'),'23/07/11','user');
Insert into MEMBER_INFO (ID,PWD,MEMBER_NAME,RRN,TEL,EMAIL,MEMBER_CODE,REGDATE,ROLE) values ('guest','guest','게 스트','232566-7686455','010-5676-5756','asd@as.com',MEMBER_CODE_GET('now'),'23/07/12','guest');

select member_name from member_info where role !='guest' order by member_name;
SELECT * FROM MEMBER_INFO;

-- 품목 정보
INSERT INTO PRODUCT_INFO VALUES (10000001, '실', 'white','S','long',500,'부재료');
INSERT INTO PRODUCT_INFO VALUES (10000002, '바늘', 'silver','S','short',1000,'도구');
INSERT INTO PRODUCT_INFO VALUES (20000001, '양말', 'black','S','short',1000,'양말');
INSERT INTO PRODUCT_INFO VALUES (20000002, '티셔츠', 'white', 'M','short', 30000, '상의이너');
INSERT INTO PRODUCT_INFO VALUES (20000003, '폴로셔츠', 'gray','L','middle',50000,'상의이너');
INSERT INTO PRODUCT_INFO VALUES (30000001, '청바지', 'blue','L','long',70000,'하의바지');
INSERT INTO PRODUCT_INFO VALUES (30000002, '슬랙스', 'navy','M','long',100000,'하의바지');
INSERT INTO PRODUCT_INFO VALUES (32000001, '미니스커트', 'red','M','short',60000,'하의치마');
INSERT INTO PRODUCT_INFO VALUES (40000001, '운동화', 'green','S','middle',100000,'신발');
INSERT INTO PRODUCT_INFO VALUES (40000002, '캔버스화', 'yellow','M','middle',50000,'신발');
INSERT INTO PRODUCT_INFO VALUES (50000001, '팬티', 'purple','S','middle',10000,'속옷');
INSERT INTO PRODUCT_INFO VALUES (50000002, '내복', 'white','M','long',20000,'속옷');

INSERT INTO PRODUCT_INFO VALUES (20000003,'여름 반팔A','RED', 'XL', 'long', 30000, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000004,'여름 반팔A','BLUE', 'XXL', 'short', 150000, '브이넥');
INSERT INTO PRODUCT_INFO VALUES (20000005,'여름 반팔A','GREEN', 'L', 'short', 15500, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000006,'여름 반팔A','BLACK', 'S', 'short', 15000, '브이넥');
INSERT INTO PRODUCT_INFO VALUES (20000007,'여름 반팔A','WHITE', 'S', 'long', 50000, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000008,'여름 반팔A','RED', 'S', 'short', 450000, '티셔츠');
INSERT INTO PRODUCT_INFO VALUES (20000009,'여름 반팔A','BLUE', 'L', 'long', 25000, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000010,'여름 반팔A','GREEN', 'XXXL', 'long', 32100, '브이넥');
INSERT INTO PRODUCT_INFO VALUES (20000011,'여름 반팔C','BLACK', 'XL', 'short', 19900, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000012,'여름 반팔C','WHITE', 'XL', 'short', 10000, '브이넥');
INSERT INTO PRODUCT_INFO VALUES (20000013,'여름 반팔C','RED', 'XL', 'short', 150000, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000014,'여름 반팔C','BLUE', 'XL', 'long', 150000, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000015,'여름 반팔C','GREEN', 'L', 'short', 155000, '브이넥');
INSERT INTO PRODUCT_INFO VALUES (20000016,'여름 반팔C','BLACK', 'L', 'short', 30000, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000017,'여름 반팔B','WHITE', 'XL', 'long', 90000, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000018,'여름 반팔B','RED', 'XXL', 'long', 9990, '브이넥');
INSERT INTO PRODUCT_INFO VALUES (20000019,'여름 반팔B','BLUE', 'S', 'short', 52000, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000020,'여름 반팔B','GREEN', 'L', 'short', 45000, '브이넥');
INSERT INTO PRODUCT_INFO VALUES (20000021,'여름 반팔B','BLACK', 'XXXL', 'short', 100000, '라운드넥');
INSERT INTO PRODUCT_INFO VALUES (20000022,'여름 반팔B','WHITE', 'XXXL', 'long', 1500, '브이넥');

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
	
	
-- 에러데이터 입력
update Quality_info set error_code = '01' where quality_code like '%0726%';
update Quality_info set error_code = '02' where quality_code like '%07264%';
update Quality_info set error_code = '03' where quality_code like '%07265%';
update Quality_info set error_code = '04' where quality_code like '%072701%';
update Quality_info set error_code = '05' where quality_code like '%072702%';
update Quality_info set error_code = '05' where quality_code like '%072703%';
update Quality_info set error_code = '06' where quality_code like '%0727041%';
update Quality_info set error_code = '06' where quality_code like '%0727042%';  
update Quality_info set error_code = '01' where quality_code like '%0727043%';  