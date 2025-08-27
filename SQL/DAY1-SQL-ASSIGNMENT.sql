DROP TABLE MEMBER;
DROP TABLE BOOKS;
DROP TABLE ISSUE;

--1)	Create the table Member, Books and Issue without any constraints as mentioned in the schema description above.
CREATE TABLE MEMBER(
    MEMBER_ID NUMBER(5),
    MEMBER_NAME VARCHAR2(30),
    MEMBER_ADDRESS VARCHAR2(50),
    ACC_OPEN_DATE DATE,
    MEMBERSHIP_TYPE VARCHAR2(20) ,
    FEES_PAID NUMBER(4),
    MAX_BOOS_ALLOWED NUMBER(2),
    PENALTY_AMOUNT NUMBER(7,2)
)

CREATE TABLE BOOKS(
    BOOK_NO NUMBER(6),
    BOOK_NAME VARCHAR2(30) ,
    AUTHOUR_NAME VARCHAR2(30),
    COST NUMBER(7,2),
    CATEGORY CHAR(10)
);

CREATE TABLE ISSUE(
    LIB_ISSUE_ID NUMBER(10),
    BOOK_NO NUMBER(6),
    MEMBER_ID NUMBER(5),
    ISSUE_DATE DATE,
    RETURN_DATE DATE
);

--2)	View the structure of the tables.
DESC MEMBER;
DESC BOOKS;
DESC ISSUE;

--3)	Drop the Member table
DROP TABLE MEMBER;

--4)	Create the table Member again as per the schema description with the following constraints.
CREATE TABLE MEMBER (
    MEMBER_ID NUMBER(5) PRIMARY KEY ,
    MEMBER_NAME VARCHAR2(30),
    MEMBER_ADDRESS VARCHAR2(50),
    ACC_OPEN_DATE DATE,
    MEMBERSHIP_TYPE VARCHAR2(20) CHECK( MEMBERSHIP_TYPE IN('LIFETIME','ANNUAL','HALF YEARLY','QUARTERLY')),
    FEES_PAID NUMBER(4),
    MAX_BOOS_ALLOWED NUMBER(2),
    PENALTY_AMOUNT NUMBER(7,2)
)

-- 5)	Modify the table Member increase the width of the member name to 30 characters.
ALTER TABLE MEMBER MODIFY MEMBER_NAME VARCHAR2(30);


--6)	Add a column named as Reference of Char(30) to Issue table.
ALTER TABLE ISSUE ADD REFERENCE CHAR(30);

--7)	Delete/Drop the column Reference from Issue.
ALTER TABLE ISSUE DROP COLUMN REFERENCE;

--8. RENAME THE TABLE ISSUE TO LIB_ISSUE
RENAME ISSUE TO LIB_ISSUE;

-- 9.INSERT THE DATA IN MEMBER TABLE
INSERT INTO MEMBER VALUES(1,'RICHA SHARMA','PUNE',TO_DATE('10-DEC-2005','DD-MON-YYYY'),'LIFETIME',2500,5,50);
INSERT INTO MEMBER VALUES(2,'GARIMA SEN','PUNE',CURRENT_DATE,'ANNUAL',1000,3,NULL);

SELECT CURRENT_DATE FROM DUAL;

--10.INSERT 5 RECORDS WITH SUITABLE DATA AND SAVE IT
INSERT INTO MEMBER VALUES(3,'REENA SHARMA','MUMBAI',TO_DATE('15-DEC-07','DD-MON-YYYY'),'LIFETIME',9500,5,50);
INSERT INTO MEMBER VALUES(4,'POOJA SEN','PUNE',TO_DATE('28-NOV-03','DD-MON-YYYY'),'QUARTERLY',800,3,NULL);
INSERT INTO MEMBER VALUES(5,'RAHUL VERMA','DELHI',TO_DATE('10-JAN-12','DD-MON-YYYY'),'ANNUAL',5000,2,20);
INSERT INTO MEMBER VALUES(6,'ANITA KAPOOR','NAGPUR',TO_DATE('05-MAY-15','DD-MON-YYYY'),'HALF YEARLY',2500,4,30);
INSERT INTO MEMBER VALUES(7,'SUNIL JOSHI','CHENNAI',TO_DATE('22-AUG-20','DD-MON-YYYY'),'LIFETIME',1000,6,60);

SELECT * FROM MEMBER;

--11. Modify the column Member_name. Decrease the width of the member  name to 20 characters. (If it does not allow state the reason for that)

ALTER TABLE MEMBER MODIFY MEMBER_NAME VARCHAR2(20);

