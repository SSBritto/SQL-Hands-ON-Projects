
CREATE DATABASE INVENT;
USE INVENT;

--CREATING TABLES :

CREATE TABLE SUPPLIER
(SID CHAR(5), SNAME VARCHAR(30), SADD VARCHAR(50), SCITY VARCHAR(30), SPHONE CHAR(10), EMAIL VARCHAR(60));

CREATE TABLE PRODUCT
(PID CHAR(5), PDESC VARCHAR(100), PRICE INT, SID CHAR(5));

CREATE TABLE STOCK
(PID CHAR(5), SQTY INT, ROL INT, MOQ INT);

CREATE TABLE CUSTOMER
(CID CHAR(5), CNAME VARCHAR(40), CADD VARCHAR(50),CCITY VARCHAR(30),CPHONE CHAR(10), CEMAIL VARCHAR(60),
DOB DATE);

CREATE TABLE ORDERS
(OID CHAR(5), ODATE DATE, PID CHAR(5), CID CHAR(5), OQTY INT);

--ADDING CONSTRAINTS :

ALTER TABLE SUPPLIER
ALTER COLUMN SNAME VARCHAR(30) NOT NULL;
ALTER TABLE SUPPLIER
ALTER COLUMN SADD VARCHAR(50) NOT NULL;
ALTER TABLE SUPPLIER
ADD CONSTRAINT DEF DEFAULT 'CHENNAI' FOR SCITY;
ALTER TABLE SUPPLIER
ADD CONSTRAINT UNQ UNIQUE(SPHONE);
ALTER TABLE SUPPLIER
ALTER COLUMN SID CHAR(5) NOT NULL;
ALTER TABLE SUPPLIER
ADD CONSTRAINT PK PRIMARY KEY(SID);


ALTER TABLE PRODUCT
ALTER COLUMN PDESC VARCHAR(100) NOT NULL;
ALTER TABLE PRODUCT
ADD CONSTRAINT CHK CHECK(PRICE >0);
ALTER TABLE PRODUCT
ALTER COLUMN SID CHAR(5) NOT NULL;
ALTER TABLE PRODUCT
ADD CONSTRAINT FK FOREIGN KEY(SID) REFERENCES SUPPLIER(SID);
ALTER TABLE PRODUCT
ALTER COLUMN PID CHAR(5) NOT NULL;
ALTER TABLE PRODUCT 
ADD CONSTRAINT PK_1 PRIMARY KEY (PID);

ALTER TABLE STOCK
ADD CONSTRAINT CHK_1 CHECK(SQTY>=0);
ALTER TABLE STOCK
ADD CONSTRAINT CHK_2 CHECK(ROL>=0);
ALTER TABLE STOCK
ADD CONSTRAINT CHCK_3 CHECK(MOQ>=5);

ALTER TABLE CUSTOMER
ALTER COLUMN CNAME VARCHAR(40) NOT NULL;
ALTER TABLE CUSTOMER
ALTER COLUMN CADD VARCHAR(60) NOT NULL;
ALTER TABLE CUSTOMER
ALTER COLUMN CCITY VARCHAR(30) NOT NULL;
ALTER TABLE CUSTOMER
ALTER COLUMN CPHONE CHAR(10) NOT NULL;
ALTER TABLE CUSTOMER
ALTER COLUMN CEMAIL VARCHAR(60) NOT NULL;
ALTER TABLE CUSTOMER
ADD CONSTRAINT UNQ_1 UNIQUE(CPHONE);
ALTER TABLE CUSTOMER
ADD CONSTRAINT CHK_4 CHECK(DOB<='01 JANUARY 2000');
ALTER TABLE CUSTOMER
ALTER COLUMN CID CHAR(5) NOT NULL;
ALTER TABLE CUSTOMER
ADD CONSTRAINT PK_2 PRIMARY KEY(CID);

ALTER TABLE ORDERS
ADD CONSTRAINT CHK_5 CHECK(OQTY>=1);
ALTER TABLE ORDERS
ALTER COLUMN PID CHAR(5) NOT NULL;
ALTER TABLE ORDERS
ADD CONSTRAINT FK_1 FOREIGN KEY (PID) REFERENCES PRODUCT(PID);
ALTER TABLE ORDERS
ALTER COLUMN CID CHAR(5) NOT NULL;
ALTER TABLE ORDERS
ADD CONSTRAINT FK_2 FOREIGN KEY (CID) REFERENCES CUSTOMER(CID);

