/*상품정보 PRODUCT*/

SELECT * FROM PRODUCT order by P_CODE desc;
SELECT COUNT(*) FROM PRODUCT;
DROP TABLE PRODUCT;
CREATE TABLE PRODUCT (
    P_CODE varchar2(15) primary key not null,
    P_NAME varchar2(30),
    P_COLOR varchar2(50),   -- RED / BLUE / GREEN / BLACK / WHITE
    P_SIZE varchar2(10),       -- S / L / XL / XXL / XXXL
    P_LENGTH varchar2(10),  -- long / short
    P_PRICE varchar2(10),      -- WON
    P_INFO varchar2(50)
);

CREATE SEQUENCE emp_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 100000;

CREATE SEQUENCE emp_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 100000;

DROP SEQUENCE PRODUCT_SEQ;
CREATE SEQUENCE PRODUCT_SEQ
INCREMENT BY 1
START WITH 9106
MINVALUE 1
MAXVALUE 50000
NOCYCLE;


INSERT INTO PRODUCT VALUES ('P230718_' || PRODUCT_SEQ.NEXTVAL,'여름 반팔A','RED', 'XL', 'long', '30000', '라운드넥');

-- 1부터 10000까지의 숫자로 반복하여 INSERT 문 실행
BEGIN
   FOR i IN 1..100 LOOP
      INSERT INTO PRODUCT (P_CODE, P_NAME, P_COLOR, P_SIZE, P_LENGTH, P_PRICE, P_INFO)
      VALUES ('P230720_' || PRODUCT_SEQ.NEXTVAL, '여름 반팔C','RED', 'XL', 'short', '150000', '라운드넥');
   END LOOP;
   COMMIT; -- 변경 내용을 커밋하여 영구적으로 저장
END;
/

BEGIN
   FOR i IN 1..1000 LOOP
      INSERT INTO PRODUCT (P_CODE, P_NAME, P_COLOR, P_SIZE, P_LENGTH, P_PRICE, P_INFO)
      VALUES ('P230720_' || PRODUCT_SEQ.NEXTVAL, '여름 반팔B','BLUE', 'XXL', 'short', '90000', '라운드넥');
   END LOOP;
   COMMIT; -- 변경 내용을 커밋하여 영구적으로 저장
END;
/

BEGIN
   FOR i IN 1..1000 LOOP
      INSERT INTO PRODUCT (P_CODE, P_NAME, P_COLOR, P_SIZE, P_LENGTH, P_PRICE, P_INFO)
      VALUES ('P230720_' || PRODUCT_SEQ.NEXTVAL, '여름 반팔C','BLACK', 'L', 'long', '30000', '라운드넥');
   END LOOP;
   COMMIT; -- 변경 내용을 커밋하여 영구적으로 저장
END;
/

BEGIN
   FOR i IN 1..1000 LOOP
      INSERT INTO PRODUCT (P_CODE, P_NAME, P_COLOR, P_SIZE, P_LENGTH, P_PRICE, P_INFO)
      VALUES ('P230720_' || PRODUCT_SEQ.NEXTVAL, '여름 반팔A','WHITE', 'S', 'long', '50000', '브이넥');
   END LOOP;
   COMMIT; -- 변경 내용을 커밋하여 영구적으로 저장
END;
/

INSERT INTO PRODUCT VALUES ('P230711_1','여름 반팔A','RED', 'XL', 'long', '30000', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_2','여름 반팔A','BLUE', 'XXL', 'short', '150000', '브이넥');
INSERT INTO PRODUCT VALUES ('P230711_3','여름 반팔A','GREEN', 'L', 'short', '15500', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_4','여름 반팔A','BLACK', 'S', 'short', '15000', '브이넥');
INSERT INTO PRODUCT VALUES ('P230711_5','여름 반팔A','WHITE', 'S', 'long', '50000', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_6','여름 반팔A','RED', 'S', 'short', '450000', '티셔츠');
INSERT INTO PRODUCT VALUES ('P230711_7','여름 반팔A','BLUE', 'L', 'long', '25000', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_8','여름 반팔A','GREEN', 'XXXL', 'long', '32100', '브이넥');
INSERT INTO PRODUCT VALUES ('P230711_9','여름 반팔C','BLACK', 'XL', 'short', '19900', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_10','여름 반팔C','WHITE', 'XL', 'short', '10000', '브이넥');
INSERT INTO PRODUCT VALUES ('P230711_11','여름 반팔C','RED', 'XL', 'short', '150000', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_12','여름 반팔C','BLUE', 'XL', 'long', '150000', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_13','여름 반팔C','GREEN', 'L', 'short', '155000', '브이넥');
INSERT INTO PRODUCT VALUES ('P230711_14','여름 반팔C','BLACK', 'L', 'short', '30000', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_15','여름 반팔B','WHITE', 'XL', 'long', '90000', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_16','여름 반팔B','RED', 'XXL', 'long', '9990', '브이넥');
INSERT INTO PRODUCT VALUES ('P230711_17','여름 반팔B','BLUE', 'S', 'short', '52000', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_18','여름 반팔B','GREEN', 'L', 'short', '45000', '브이넥');
INSERT INTO PRODUCT VALUES ('P230711_19','여름 반팔B','BLACK', 'XXXL', 'short', '100000', '라운드넥');
INSERT INTO PRODUCT VALUES ('P230711_20','여름 반팔B','WHITE', 'XXXL', 'long', '1500', '브이넥');















INSERT INTO PRODUCT VALUES ('P230701_1', '여름 남자 반팔', '여름남자반팔 형태');
INSERT INTO PRODUCT VALUES ('P230701_2', '여름 남자 반팔B', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230701_3', '여름 여자 반팔A', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230701_4', '여름 여자 반팔B', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230701_5', '어린이 반팔A', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230701_6', '어린이 반팔B', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230702_1', '여름 남자 반바지A', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230702_2', '여름 남자 반바지B', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230702_3', '여름 여자 반바지A', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230702_4', '여름 여자 반바지B', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230702_5', '어린이 반바지A', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230702_6', '어린이 반바지B', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230703_1', '여름 여자 원피스A', '여름남자반팔 형태A');
INSERT INTO PRODUCT VALUES ('P230703_2', '여름 여자 원피스B', '여름남자반팔 형태A');