--12)	Try to insert a record with Max_Books_Allowed = 110, Observe   the error that comes. Report the reason for this error.
INSERT INTO MEMBER VALUES(8,'GAYTRI THAKRE','NAGPUR',29-NOV-2003,'ANNUAL',2000,110,80);
--LIMIT EXCEEDED

--13)	Generate another table named Member101 using a Create command along with a simple SQL query on member table.
CREATE TABLE MEMBER101 AS SELECT * FROM MEMBER WHERE 1=0;
DESC MEMBER101;
SELECT * FROM MEMBER101;
--14)	Add the constraints on columns max_books_allowed  and penalty_amt as follows
--a.	max_books_allowed  < 100
--b.	penalty_amt maximum 1000
 --     Also give names to the constraints.

ALTER TABLE MEMBER RENAME COLUMN MAX_BOOS_ALLOWED TO MAX_BOOKS_ALLOWED;
ALTER TABLE MEMBER ADD CONSTRAINT CHECK_MAX CHECK (MAX_BOOKS_ALLOWED<100);
ALTER TABLE MEMBER ADD CONSTRAINT CHK_PENALTY CHECK (PENALTY_AMOUNT<=1000);
--15)	Drop the table books.
DROP TABLE BOOKS;

--16. CREATE BOOKS TABLE AGAIN
CREATE TABLE BOOKS(
    BOOK_NO NUMBER(6) PRIMARY KEY,
    BOOK_NAME VARCHAR2(30) NOT NULL,
    AUTHOR_NAME VARCHAR2(30),
    COST NUMBER(7,2),
    CATEGORY CHAR(10) CHECK(CATEGORY IN('SCIENCE','FICTION','DATABASE','RDBMS','OTHERS'))

);

-- 17.INSERT DATA IN BOOK TABLE

INSERT INTO BOOKS VALUES(101,'Let us C','Denis Ritchie',450,'OTHERS');
INSERT INTO BOOKS VALUES(102,'Oracle – Complete Ref','Loni',550,'DATABASE');
INSERT INTO BOOKS VALUES(103,'Mastering SQL','Loni',250,'DATABASE');
INSERT INTO BOOKS VALUES(104,'PL SQL-Ref','Scott Urman',750,'DATABASE');

SELECT * FROM BOOKS;

-- 18)	Insert more records in Book table using & operator in the insert statement.

INSERT INTO BOOKS (BOOK_NO, BOOK_NAME, AUTHOR_NAME, COST, CATEGORY)
VALUES (&BOOK_NO, '&BOOK_NAME', '&AUTHOR_NAME', &COST, '&CATEGORY');


-- 19.BOOK101 SIMILAR RO BOOK
CREATE TABLE BOOK101 AS SELECT * FROM BOOKS WHERE 1=0;
DESC BOOK101;

--20)	Insert into Book101 all the data in Book table using Select Statement.
INSERT INTO BOOK101 SELECT * FROM BOOKS;

--21)	Save all the data so far inserted in the tables.
COMMIT;
--22)	View the data in the tables using simple SQL query.
SELECT TABLE_NAME FROM USER_TABLES;
-- 23)	Insert into Book following data.
SELECT * FROM BOOKS;
INSERT INTO BOOKS VALUES(106,'NATIONAL GEOGRAPHIC','ADIS SCOTT',1000,'SCIENCE');
--CONSTRAINT VIOLETED
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,search_condition FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME = 'SYS_C003249950' AND CONSTRAINT_TYPE='C';
--24)	 Undo the last changes.
ROLLBACK;
-- 25)	Modify the price of book with id 103 to Rs 300 and category to 
-- RDBMS.
UPDATE BOOKS SET COST=300 WHERE BOOK_NO=103;
SELECT * FROM BOOKS;

-- 26)	Rename the table Lib_Issue to Issue.
RENAME LIB_ISSUE TO ISSUE;
-- 27)	Drop table Issue.
DROP TABLE ISSUE;
-- 28)	As per the given structure Create table Issue again with following constraints.
-- 	Lib_Issue_Id-Primary key
-- 	Book_No-  foreign key
-- 	Member_id - foreign key
-- 	Issue_date < Return_date
CREATE TABLE ISSUE(
    LIB_ISSUE_ID NUMBER(10) PRIMARY KEY,
    BOOK_NO NUMBER(6),
    MEMBER_ID NUMBER(5),
    ISSUE_DATE DATE,
    RETURN_DATE DATE,
    FOREIGN KEY (BOOK_NO) REFERENCES BOOKS(BOOK_NO),
    FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);