--CREATING SEQUENCE, FUNCTION AND PROCEDURES FOR INSERTING OF DATAS :

CREATE SEQUENCE SEQ
AS INT
START WITH 1
INCREMENT BY 1;

CREATE FUNCTION ID_CREATE (@C AS CHAR(1),@I AS INT)
RETURNS CHAR(5)
AS
BEGIN
		DECLARE @ID AS CHAR(5);
		IF @I<10
		SET @ID = CONCAT(@C,'000',@I);
		ELSE IF @I<100
		SET @ID = CONCAT(@C,'00',@I);
		ELSE IF @I<1000
		SET @ID = CONCAT(@C,'0',@I);
		ELSE
		SET @ID ='NA';

		RETURN @ID;
END;

CREATE PROCEDURE INSRT_DATA (@SN AS VARCHAR(30), @SAD AS VARCHAR(50), @SCY AS VARCHAR(30),@SPH AS CHAR(10),
					@D AS VARCHAR(20))

AS
BEGIN

				DECLARE @I AS INT;
				DECLARE @ID AS CHAR(5);
				DECLARE @EM AS VARCHAR(60);
				DECLARE @LN AS INT;
				DECLARE @S AS INT;
				DECLARE @LL AS VARCHAR(2);


				SET @I = (NEXT VALUE FOR SEQ);
				SET @ID = DBO.ID_CREATE('S',@I);
				SET @LN = LEN(@SN);
				SET @S = CHARINDEX(' ',@SN);
				SET @LL = SUBSTRING(RIGHT(@SN,@LN-@S),1,2);
				SET @EM = CONCAT(LEFT(@SN,2),@LL,RIGHT(@ID,2),'@',@D,'.COM');

				INSERT INTO SUPPLIER
				VALUES(@ID,@SN,@SAD,@SCY,@SPH,@EM);

				SELECT * FROM SUPPLIER;

END;

INSRT_DATA 'ABHILASH RAJ', '24/2 KAMARAJAR STREET', 'CHENNAI', '8879654901','GMAIL';
INSRT_DATA 'BALAMURALI KRISHNAN', '44A/4 6TH AVENUE', 'CHENNAI', '9952189030','GMAIL';
INSRT_DATA 'BENNISON JOHN', '87/1A KAALIAMMAN STREET', 'NAGERCOIL', '9786783440','YAHOO';
INSRT_DATA 'CLARET DENMARK', '303C,RAMAN NADAR COLONY', 'NAGERCOIL', '9789656724','GMAIL';
INSRT_DATA 'DEVARAJ EKAMBARAM', '44A/4 PARK ROAD,A.R.P CAMP', 'CHENNAI', '9978678990','YAHOO';


CREATE SEQUENCE SEQ_1
AS INT
START WITH 1
INCREMENT BY 1;

CREATE PROCEDURE INSRT_DATA_PR (@DESC AS VARCHAR(100), @PR AS INT, @SID AS CHAR(5))
AS
BEGIN

				DECLARE @I AS INT;
				DECLARE @ID AS CHAR(5);

				SET @I = (NEXT VALUE FOR SEQ_1);
				SET @ID = DBO.ID_CREATE('P',@I);


				INSERT INTO PRODUCT
				VALUES(@ID,@DESC,@PR,@SID);

				SELECT * FROM PRODUCT;

END;

INSRT_DATA_PR 'DELL G15 15.6 INCH LAPTOP', '87000', 'S0001';
INSRT_DATA_PR 'LENOVO THINKPAD 13 INCH LAPTOP', '94000', 'S0001';
INSRT_DATA_PR 'LG 28L MICROWAVE', '19900', 'S0002';
INSRT_DATA_PR 'SAMSUNG 55 INCHES 4K TV', '58000', 'S0003';
INSRT_DATA_PR 'LG 83 INCHES C2 4K TV', '600000', 'S0003';
INSRT_DATA_PR 'REALME 11X 5G 128 GB RAM PHONE', '34000', 'S0001';
INSRT_DATA_PR 'BAJAJ JUVEL HAND BLENDER', '1500', 'S0002';
INSRT_DATA_PR 'PRESTIGE PIC16.0 INDUCTION COOKER', '2750', 'S0002';
INSRT_DATA_PR 'BOAT AVNATE BAR 600 SOUNDBAR', '2000', 'S0002';
INSRT_DATA_PR 'APPLE IPHONE 13 256 GB RAM', '56000', 'S0001';
INSRT_DATA_PR 'WHIRLPOOL 7.5 KG 5 STAR TOP LOADING', '15600', 'S0004';
INSRT_DATA_PR 'PHILIPS KERASHINE HAIR STRAIGHTNER', '1600', 'S0005';


