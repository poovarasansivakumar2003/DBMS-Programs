-- Create Table SALESMAN
CREATE TABLE SALESMAN (
    SALESMAN_ID INT PRIMARY KEY,
    NAME VARCHAR(20) NOT NULL,
    CITY VARCHAR(20) NOT NULL,
    COMMISSION VARCHAR(10) NOT NULL
);

-- Create Table CUSTOMER1
CREATE TABLE CUSTOMER1 (
    CUSTOMER_ID INT PRIMARY KEY,
    CUST_NAME VARCHAR(20) NOT NULL,
    CITY VARCHAR(20) NOT NULL,
    GRADE INT CHECK (GRADE >= 0),
    SALESMAN_ID INT,
    FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID) ON DELETE SET NULL
);

-- Create Table ORDERS
CREATE TABLE ORDERS (
    ORD_NO INT PRIMARY KEY,
    PURCHASE_AMT DECIMAL(10,2) NOT NULL,
    ORD_DATE DATE NOT NULL,
    CUSTOMER_ID INT,
    SALESMAN_ID INT,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER1(CUSTOMER_ID) ON DELETE CASCADE,
    FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID) ON DELETE CASCADE
);

-- Insert data into SALESMAN
INSERT INTO SALESMAN VALUES 
(1000, 'JOHN', 'BANGALORE', '25%'),
(2000, 'RAVI', 'BANGALORE', '20%'),
(3000, 'KUMAR', 'MYSORE', '15%'),
(4000, 'SMITH', 'DELHI', '30%'),
(5000, 'HARSHA', 'HYDERABAD', '15%');

-- Insert data into CUSTOMER1
INSERT INTO CUSTOMER1 VALUES 
(10, 'PREETHI', 'BANGALORE', 100, 1000),
(11, 'VIVEK', 'MANGALORE', 300, 1000),
(12, 'BHASKAR', 'CHENNAI', 400, 2000),
(13, 'CHETHAN', 'BANGALORE', 200, 2000),
(14, 'MAMATHA', 'BANGALORE', 400, 3000);

-- Insert data into ORDERS
INSERT INTO ORDERS VALUES 
(50, 5000.00, '2017-05-04', 10, 1000),
(51, 450.00, '2017-01-20', 10, 2000),
(52, 1000.00, '2017-02-24', 13, 2000),
(53, 3500.00, '2017-04-13', 14, 3000),
(54, 550.00, '2017-03-09', 12, 2000);

-- 1. Count the customers with grades above Bangalore’s average
SELECT COUNT(DISTINCT CUSTOMER_ID) 
FROM CUSTOMER1 
WHERE GRADE > (
    SELECT AVG(GRADE) 
    FROM CUSTOMER1 
    WHERE CITY = 'BANGALORE'
);

-- 2. Find the name and numbers of all salesmen who had more than one customer
SELECT S.SALESMAN_ID, S.NAME 
FROM SALESMAN S
JOIN CUSTOMER1 C ON S.SALESMAN_ID = C.SALESMAN_ID
GROUP BY S.SALESMAN_ID, S.NAME
HAVING COUNT(C.CUSTOMER_ID) > 1;

-- 3. List all salesmen and indicate those who have and don’t have customers in their cities
SELECT S.SALESMAN_ID, S.NAME, C.CUST_NAME, S.COMMISSION 
FROM SALESMAN S
LEFT JOIN CUSTOMER1 C ON S.CITY = C.CITY
UNION 
SELECT S.SALESMAN_ID, S.NAME, 'NO MATCH', S.COMMISSION 
FROM SALESMAN S
WHERE S.CITY NOT IN (SELECT CITY FROM CUSTOMER1)
ORDER BY NAME DESC;

-- 4. Create a view that finds the salesman who has the customer with the highest order of a day
CREATE VIEW ELITSALESMAN AS
SELECT O.ORD_DATE, S.SALESMAN_ID, S.NAME 
FROM SALESMAN S
JOIN ORDERS O ON S.SALESMAN_ID = O.SALESMAN_ID
WHERE O.PURCHASE_AMT = (
    SELECT MAX(PURCHASE_AMT) 
    FROM ORDERS 
    WHERE ORD_DATE = O.ORD_DATE
);

-- To view the top salesman for each day
SELECT * FROM ELITSALESMAN;

-- 5. Delete salesman with ID 1000 and cascade delete his orders
DELETE FROM SALESMAN WHERE SALESMAN_ID = 1000;