--29)	 Insert following data into Issue table. Note leave the column 

INSERT INTO ISSUE VALUES(7001,	101,	1,	TO_DATE('10-Dec-06','DD-MON-YYY'),NULL);
INSERT INTO ISSUE
VALUES (7002, 102, 2, TO_DATE('25-DEC-2006','DD-MON-YYYY'), NULL);

INSERT INTO ISSUE
VALUES (7003, 104, 1, TO_DATE('15-JAN-2006','DD-MON-YYYY'), NULL);

INSERT INTO ISSUE
VALUES (7004, 101, 1, TO_DATE('04-JUL-2006','DD-MON-YYYY'), NULL);

INSERT INTO ISSUE
VALUES (7005, 104, 2, TO_DATE('15-NOV-2006','DD-MON-YYYY'), NULL);

INSERT INTO ISSUE
VALUES (7006, 101, 3, TO_DATE('18-FEB-2006','DD-MON-YYYY'), NULL);

--30)	Save the data.
COMMIT;

--31)	Disable the constraints on Issue table
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'ISSUE';
ALTER TABLE ISSUE DISABLE CONSTRAINT SYS_C003250244;

-- 32)	Insert a record in Issue table. The member_id should not exist in 
-- member table.
INSERT INTO ISSUE VALUES(7008,104,90,TO_DATE('29-NOV-2003','DD-MON-YYYY'),NULL);
-- 33)	Now enable the constraints of Issue table. Observe the error
ALTER TABLE ISSUE ENABLE CONSTRAINT SYS_C003250244;
-- cannot validate (SQL_IBRTSSLGAUCOQI6PR16ASZC352.SYS_C003250244) - parent keys not found
-- 34)	Delete the record inserted at Q-32) and enable the constraints.
DELETE FROM ISSUE WHERE LIB_ISSUE_ID=7008;
-- 35)	Try to delete the record of member id 1 from member table and 
-- observe the error 
DELETE FROM MEMBER WHERE MEMBER_ID=1;
-- 36)	Modify the Return_Date of 7004,7005 to 15 days after the   
-- Issue_date.
UPDATE ISSUE SET RETURN_DATE=ISSUE_DATE+15 WHERE LIB_ISSUE_ID IN (7004,7005);
SELECT * FROM ISSUE;
-- 37)	Modify the Penalty_Amount for Garima Sen to Rs 100.
UPDATE MEMBER SET PENALTY_AMOUNT=100 WHERE MEMBER_NAME='GARIMA SEN';
SELECT * FROM MEMBER;
-- 38)	Perform a save point X here.
SAVEPOINT X;
-- 39)	Remove all the records from Issue table where member_ID is 1 
-- and Issue date in before 10-Dec-06.
DELETE FROM ISSUE WHERE MEMBER_ID=1 AND TRUNC(ISSUE_DATE) <=TO_DATE('10-DEC-2006','DD-MON-YYYY');
SELECT * FROM ISSUE;
-- 40)	Remove all the records from Book table with category other  
-- than RDBMS and Database.
DELETE FROM BOOKS WHERE CATEGORY NOT IN ('RDMS','DATABASE');
SELECT * FROM BOOKS;
-- 41)	Undo the changes done after savepoint X.
ROLLBACK;
-- 42)	Save all the changes done before X.
COMMIT;
-- 43)	Remove the table Member101.
DROP TABLE MEMBER101;
-- 44)	Remove the table Book101.
DROP TABLE BOOK101;
-- 45)	View the data and structure of all the three tables Member, 
-- Issue, Book.
SELECT TABLE_NAME FROM USER_TABLES;
SELECT * FROM MEMBER;
SELECT * FROM BOOKS;
SELECT * FROM ISSUE;
-- 46)	Create a sequence no_seq of even numbers starting with 100 
--          and ending with 200.
CREATE SEQUENCE NO_SEQ 
START WITH 100
INCREMENT BY 2
MINVALUE 100
MAXVALUE 200
NOCYCLE;

-- 47)	Drop the above created sequence.
DROP SEQUENCE NO_SEQ;
-- 48)	Create a sequence book_seq starting with 101 and ending with 1000
--        And increamented by 1 without cycle.
CREATE SEQUENCE book_seq
START WITH 101
INCREMENT BY 1
MINVALUE 101
MAXVALUE 1000
NOCYCLE;
-- 49)	Create a sequence member_seq starting with 1 and ending with 100
--        And increamented by 1 without cycle.
CREATE SEQUENCE member_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 100
NOCYCLE;