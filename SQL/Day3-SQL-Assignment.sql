SELECT * FROM BOOKS;
--1)	List the various categories and count of books in each category.
SELECT COUNT(*),CATEGORY FROM BOOKS GROUP BY CATEGORY;
-- 2)	List the book_No and the number of times the book is issued in the descending order of count.
SELECT BOOK_NO,COUNT(*) FROM ISSUE GROUP BY BOOK_NO ORDER BY COUNT(*) DESC;
-- 3)	Find the maximum, minimum, total and average penalty amount in the member table.\
SELECT MAX(PENALTY_AMOUNT),MIN(PENALTY_AMOUNT),SUM(PENALTY_AMOUNT),AVG(PENALTY_AMOUNT) FROM MEMBER;
-- 4)	Display the member id and the no of books for each member that has issued more then 2 books.
SELECT MEMBER_ID,COUNT(*) FROM ISSUE GROUP BY MEMBER_ID HAVING COUNT(*)>2;
-- 5)	Display the member id, book no and no of times the same book is issued by the member in the descending order of count.
SELECT BOOK_NO,MEMBER_ID,COUNT(*) FROM ISSUE GROUP BY BOOK_NO,MEMBER_ID ORDER BY COUNT(*) DESC;
-- 6)	Display the month and no of books issued each month in the descending order of count.
SELECT TO_CHAR(ISSUE_DATE, 'MON-YYYY') AS ISSUE_MONTH, COUNT(*) AS TIMES_ISSUED
FROM ISSUE
GROUP BY TO_CHAR(ISSUE_DATE, 'MON-YYYY')
ORDER BY COUNT(*) DESC;
-- 7)	  List the book_no of all the books that are not issued to any  
-- member so far. 
SELECT BOOK_NO FROM BOOKS
MINUS
SELECT BOOK_NO FROM ISSUE;
-- 8)	List all the member id that exist in member table and has also at least one book issued by them. \
SELECT * FROM BOOKS,MEMBER WHERE BOOK_NO=MEMBER_ID(+);
-- 9)	List the member ID with highest and lowest no of books issued. 
SELECT * FROM(SELECT MEMBER_ID,COUNT(*) FROM ISSUE GROUP BY MEMBER_ID ORDER BY COUNT(*) DESC) WHERE ROWNUM=1 ;
SELECT * FROM(SELECT MEMBER_ID,COUNT(*) FROM ISSUE GROUP BY MEMBER_ID ORDER BY COUNT(*) ASC) WHERE ROWNUM=1;
-- 10)	List all the Issue_details for books issued in December and July without using any arithmetic, Logical or comparison operator.
-- 11)	 List the Book_No, Book_Name and Issue_date for all the books that are issued in month of December and belong to category Database.
SELECT * FROM ISSUE;
SELECT B.BOOK_NO,B.BOOK_NAME ,I.ISSUE_DATE ,B.CATEGORY FROM BOOKS B INNER JOIN ISSUE I ON B.BOOK_NO=I.BOOK_NO WHERE B.CATEGORY='DATABASE' AND TO_CHAR(I.ISSUE_DATE,'MON') = 'DEC';
-- 12)	 List the Member Id, Member Name and No of books Issued in the descending order of the count.

SELECT M.MEMBER_ID,M.MEMBER_NAME,COUNT(*) AS BOOKS_ISSUED FROM MEMBER M JOIN ISSUE I ON I.MEMBER_ID=M.MEMBER_ID GROUP BY M.MEMBER_ID,M.MEMBER_NAME ORDER BY COUNT(*) DESC;
-- 13)	List the Book No, Book Name, Issue_date and Return_Date for all the books issued by Richa Sharma.
SELECT B.BOOK_NO,B.BOOK_NAME,I.ISSUE_DATE,I.RETURN_DATE FROM BOOKS B JOIN ISSUE I ON B.BOOK_NO = I.BOOK_NO WHERE I.MEMBER_ID =(SELECT MEMBER_ID FROM MEMBER WHERE MEMBER_NAME = 'RICHA SHARMA');
-- 14)	List the details of all the members that have issued books in Database category.
SELECT M.* FROM MEMBER M JOIN ISSUE I ON M.MEMBER_ID=I.MEMBER_ID JOIN BOOKS B ON B.BOOK_NO = I.BOOK_NO WHERE CATEGORY='DATABASE';

