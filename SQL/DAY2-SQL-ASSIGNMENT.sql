DROP TABLE MEMBER;
DROP TABLE BOOKS;
DROP TABLE ISSUE;
CREATE TABLE MEMBER (
    MEMBER_ID NUMBER(5) PRIMARY KEY,
    MEMBER_NAME VARCHAR2(30),
    MEMBER_ADDRESS VARCHAR2(50),
    ACC_OPEN_DATE DATE ,
    Membership_type VARCHAR2(20),
    FEES_PAID NUMBER(4),
    MAX_BOX_ALLOWED NUMBER(2),
    PENALTY_AMOUNT NUMBER(7,2)
);

CREATE TABLE BOOKS(
    BOOK_NO NUMBER(6) PRIMARY KEY,
    BOOK_NAME VARCHAR2(30) NOT NULL,
    AUTHOUR_NAME VARCHAR2(30),
    COST NUMBER(7,2),
    CATEGORY CHAR(10)
);

CREATE TABLE ISSUE(
    LIB_ISSUE_ID NUMBER(10),
    BOOK_NO NUMBER(6),
    MEMBER_ID NUMBER(5),
    ISSUE_DATE DATE,
    RETURN_DATE DATE,
    FOREIGN KEY(BOOK_NO) REFERENCES BOOKS(BOOK_NO),
    FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);

-- MEMBERS
INSERT INTO MEMBER VALUES (101, 'Rina Gupta', 'Mumbai', DATE '2006-01-15', 'Premium', 1200, 5, 250.50);
INSERT INTO MEMBER VALUES (102, 'Girish Rana', 'Delhi', DATE '2006-03-20', 'Basic', 800, 3, 100.00);
INSERT INTO MEMBER VALUES (103, 'Rajesh Iyer', 'Pune', DATE '2005-12-10', 'Premium', 1500, 6, 0.00);
INSERT INTO MEMBER VALUES (104, 'Ganesh Patil', 'Nagpur', DATE '2006-07-05', 'Standard', 1000, 4, 300.00);
INSERT INTO MEMBER VALUES (105, 'Loni Mehta', 'Chennai', DATE '2007-02-28', 'Basic', 600, 2, 50.00);

-- BOOKS
INSERT INTO BOOKS VALUES (2001, 'SQL Basics', 'Loni', 550.00, 'Database');
INSERT INTO BOOKS VALUES (2002, 'Advanced SQL', 'Loni', 750.00, 'Database');
INSERT INTO BOOKS VALUES (2003, 'Science Wonders', 'Kiran', 500.00, 'Science');
INSERT INTO BOOKS VALUES (2004, 'Fiction Tales', 'Ravi', 650.00, 'Fiction');
INSERT INTO BOOKS VALUES (2005, 'DBMS Concepts', 'Loni', 590.00, 'Database');
INSERT INTO BOOKS VALUES (2006, 'Management 101', 'Anil', 800.00, 'Management');
INSERT INTO BOOKS VALUES (2007, 'SQL Performance', 'Soni', 1200.00, 'Database');
INSERT INTO BOOKS VALUES (2008, 'Organic Science', 'Loni', 450.00, 'Science');

-- ISSUE
INSERT INTO ISSUE VALUES (7001, 2001, 101, DATE '2006-07-10', NULL);
INSERT INTO ISSUE VALUES (7002, 2002, 101, DATE '2006-07-15', DATE '2006-08-20');
INSERT INTO ISSUE VALUES (7003, 2003, 102, DATE '2006-08-01', NULL);
INSERT INTO ISSUE VALUES (7004, 2004, 103, DATE '2006-05-20', DATE '2006-06-25');
INSERT INTO ISSUE VALUES (7005, 2005, 104, DATE '2006-09-01', NULL);
INSERT INTO ISSUE VALUES (7006, 2006, 105, DATE '2006-09-05', NULL);
INSERT INTO ISSUE VALUES (7007, 2007, 101, DATE '2006-08-10', DATE '2006-09-20');
INSERT INTO ISSUE VALUES (7008, 2008, 102, DATE '2006-06-15', NULL);

SELECT * FROM MEMBER;
SELECT * FROM BOOKS;
SELECT * FROM ISSUE;

-- 1)	List all the books that are written by Author Loni and has price  
-- 		less then 600.
SELECT * FROM BOOKS WHERE COST<600 AND AUTHOUR_NAME= 'LONI';

--2)	List the Issue details for the books that are not returned yet.
SELECT * FROM ISSUE WHERE RETURN_DATE IS NULL;
-- 3)	Update all the blank return_date with 31-Dec-06 excluding 7005 and 7006.

UPDATE ISSUE SET RETURN_DATE = TO_DATE('31-DEC-2006','DD-MON-YYYY') WHERE LIB_ISSUE_ID NOT IN(7005,7006) AND RETURN_DATE IS NULL;