CREATE SEQUENCE SEQ_2
AS INT
START WITH 1
INCREMENT BY 1;


CREATE PROCEDURE INSRT_DATA_ST (@SQ AS INT, @RL AS INT, @MQ AS INT)
AS
BEGIN

				DECLARE @I AS INT;
				DECLARE @ID AS CHAR(5);

				SET @I = (NEXT VALUE FOR SEQ_2);
				SET @ID = DBO.ID_CREATE('P',@I);


				INSERT INTO STOCK
				VALUES(@ID,@SQ,@RL,@MQ);

				SELECT * FROM STOCK;

END;


INSRT_DATA_ST '100','10','5';
INSRT_DATA_ST '100','10','5';
INSRT_DATA_ST '200','25','10';
INSRT_DATA_ST '150','10','5';
INSRT_DATA_ST '222','15','10';
INSRT_DATA_ST '120','10','5';
INSRT_DATA_ST '100','20','5';
INSRT_DATA_ST '125','10','5';
INSRT_DATA_ST '110','20','10';
INSRT_DATA_ST '150','30','10';
INSRT_DATA_ST '300','25','5';
INSRT_DATA_ST '250','15','10';


SELECT * FROM SUPPLIER;
SELECT * FROM PRODUCT;
SELECT * FROM STOCK;

CREATE SEQUENCE SEQ_3
AS INT
START WITH 1
INCREMENT BY 1;


CREATE PROCEDURE INSRT_DATA_CUST (@CN AS VARCHAR(30), @CAD AS VARCHAR(60), @CCY AS VARCHAR(20), @CPH AS CHAR(10),
									@DT AS DATE, @D AS VARCHAR(20))

AS
BEGIN

				DECLARE @I AS INT;
				DECLARE @ID AS CHAR(5);
				DECLARE @EM AS VARCHAR(60);
				DECLARE @LN AS INT;
				DECLARE @S AS INT;
				DECLARE @LL AS VARCHAR(2);


				SET @I = (NEXT VALUE FOR SEQ_3);
				SET @ID = DBO.ID_CREATE('C',@I);
				SET @LN = LEN(@CN);
				SET @S = CHARINDEX(' ',@CN);
				SET @LL = SUBSTRING(RIGHT(@CN,@LN-@S),1,2);
				SET @EM = CONCAT(LEFT(@CN,2),@LL,RIGHT(@ID,2),'@',@D,'.COM');

				INSERT INTO CUSTOMER
				VALUES(@ID,@CN,@CAD,@CCY,@CPH,@EM,@DT);

				SELECT * FROM CUSTOMER;

END;

INSRT_DATA_CUST 'AJAY MUTHUVEL','NEAR AASARIPALLAM MEDICAL COLLEGE','NAGERCOIL','9786567450','21 JANUARY 1998','GMAIL';
INSRT_DATA_CUST 'AKAASH KUMAR','KAVALKINARU','NAGERCOIL','8897800500','01 MARCH 1995','GMAIL';
INSRT_DATA_CUST 'MOHAMMED KAASIM','PAALPANNAI','CHENNAI','9943266980','10 APRIL 1982','YAHOO';
INSRT_DATA_CUST 'MANOJ DEEPAN','NUNGAMBAKAM','CHENNAI','9895621900','17 MAY 1997','OUTLOOK';
INSRT_DATA_CUST 'PRAVEEN SUBRAMANIAM','ORANGE APARTMENTS,NAVALUR','CHENNAI','9789564980','19 AUGUST 1992','YAHOO';

SELECT * FROM SUPPLIER;
SELECT * FROM PRODUCT;
SELECT * FROM STOCK;
SELECT * FROM CUSTOMER;

--CREATION OF VIEWS FOR RESTRICTING SOME DATAS :

CREATE VIEW CUST_DET
AS
	SELECT CID,CNAME,CCITY,CPHONE,CEMAIL FROM CUSTOMER;

SELECT * FROM CUST_DET;

--INSERTING ORDERS BY USING TRIGGERS :

CREATE TRIGGER TR_INS ON ORDERS
FOR INSERT
AS
BEGIN
			UPDATE STOCK SET SQTY = SQTY - (SELECT OQTY FROM INSERTED)
			WHERE PID = (SELECT PID FROM INSERTED);