-- 15)	List all the books that have highest price in their own category.
SELECT * FROM BOOKS;
SELECT CATEGORY,COST FROM BOOKS GROUP BY CATEGORY,COST ;

-- 16)	List all the Issue_Details where Issue_date is not within the Acc_open_date and Return_date for that member.
-- 17)	List all the members that have not issued a single book so far.
-- 18)	List all the Members where No of books Issued exceeds the Max No of books allowed.
SELECT M.* FROM MEMBER M JOIN ISSUE I ON M.MEMBER_ID=I.MEMBER_ID WHERE 
SELECT MEMBER_ID,COUNT(*) FROM ISSUE GROUP BY MEMBER_ID;
-- 19)	List all the members that have issued the same book as issued by Garima.

-- 20)	List the Book_Name, Price of all the books that are not returned for more then 30 days.
-- 21)	List all the authors and book_name that has more then 1 book written by them.

-- 22)	List the Member ID, Member Name of the people that have issued the highest and the lowest no of books.
SELECT MEMBER_ID,MEMBER_NAME FROM MEMBER WHERE MEMBER_ID=
    (SELECT MEMBER_ID FROM ISSUE GROUP BY MEMBER_ID ORDER BY COUNT(*) DESC FETCH FIRST 1 ROW ONLY);
SELECT MEMBER_ID,MEMBER_NAME FROM MEMBER WHERE MEMBER_ID=
    (SELECT MEMBER_ID FROM ISSUE GROUP BY MEMBER_ID ORDER BY COUNT(*) ASC FETCH FIRST 1 ROW ONLY);
-- 23)	List the details of highest 3 priced books.
SELECT * FROM BOOKS ORDER BY COST DESC FETCH FIRST 3 ROW ONLY;
-- 24)	List the total cost of all the books that are currently issued but not returned.
SELECT * FROM ISSUE;
SELECT SUM(B.COST) FROM BOOKS B INNER JOIN ISSUE I ON B.BOOK_NO=I.BOOK_NO WHERE I.RETURN_DATE IS NULL;
-- 25)	List the details of the book that has been issued maximum no of times.
SELECT BOOKS.BOOK_NO,BOOKS.BOOK_NAME,COUNT(*) FROM BOOKS INNER JOIN ISSUE 
ON BOOKS.BOOK_NO = ISSUE.BOOK_NO GROUP BY BOOKS.BOOK_NO,BOOKS.BOOK_NAME ORDER BY COUNT(*) DESC FETCH FIRST 1 ROW ONLY;

SELECT * FROM BOOKS WHERE BOOK_NO = 
(SELECT BOOK_NO FROM ISSUE GROUP BY BOOK_NO ORDER BY COUNT(*) DESC FETCH FIRST 1 ROW ONLY);
-- 26)	List how many books are issued to lifetime members.
SELECT MEMBERSHIP_TYPE,COUNT(*) AS COUNT FROM MEMBER GROUP BY MEMBERSHIP_TYPE HAVING MEMBERSHIP_TYPE='LIFETIME';
-- 27)	List all member types and how many members are there in each type.
SELECT MEMBERSHIP_TYPE,COUNT(*) AS COUNT FROM MEMBER GROUP BY MEMBERSHIP_TYPE;
-- 28)         Find out top 5 members, with their membership type, who have issued books maximum number of times.
--     29)          List top 3 members from each member type who have issued books maximum number of times.
--     30)          List first 5 members who had joined library.
--     31)          List the members with their member type, who have issued books during the period 1st December to 31st December.
--     32)          List all the members who have not returned books yet. 
--     33)          List all the members who joined library on the same date Garima joined.
--     34)          List all the members who has issued books from author “Loni” in the month of December
--     35)          List names of the authors whose books are least issued by lifetime members.
SELECT * FROM MEMBER;
SELECT * FROM ISSUE;
SELECT * FROM BOOKS;
--     36)          List top 3 authors whose books are issued by half yearly members

--     37)          List top 5 books which are issued by Annual members
--     38)          List the names of members who has issued the books whose cost is more than 300 rupees and whose author is “Scott Urman”
--     39)          Write a query to display number of booked in each category of books issued by all member types
--                    Display output as follows
                         Member Type            Book Category              Count
                         ---------------          ------------------            --------
                        Annual                       Science                          10
                        Annual                       Fiction                            5
                        Half yearly                  Science                          4
                             .                                .                                .
                             .                                .                                .
40)	List all lifetime members who joined library during 1st January 2006 to 31st December 2006 but issued only one book.