-- Library Database
-- The following schema is used for the Library Database:

-- BOOK (Book_id, Title, Publisher_Name, Pub_Year)
-- BOOK_AUTHORS (Book_id, Author_Name)
-- PUBLISHER (Name, Address, Phone)
-- BOOK_COPIES (Book_id, Branch_id, No_of_Copies)
-- CARD (Card_No)
-- BOOK_LENDING (Book_id, Branch_id, Card_No, Date_Out, Due_Date)
-- LIBRARY_BRANCH (Branch_id, Branch_Name, Address)

-- SQL Queries
-- 1. Retrieve details of all books in the library.
-- 2. Get the particulars of borrowers who have borrowed more than 3 books, but from Jan 2017 to Jun2017
-- 3. Delete a book in BOOK table. Update the contents of other tables to reflect this data manipulation operation.
-- 4. Partition the BOOK table based on year of publication. Demonstrate its working with a simplequery.
-- 5. Create a view of all books and its number of copies that are currently available in the Library.

-- Creating database and using database
CREATE DATABASE LIBRARY;
USE LIBRARY;

-- Create Table for PUBLISHER
CREATE TABLE PUBLISHER (
    NAME VARCHAR(50) PRIMARY KEY,
    PHONE BIGINT,
    ADDRESS VARCHAR(100)
);

-- Describing from PUBLISHER Table
DESC PUBLISHER;

-- Create Table for BOOK
CREATE TABLE BOOK (
    BOOK_ID INT PRIMARY KEY,
    TITLE VARCHAR(100),
    PUB_YEAR YEAR,
    PUBLISHER_NAME VARCHAR(50),
    FOREIGN KEY (PUBLISHER_NAME) REFERENCES PUBLISHER(NAME) ON DELETE CASCADE
);

-- Describing from BOOK Table
DESC BOOK;