-- 4)	List all the Issue details that have books issued for more then 30 days.
SELECT * FROM ISSUE WHERE ISSUE_DATE+30 < RETURN_DATE ;
-- 5)	List all the books that have price in range of 500 to 750 and has category as Database.

SELECT * FROM (SELECT * FROM BOOKS WHERE UPPER(TRIM(CATEGORY)) = 'DATABASE') WHERE COST BETWEEN 500 AND 750;
-- 6)	List all the books that belong to any one of the following categories Science, Database, Fiction, Management.
SELECT * FROM BOOKS WHERE UPPER(TRIM(CATEGORY)) IN ('DATABASE','SCIENCE','FICTION','MANAGEMENT');
-- 7)	List all the members in the descending order of Penalty due on them.
SELECT * FROM MEMBER ORDER BY PENALTY_AMOUNT DESC;
-- 8)	List all the books in ascending order of category and descending order of price.
SELECT * FROM BOOKS ORDER BY CATEGORY ASC, COST DESC;
-- 9)	List all the books that contain word SQL in the name of the book.
SELECT * FROM BOOKS WHERE BOOK_NAME LIKE '%SQL%';
-- 10)	List all the members whose name starts with R or G and contains letter I in it.
SELECT * FROM MEMBER WHERE MEMBER_NAME LIKE 'R%I%' OR MEMBER_NAME LIKE 'G%I%';
-- 11)	List the entire book name in Init cap and author in upper case in the descending order of the book name.
SELECT INITCAP(BOOK_NAME) AS BOOK_NAME,
       UPPER(AUTHOUR_NAME) AS AUTHOR_NAME
FROM BOOKS
ORDER BY BOOK_NAME DESC;
-- 12)	List the Issue Details for all the books issue by member 101  
-- with Issue_date and Return Date in following format. ‘Monday, 
-- July, 10, 2006’.
-- SELECT * FROM ISSUE WHERE MEMBER_ID = 101;
SELECT LIB_ISSUE_ID,
       BOOK_NO,
       MEMBER_ID,
       TO_CHAR(ISSUE_DATE, 'Day, Month, DD, YYYY') AS ISSUE_DATE,
       TO_CHAR(RETURN_DATE, 'Day, Month, DD, YYYY') AS RETURN_DATE
FROM ISSUE
WHERE MEMBER_ID = 101;

-- 13)	List the data in the book table with category data displayed as  
-- 	D for Database, S for Science, R for RDBMS and O for all the  
-- others.
SELECT * FROM BOOKS;
SELECT BOOK_NO,BOOK_NAME,AUTHOUR_NAME,COST,
    CASE
        WHEN UPPER(TRIM(CATEGORY)) = 'DATABASE' THEN 'D'
        WHEN UPPER(TRIM(CATEGORY)) = 'SCIENCE' THEN 'S'
        WHEN UPPER(TRIM(CATEGORY)) = 'FICTION' THEN 'F'
        ELSE '0'
    END AS CATEGORY_CODE FROM BOOKS;
-- 14)	List all the members that became the member in the year 2006.
SELECT * FROM MEMBER WHERE TO_CHAR(ACC_OPEN_DATE,'YYYY')= '2006' ;
-- 15)	List the Lib_Issue_Id, Issue_Date, Return_Date and No of days 
-- Book was issued.
SELECT Lib_Issue_Id, Issue_Date, Return_Date,(RETURN_DATE-ISSUE_DATE) AS NO_OF_DAYS FROM ISSUE;
-- 16)	Find the details of the member of the Library in the order of their 
-- joining the library.
SELECT * FROM MEMBER ORDER BY ACC_OPEN_DATE;
-- 17)	Display the count of total no of books issued to Member 101.
SELECT COUNT(*) FROM ISSUE WHERE MEMBER_ID=101;
-- 18)	Display the total penalty due for all the members.
SELECT SUM(PENALTY_AMOUNT) FROM MEMBER;
-- 19)	Display the total no of members 
SELECT COUNT(*) FROM MEMBER;
-- 20)	Display the total no of books issued 
SELECT COUNT(*) FROM ISSUE;
-- 21)	Display the average membership fees paid by all the members
SELECT AVG(FEES_PAID) FROM MEMBER;
-- 22)	Display no of months between issue date and return date for all issue
SELECT ISSUE_DATE,RETURN_DATE,MONTHS_BETWEEN(RETURN_DATE,ISSUE_DATE)AS NO_OF_MONTHS FROM ISSUE;

-- 23)	Display the length of member’s name
SELECT MEMBER_NAME,LENGTH(MEMBER_NAME) FROM MEMBER;
-- 24)	Display the first 5 characters of  membership_type for all members
SELECT MEMBER_NAME,
       SUBSTR(Membership_type, 1, 5) AS Membership_Abbrev
FROM MEMBER;

-- 25)	Display the last day of the month of issue date 
SELECT ISSUE_DATE,LAST_DAY(ISSUE_DATE) AS LAST_DAY FROM ISSUE