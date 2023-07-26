-- 전체 내용 포함하는 뷰 생성
CREATE OR REPLACE VIEW QualityTable
    AS
        select q.quality_code as quality_code, q.order_code as order_code, q.product_code as product_code, q.error_code as error_code, e.error_name, check_info, q.member_code as member_code, check_date, m.member_name as member_name, id ,role, pwd, regdate, product_name, product_info, order_count, ORDER_DATE, t.member_name as temporary FROM QUALITY_INFO q, MEMBER_INFO m, PRODUCT_INFO p, ORDER_INFO o, temporary_worker t, error_info e where q.error_code = e.error_code(+) and q.member_code = m.member_code(+) and q.product_code=p.product_code and q.order_code=o.order_code and q.quality_code = t.quality_code(+) order by QUALITY_CODE;

select * from qualitytable;

-- 작업지시부분 뷰 생성
CREATE OR REPLACE VIEW orderView
    AS
        select o.*, PRODUCT_NAME from order_info o, PRODUCT_INFO p where o.product_code = p.product_code order by order_code;

-- 목록 역순 조회
SELECT rownum, a.* FROM (SELECT rownum rnum, b.* FROM (select * FROM qualitytable) b order by rnum desc) a;

-- 목록 번호로 조회
SELECT rownum, a.* FROM (SELECT rownum rnum, b.* FROM (select * FROM qualitytable where member_name = '선택' order by QUALITY_code desc) b ) a where rnum between 11 and 12;

-- 이름으로 조회
select count(rownum) from qualitytable WHERE member_name = '선택';

-- 이름으로 조회를 구역 조회
SELECT rownum, a.* FROM (SELECT rownum rnum, b.* FROM (select * FROM PRODUCTION  WHERE member_name like '%김단군%' order by quality_code desc) b) a where rnum BETWEEN 1 AND 10;

-- 멤버 코드 조회
select member_code from member_info where member_name = '광개토';

-- 멤버 코드 조회
select member_code from quality_info where quality_code = 'Q230703180';

-- Test용 check_info 생성
update quality_info set check_date = sysdate, check_info = '한글' where quality_code = 'Q230718360';

select * from quality_info;

SELECT rownum, a.* FROM (SELECT rownum rnum, b.* FROM (select * FROM qualitytable WHERE '' like '' order by quality_code desc) b) a WHERE rnum BETWEEN 1 AND 15;

update quality_info set check_date = sysdate, check_info = '자 이제 시작이야', member_code = 2020030001, error_code = '' where quality_code = 'Q230719540';