END;

INSERT INTO ORDERS
VALUES('O0001','19 OCTOBER 2023','P0001','C0001',2);
INSERT INTO ORDERS
VALUES('O0002','20 OCTOBER 2023','P0001','C0002',10);
INSERT INTO ORDERS
VALUES('O0003','20 OCTOBER 2023','P0004','C0003',5);
INSERT INTO ORDERS
VALUES('O0004','25 OCTOBER 2023','P0002','C0001',10);
INSERT INTO ORDERS
VALUES('O0005', '26 OCTOBER 2023', 'P0010', 'C0003', 15);

SELECT * FROM ORDERS;
SELECT * FROM STOCK;

--UPDATING DATA USING TRIGGER :

CREATE TRIGGER TR_UPD ON ORDERS
FOR UPDATE
AS
BEGIN
		DECLARE @OQ AS INT;
		DECLARE @NQ AS INT;

		SET @OQ = (SELECT OQTY FROM DELETED);
		SET @NQ = (SELECT OQTY FROM INSERTED);

		UPDATE STOCK SET SQTY = SQTY + @OQ - @NQ
		WHERE PID = (SELECT PID FROM INSERTED);

END;

UPDATE ORDERS SET OQTY = '15'
WHERE OID = 'O0002';

SELECT * FROM ORDERS;
SELECT * FROM STOCK;

--ORDER PLACED WHEN THE STOCK IS AVAILABLE IF NOT, THE ORDERS ARE NOT PLACED :

CREATE TRIGGER TR_IN ON ORDERS
FOR INSERT
AS
BEGIN
			DECLARE @QR AS INT;
			DECLARE @QS AS INT;

			SET @QR = (SELECT OQTY FROM INSERTED);
			SET @QS = (SELECT SQTY FROM STOCK WHERE PID = (SELECT PID FROM INSERTED));

				IF @QS>=@QR
					BEGIN
						UPDATE STOCK SET SQTY = SQTY - @QR
						WHERE PID = (SELECT PID FROM INSERTED);
						
						COMMIT;

						PRINT ('ORDER ACCEPTED');
					END;
				ELSE
					BEGIN
						ROLLBACK;

						PRINT ('ORDER REJECTED - INSUFFICIENT BALANCE');
					END;
END;


INSERT INTO ORDERS
VALUES('O0006','27 OCTOBER 2023', 'P0003','C0004',100);
INSERT INTO ORDERS
VALUES('O0007','28 OCTOBER 2023', 'P0002','C0005',250);

INSERT INTO ORDERS
VALUES('O0007','28 OCTOBER 2023', 'P0002','C0005',50);

SELECT * FROM ORDERS;
SELECT * FROM STOCK;

--JOINING PRODUCT & SUPPLIER TABLE :

SELECT PRODUCT.PID,PRODUCT.PDESC,SUPPLIER.SNAME,SUPPLIER.SCITY FROM PRODUCT
INNER JOIN SUPPLIER
ON PRODUCT.SID = SUPPLIER.SID;

--JOINING ORDERS,PRODUCT & CUSTOMER TABLES :

SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER;
SELECT * FROM PRODUCT;


SELECT CUSTOMER.CNAME,CUSTOMER.CADD,CUSTOMER.CPHONE,ORDERS.OID,ORDERS.ODATE,PRODUCT.PDESC,PRODUCT.PRICE,
ORDERS.OQTY,PRICE*OQTY AS 'AMOUNT'
FROM CUSTOMER
INNER JOIN ORDERS
ON CUSTOMER.CID = ORDERS.CID
INNER JOIN PRODUCT
ON ORDERS.PID = PRODUCT.PID;

--CREATION OF VIEWS FOR SUMMARIZING THE DATAS :

CREATE VIEW INVENTORY_JOIN
AS
	SELECT C1.CNAME,CADD,CPHONE,O1.OID,ODATE,P1.PDESC,PRICE,OQTY,PRICE*OQTY AS 'AMOUNT'
	FROM CUSTOMER C1
	INNER JOIN ORDERS O1
	ON C1.CID = O1.CID
	INNER JOIN PRODUCT P1
	ON O1.PID = P1.PID;

SELECT * FROM INVENTORY_JOIN;
----------------------------------------------------------------------------------------------------------
SELECT * FROM PRODUCT;
SELECT * FROM STOCK;
SELECT * FROM SUPPLIER;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;