-- Create Table for BOOK_AUTHORS
CREATE TABLE BOOK_AUTHORS (
    BOOK_ID INT,
    AUTHOR_NAME VARCHAR(100),
    PRIMARY KEY (BOOK_ID, AUTHOR_NAME),
    FOREIGN KEY (BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE
);

-- Describing from BOOK_AUTHORS Table
DESC BOOK_AUTHORS;

-- Create Table for LIBRARY_BRANCH
CREATE TABLE LIBRARY_BRANCH (
    BRANCH_ID INT PRIMARY KEY,
    BRANCH_NAME VARCHAR(100),
    ADDRESS VARCHAR(100)
);

-- Describing from LIBRARY_BRANCH Table
DESC LIBRARY_BRANCH;

-- Create Table for BOOK_COPIES
CREATE TABLE BOOK_COPIES (
    BOOK_ID INT,
    BRANCH_ID INT,
    NO_OF_COPIES INT,
    PRIMARY KEY (BOOK_ID, BRANCH_ID),
    FOREIGN KEY (BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
    FOREIGN KEY (BRANCH_ID) REFERENCES LIBRARY_BRANCH(BRANCH_ID) ON DELETE CASCADE
);

-- Describing from BOOK_COPIES Table
DESC BOOK_COPIES;

-- Create Table for CARD
CREATE TABLE CARD (
    CARD_NO INT PRIMARY KEY
);

-- Describing from CARD Table
DESC CARD;

-- Create Table for BOOK_LENDING
CREATE TABLE BOOK_LENDING (
    BOOK_ID INT,
    BRANCH_ID INT,
    CARD_NO INT,
    DATE_OUT DATE,
    DUE_DATE DATE,
    PRIMARY KEY (BOOK_ID, BRANCH_ID, CARD_NO),
    FOREIGN KEY (BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
    FOREIGN KEY (BRANCH_ID) REFERENCES LIBRARY_BRANCH(BRANCH_ID) ON DELETE CASCADE,
    FOREIGN KEY (CARD_NO) REFERENCES CARD(CARD_NO) ON DELETE CASCADE
);

-- Describing from BOOK_LENDING Table
DESC BOOK_LENDING;

-- showing tables
SHOW TABLES;

-- Insert Data into Publisher Table
INSERT INTO PUBLISHER VALUES 
('MCGRAW-HILL', 9989076587, 'BANGALORE'),
('PEARSON', 9889076565, 'NEW DELHI'),
('RANDOM HOUSE', 7455679345, 'HYDERABAD'),
('HACHETTE LIVRE', 8970862340, 'CHENNAI'),
('GRUPO PLANETA', 7756120238, 'BANGALORE');

-- Selecting all from Publisher Table
SELECT * FROM PUBLISHER;

-- Insert Data into Book Table
INSERT INTO BOOK VALUES 
(1, 'DBMS', 2017, 'MCGRAW-HILL'),
(2, 'ADBMS', 2016, 'MCGRAW-HILL'),
(3, 'CN', 2016, 'PEARSON'),
(4, 'CG', 2015, 'GRUPO PLANETA'),
(5, 'OS', 2016, 'PEARSON');

-- Selecting all from Book Table
SELECT * FROM BOOK;

-- Insert Data into Book Authors Table
INSERT INTO BOOK_AUTHORS VALUES 
(1, 'NAVATHE'),
(2, 'NAVATHE'),
(3, 'TANENBAUM'),
(4, 'EDWARD ANGEL'),
(5, 'GALVIN');

-- Selecting all from Book Authors Table
SELECT * FROM BOOK_AUTHORS;

-- Insert Data into Library Branch Table
INSERT INTO LIBRARY_BRANCH VALUES 
(10, 'RR NAGAR', 'BANGALORE'),
(11, 'RNSIT', 'BANGALORE'),
(12, 'RAJAJI NAGAR', 'BANGALORE'),
(13, 'NITTE', 'MANGALORE'),
(14, 'MANIPAL', 'UDUPI');

-- Selecting all from Library Branch Table
SELECT * FROM LIBRARY_BRANCH;

-- Insert Data into Book Copies Table
INSERT INTO BOOK_COPIES VALUES 
(1, 10, 10),
(1, 11, 5),
(2, 12, 2),
(2, 13, 5),
(3, 14, 7),
(5, 10, 1),
(4, 11, 3);

-- Selecting all from Book Copies Table
SELECT * FROM BOOK_COPIES;

-- Insert Data into Card Table
INSERT INTO CARD VALUES (100), (101), (102), (103), (104);

-- Selecting all from Card Table
SELECT * FROM CARD;

-- Insert Data into Book Lending Table
INSERT INTO BOOK_LENDING VALUES 
(1, 10, 101, '2017-01-01', '2017-06-01'),
(3, 14, 101, '2017-01-11', '2017-03-11'),
(2, 13, 101, '2017-02-21', '2017-04-21'),
(4, 11, 101, '2017-03-15', '2017-07-15'),
(1, 11, 104, '2017-04-12', '2017-05-12');

-- Selecting all from Book Lending Table
SELECT * FROM BOOK_LENDING;

-- 1. Retrieve details of all books in the library
SELECT 
    B.BOOK_ID, 
    B.TITLE, 
    B.PUBLISHER_NAME, 
    A.AUTHOR_NAME, 
    C.NO_OF_COPIES, 
    L.BRANCH_ID, 
    L.BRANCH_NAME, 
    L.ADDRESS
FROM BOOK B
LEFT JOIN BOOK_AUTHORS A ON B.BOOK_ID = A.BOOK_ID
LEFT JOIN BOOK_COPIES C ON B.BOOK_ID = C.BOOK_ID
LEFT JOIN LIBRARY_BRANCH L ON C.BRANCH_ID = L.BRANCH_ID;

-- 2. Get the particulars of borrowers who have borrowed more than 3 books from Jan 2017 to Jun 2017
SELECT CARD_NO 
FROM BOOK_LENDING
WHERE DATE_OUT BETWEEN '2017-01-01' AND '2017-06-30'
GROUP BY CARD_NO
HAVING COUNT(*) > 3;

-- 3. Delete a book from the BOOK table and update related tables
SELECT * FROM BOOK;
SELECT * FROM BOOK_AUTHORS;
SELECT * FROM BOOK_COPIES;
SELECT * FROM BOOK_LENDING;
DELETE FROM BOOK WHERE BOOK_ID = 3;
-- ON DELETE CASCADE will automatically delete related records
SELECT * FROM BOOK;
SELECT * FROM BOOK_AUTHORS;
SELECT * FROM BOOK_COPIES;
SELECT * FROM BOOK_LENDING;

-- 4. Partition the BOOK table based on year of publication
CREATE TABLE BOOK_PARTITIONED (
    BOOK_ID INT,
    PUB_YEAR YEAR,
    PRIMARY KEY (BOOK_ID, PUB_YEAR)
) 
PARTITION BY RANGE (PUB_YEAR) (
    PARTITION p1 VALUES LESS THAN (2010),
    PARTITION p2 VALUES LESS THAN (2015),
    PARTITION p3 VALUES LESS THAN (2020),
    PARTITION p4 VALUES LESS THAN (2030)
);

INSERT INTO BOOK_PARTITIONED (BOOK_ID, PUB_YEAR) VALUES 
(1, 2005),  -- Goes into p1 (Less than 2010)
(2, 2012),  -- Goes into p2 (Less than 2015)
(3, 2018),  -- Goes into p3 (Less than 2020)
(4, 2025);  -- Goes into p4 (Less than 2030)

-- Demonstrate partitioned query (fetching books published after 2016)
SELECT * FROM BOOK_PARTITIONED WHERE PUB_YEAR >= 2016;

SELECT * FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'BOOK_PARTITIONED';

-- 5. Create a view of all books and their number of copies currently available in the Library
CREATE VIEW VIEW_BOOKS_AVAILABLE AS
SELECT 
    B.BOOK_ID, 
    B.TITLE, 
    SUM(C.NO_OF_COPIES) AS TOTAL_COPIES
FROM BOOK B
JOIN BOOK_COPIES C ON B.BOOK_ID = C.BOOK_ID
GROUP BY B.BOOK_ID, B.TITLE;

SELECT * FROM VIEW_BOOKS_AVAILABLE;

-- Deleting Database
DROP DATABASE LIBRARY;
