-- Order Database
-- The following schema is used for the Order Database:

-- SALESMAN (Salesman_id, Name, City, Commission)
-- CUSTOMER (Customer_id, Cust_Name, City, Grade, Salesman_id)
-- ORDERS (Ord_No, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)

-- SQL Queries
-- 1. Count the customers with grades above Bangalore’s average
-- 2. Find the name and numbers of all salesmen who had more than onecustomer.
-- 3. List all salesmen and indicate those who have and don’t have customers in their cities (Use UNION operation.)
-- 4. Create a view that finds the salesman who has the customer with the highest order of a day.
-- 5. Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.

-- Creating database and using database
CREATE DATABASE ORDERS;
USE ORDERS;

-- Create Table SALESMAN
CREATE TABLE SALESMAN (
    SALESMAN_ID INT PRIMARY KEY,
    NAME VARCHAR(20) NOT NULL,
    CITY VARCHAR(20) NOT NULL,
    COMMISSION VARCHAR(10) NOT NULL
);

-- Describing from SALESMAN Table
DESC SALESMAN;

-- Create Table CUSTOMER
CREATE TABLE CUSTOMER (
    CUSTOMER_ID INT PRIMARY KEY,
    CUST_NAME VARCHAR(20) NOT NULL,
    CITY VARCHAR(20) NOT NULL,
    GRADE INT CHECK (GRADE >= 0),
    SALESMAN_ID INT,
    FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID) ON DELETE SET NULL
);

-- Describing from CUSTOMER Table
DESC CUSTOMER;

-- Create Table ORDERS
CREATE TABLE ORDERS (
    ORD_NO INT PRIMARY KEY,
    PURCHASE_AMT DECIMAL(10,2) NOT NULL,
    ORD_DATE DATE NOT NULL,
    CUSTOMER_ID INT,
    SALESMAN_ID INT,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE,
    FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID) ON DELETE CASCADE
);

-- Describing from ORDERS Table
DESC ORDERS;

-- showing tables
SHOW TABLES;

-- Insert data into SALESMAN
INSERT INTO SALESMAN VALUES 
(1000, 'JOHN', 'BANGALORE', '25%'),
(2000, 'RAVI', 'BANGALORE', '20%'),
(3000, 'KUMAR', 'MYSORE', '15%'),
(4000, 'SMITH', 'DELHI', '30%'),
(5000, 'HARSHA', 'HYDERABAD', '15%');

-- Selecting all from SALESMAN Table
SELECT * FROM SALESMAN;

-- Insert data into CUSTOMER
INSERT INTO CUSTOMER VALUES 
(10, 'PREETHI', 'BANGALORE', 100, 1000),
(11, 'VIVEK', 'MANGALORE', 300, 1000),
(12, 'BHASKAR', 'CHENNAI', 400, 2000),
(13, 'CHETHAN', 'BANGALORE', 200, 2000),
(14, 'MAMATHA', 'BANGALORE', 400, 3000);

-- Selecting all from CUSTOMER Table
SELECT * FROM CUSTOMER;

-- Insert data into ORDERS
INSERT INTO ORDERS VALUES 
(50, 5000.00, '2017-05-04', 10, 1000),
(51, 450.00, '2017-01-20', 10, 2000),
(52, 1000.00, '2017-02-24', 13, 2000),
(53, 3500.00, '2017-04-13', 14, 3000),
(54, 550.00, '2017-03-09', 12, 2000);

-- Selecting all from ORDERS Table
SELECT * FROM ORDERS;

-- 1. Count the customers with grades above Bangalore’s average
SELECT COUNT(*) AS Customer_Count
FROM CUSTOMER 
WHERE GRADE > (
    SELECT AVG(GRADE) 
    FROM CUSTOMER 
    WHERE CITY = 'BANGALORE'
);

-- 2. Find the name and numbers of all salesmen who had more than one customer
SELECT S.SALESMAN_ID, S.NAME, COUNT(C.CUSTOMER_ID) AS Customer_Count
FROM SALESMAN S
JOIN CUSTOMER C ON S.SALESMAN_ID = C.SALESMAN_ID
GROUP BY S.SALESMAN_ID, S.NAME
HAVING COUNT(C.CUSTOMER_ID) > 1;

-- 3. List all salesmen and indicate those who have and don’t have customers in their cities
SELECT S.SALESMAN_ID, S.NAME, 'Has Customers' AS Status
FROM SALESMAN S
WHERE S.CITY IN (SELECT DISTINCT CITY FROM CUSTOMER)
UNION 
SELECT S.SALESMAN_ID, S.NAME, 'No Customers' AS Status
FROM SALESMAN S
WHERE S.CITY NOT IN (SELECT DISTINCT CITY FROM CUSTOMER);

-- 4. Create a view that finds the salesman who has the customer with the highest order of a day
CREATE VIEW TopSalesman AS
SELECT O.ORD_DATE, S.SALESMAN_ID, S.NAME 
FROM SALESMAN S
JOIN ORDERS O ON S.SALESMAN_ID = O.SALESMAN_ID
WHERE O.PURCHASE_AMT = (
    SELECT MAX(PURCHASE_AMT) 
    FROM ORDERS 
    WHERE ORD_DATE = O.ORD_DATE
);

-- Query to view top salesman for each day
SELECT * FROM TopSalesman;

-- 5. Delete salesman with ID 1000 and cascade delete his orders
SELECT * FROM SALESMAN;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
DELETE FROM SALESMAN WHERE SALESMAN_ID = 1000;
SELECT * FROM SALESMAN;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

-- Deleting Database
DROP DATABASE LIBRARY;