
DROP TABLE product; 
DROP TABLE materials;
DROP TABLE production_calendar;
DROP TABLE process_line_equipment;
DROP TABLE warehouses;
DROP TABLE customers;
DROP TABLE common_codes;
DROP TABLE downtime_codes;
DROP TABLE bom;

CREATE TABLE product
(
    CODE VARCHAR2(4) CONSTRAINT PK_PRODUCT PRIMARY KEY,    -- 제품코드
    PNAME VARCHAR2(50), -- 제품명
    MANAGER VARCHAR2(20), -- 작성자
    REGISTER_DATE DATE     -- 등록일자
);

CREATE TABLE materials
(
    CODE VARCHAR2(4) CONSTRAINT PK_MATERIALS PRIMARY KEY,    -- 제품코드
    NAME VARCHAR2(50),
    SUPPLIER VARCHAR2(50)
);

CREATE TABLE production_calendar
(
    REGDATE DATE,
    LINE VARCHAR2(20),
    SHIFT VARCHAR2(20),
    CODE VARCHAR2(4)
);

CREATE TABLE process_line_equipment
(
    PROCESS VARCHAR2(20),
    LINE VARCHAR2(20),
    EQUIPMENT VARCHAR2(20)
);

CREATE TABLE warehouses
(
    WAREHOUSE VARCHAR2(20),
    LOCATION VARCHAR2(20)
);

CREATE TABLE customers
(
    CUSTOMER VARCHAR2(20),
    ADDRESS VARCHAR2(20),
    CONTACT VARCHAR2(20)
);

CREATE TABLE common_codes
(
    CODE VARCHAR2(20),
    DESCRIPTION VARCHAR2(20)
);

CREATE TABLE downtime_codes
(
    CODE VARCHAR2(20),
    REASON VARCHAR2(20)
);

CREATE TABLE bom
(
    PRODUCT_CODE VARCHAR2(20),
    MATERIAL_CODE VARCHAR2(20)
);

INSERT INTO product (code, pname, manager, register_date) VALUES ('1231', 'Product', 'Kim', SYSDATE);
INSERT INTO materials (code, name, supplier) VALUES ('M001', 'Material A', 'Supplier A');
INSERT INTO production_calendar (regdate, line, shift) VALUES (SYSDATE, 'Line A', 'Shift 1');
INSERT INTO process_line_equipment (process, line, equipment) VALUES ('Process A', 'Line A', 'Equipment A');
INSERT INTO warehouses (warehouses, location) VALUES ('Warehouse A', 'Location A');
INSERT INTO customers (customer, address, contact) VALUES ('Customer A', 'Address A', 'Contact A');
INSERT INTO common_codes (code, description) VALUES ('Code A', 'Description A');
INSERT INTO downtime_codes (code, reason) VALUES ('Downtime A', 'Reason A');
INSERT INTO bom (product_code, material_code) VALUES (1231, 'M001');

SELECT * FROM product;
SELECT * FROM materials;
SELECT * FROM production_calendar;
SELECT * FROM process_line_equipment;
SELECT * FROM warehouses;
SELECT * FROM customers;
SELECT * FROM common_codes;
SELECT * FROM downtime_codes;
SELECT * FROM bom;

SELECT p.code, p.pname, p.manager, p.register_date,
       m.name, m.supplier,
       pc.date_col, pc.line, pc.shift,
       ple.process, ple.line, ple.equipment,
       w.warehouses, w.location,
       c.customer, c.address, c.contact,
       cc.code, cc.description,
       dc.code, dc.reason,
       b.product_code, b.material_code
FROM product p
JOIN materials m ON p.code = m.code
JOIN production_calendar pc ON p.code = pc.code
JOIN process_line_equipment ple ON p.code = ple.code
JOIN warehouses w ON p.code = w.code
JOIN customers c ON p.code = c.code
JOIN common_codes cc ON p.code = cc.code
JOIN downtime_codes dc ON p.code = dc.code
JOIN bom b ON p.code = b.product_code;

COMMIT;






