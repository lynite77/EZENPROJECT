/*에러정보 ERROR*/

SELECT * FROM ERROR;
DROP TABLE ERROR;
CREATE TABLE ERROR (
    E_CODE varchar2(10) primary key not null,
    E_NAME varchar2(20),
    E_INFO varchar2(100)
);
  
INSERT INTO ERROR VALUES ('E0000', '제품코드', '제품 코드가 불일치 합니다');
INSERT INTO ERROR VALUES ('E0001', '제품명', '제품 이름이  불일치 합니다');
INSERT INTO ERROR VALUES ('E0002', '제품사이즈', '제품 사이즈가 불일치 합니다');
INSERT INTO ERROR VALUES ('E0003', '제품소재', '제품 소재가 불일치 합니다');
INSERT INTO ERROR VALUES ('E0004', '제품색상', '제품 색상이 불일치 합니다');
INSERT INTO ERROR VALUES ('E0005', '제품가격', '제품 가격이 불일치 합니다');
INSERT INTO ERROR VALUES ('E0006', '제품형태', '제품 형태가 불일치 합니다');