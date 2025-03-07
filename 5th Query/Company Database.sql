-- Company Database Queries
-- The following schema is used for the Company Database:

-- EMPLOYEE (SSN, Name, Address, Sex, Salary, SuperSSN, DNo) 
-- DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate) 
-- DLOCATION (DNo,DLoc) 
-- PROJECT (PNo, PName, PLocation, DNo) 
-- WORKS_ON (SSN, PNo, Hours) 

-- Write SQL queries to 
-- 1. Make a list of all project numbers for projects that involve an employee whose last name is ‘Scott’, either as a worker or as a manager of the department that controls the project. 
-- 2. Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 percentraise. 
-- 3. Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the maximum salary, the minimum salary, and the average salary in this department.
-- 4. Retrieve the name of each employee who works on all the projects controlled by department number 5 (use NOT EXISTS operator). 
-- 5. For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than Rs.6,00,000.

-- Creating database and using database
CREATE DATABASE COMPANY;
USE COMPANY;

-- Create Table for DEPARTMENT
CREATE TABLE DEPARTMENT (
    DNO VARCHAR(20) PRIMARY KEY,
    DNAME VARCHAR(20) NOT NULL,
    MGRSTARTDATE DATE
);

-- Describing from DEPARTMENT Table
DESC DEPARTMENT;

-- Create Table for EMPLOYEE
CREATE TABLE EMPLOYEE (
    SSN VARCHAR(20) PRIMARY KEY,
    FNAME VARCHAR(20) NOT NULL,
    LNAME VARCHAR(20) NOT NULL,
    ADDRESS VARCHAR(50),
    SEX CHAR(1) CHECK (SEX IN ('M', 'F')),
    SALARY DECIMAL(10,2) CHECK (SALARY > 0),
    SUPERSSN VARCHAR(20),
    DNO VARCHAR(20),
    FOREIGN KEY (SUPERSSN) REFERENCES EMPLOYEE (SSN),
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT (DNO)
);

-- Describing from EMPLOYEE Table
DESC EMPLOYEE;

-- Adding MGRSSN to Department Table
ALTER TABLE DEPARTMENT  
ADD COLUMN MGRSSN VARCHAR(15),  
ADD CONSTRAINT fk_manager FOREIGN KEY (MGRSSN) REFERENCES EMPLOYEE (SSN);

-- Describing from DEPARTMENT Table
DESC DEPARTMENT;

-- Create Table for DLOCATION
CREATE TABLE DLOCATION (
    DLOC VARCHAR (20),
    DNO VARCHAR (20),
    PRIMARY KEY (DNO, DLOC),
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNO)
);

-- Describing from DLOCATION Table
DESC DLOCATION;

-- Create Table for PROJECT
CREATE TABLE PROJECT (
    PNO INTEGER PRIMARY KEY,
    PNAME VARCHAR (20) NOT NULL,
    PLOCATION VARCHAR (20),
    DNO VARCHAR (20),
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNO)
);

-- Describing from PROJECT Table
DESC PROJECT;

-- Create Table for WORKS_ON
CREATE TABLE WORKS_ON (
    HOURS INT CHECK (HOURS >= 0),
    SSN VARCHAR (20),
    PNO INTEGER,
    PRIMARY KEY (SSN, PNO),
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (PNO) REFERENCES PROJECT(PNO)
);

-- Describing from WORKS_ON Table
DESC WORKS_ON;

-- showing tables
SHOW TABLES;

-- Insert data into EMPLOYEE 
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSECE01','JOHN','SCOTT','BANGALORE','M', 450000),
('RNSCSE01','JAMES','SMITH','BANGALORE','M', 500000),
('RNSCSE02','HEARN','BAKER','BANGALORE','M', 700000),
('RNSCSE03','EDWARD','SCOTT','MYSORE','M', 500000),
('RNSCSE04','PAVAN','HEGDE','MANGALORE','M', 650000),
('RNSCSE05','GIRISH','MALYA','MYSORE','M', 450000),
('RNSCSE06','NEHA','SN','BANGALORE','F', 800000),
('RNSACC01','AHANA','K','MANGALORE','F', 350000),
('RNSACC02','SANTHOSH','KUMAR','MANGALORE','M', 300000),
('RNSISE01','VEENA','M','MYSORE','M', 600000),
('RNSIT01','NAGESH','HR','BANGALORE','M', 500000);

-- Selecting all from EMPLOYEE Table
SELECT * FROM EMPLOYEE;

-- Insert data into DEPARTMENT
INSERT INTO DEPARTMENT (DNO, DNAME, MGRSTARTDATE, MGRSSN) VALUES
('1','ACCOUNTS','2001-01-01','RNSACC02'),
('2','IT','2016-08-01','RNSIT01'),
('3','ECE','2008-06-01','RNSECE01'),
('4','ISE','2015-08-01','RNSISE01'),
('5','CSE','2002-06-01','RNSCSE05');

-- Selecting all from DEPARTMENT Table
SELECT * FROM DEPARTMENT;

-- Update Employees with Supervisor and Department
UPDATE EMPLOYEE SET SUPERSSN=NULL, DNO='3' WHERE SSN='RNSECE01';
UPDATE EMPLOYEE SET SUPERSSN='RNSCSE02', DNO='5' WHERE SSN='RNSCSE01';
UPDATE EMPLOYEE SET SUPERSSN='RNSCSE03', DNO='5' WHERE SSN='RNSCSE02';
UPDATE EMPLOYEE SET SUPERSSN='RNSCSE04', DNO='5' WHERE SSN='RNSCSE03';
UPDATE EMPLOYEE SET SUPERSSN='RNSCSE05', DNO='5' WHERE SSN='RNSCSE04';
UPDATE EMPLOYEE SET SUPERSSN='RNSCSE06', DNO='5' WHERE SSN='RNSCSE05';
UPDATE EMPLOYEE SET SUPERSSN=NULL, DNO='5' WHERE SSN='RNSCSE06';
UPDATE EMPLOYEE SET SUPERSSN='RNSACC02', DNO='1' WHERE SSN='RNSACC01';
UPDATE EMPLOYEE SET SUPERSSN=NULL, DNO='1' WHERE SSN='RNSACC02';
UPDATE EMPLOYEE SET SUPERSSN=NULL, DNO='4' WHERE SSN='RNSISE01';
UPDATE EMPLOYEE SET SUPERSSN=NULL, DNO='2' WHERE SSN='RNSIT01';

-- Selecting all from EMPLOYEE Table
SELECT * FROM EMPLOYEE;

-- Insert data into DLOCATION
INSERT INTO DLOCATION VALUES
('BANGALORE', '1'),
('BANGALORE', '2'),
('BANGALORE', '3'),
('MANGALORE', '4'),
('MANGALORE', '5');

-- Selecting all from DLOCATION Table
SELECT * FROM DLOCATION;

-- Insert data into PROJECT
INSERT INTO PROJECT VALUES
(100, 'IOT', 'BANGALORE', '5'),
(101, 'CLOUD', 'BANGALORE', '5'),
(102, 'BIGDATA', 'BANGALORE', '5'),
(103, 'SENSORS', 'BANGALORE', '3'),
(104, 'BANK MANAGEMENT', 'BANGALORE', '1'),
(105, 'SALARY MANAGEMENT', 'BANGALORE', '1'),
(106, 'OPENSTACK', 'BANGALORE', '4'),
(107, 'SMARTCITY', 'BANGALORE', '2');

-- Selecting all from PROJECT Table
SELECT * FROM PROJECT;

-- Insert data into WORKS_ON
INSERT INTO WORKS_ON VALUES
(4, 'RNSCSE01', 100),
(6, 'RNSCSE01', 101),
(8, 'RNSCSE01', 102),
(10, 'RNSCSE02', 100),
(3, 'RNSCSE04', 100),
(4, 'RNSCSE05', 101),
(5, 'RNSCSE06', 102),
(6, 'RNSCSE03', 102),
(7, 'RNSECE01', 103),
(5, 'RNSACC01', 104),
(6, 'RNSACC02', 105),
(4, 'RNSISE01', 106),
(10, 'RNSIT01', 107);

-- Selecting all from WORKS_ON Table
SELECT * FROM WORKS_ON;

-- 1. List all project numbers involving an employee named 'Scott' (either as a worker or a manager)
SELECT DISTINCT P.PNO 
FROM PROJECT P
JOIN DEPARTMENT D ON P.DNO = D.DNO
JOIN EMPLOYEE E ON D.MGRSSN = E.SSN
WHERE E.LNAME = 'SCOTT'
UNION
SELECT DISTINCT P1.PNO 
FROM PROJECT P1
JOIN WORKS_ON W ON P1.PNO = W.PNO
JOIN EMPLOYEE E1 ON W.SSN = E1.SSN
WHERE E1.LNAME = 'SCOTT';

-- 2. Show the resulting salaries if every employee working on the 'IoT' project gets a 10% raise
SELECT E.FNAME, E.LNAME, E.SALARY * 1.1 AS INCR_SAL 
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.SSN = W.SSN
JOIN PROJECT P ON W.PNO = P.PNO
WHERE P.PNAME = 'IOT';

-- 3. Compute salary statistics for employees in the 'Accounts' department
SELECT SUM(E.SALARY) AS TOTAL_SALARY, 
       MAX(E.SALARY) AS MAX_SALARY, 
       MIN(E.SALARY) AS MIN_SALARY, 
       AVG(E.SALARY) AS AVG_SALARY 
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNO = D.DNO
WHERE D.DNAME = 'ACCOUNTS';

-- 4. Retrieve the name of each employee who works on all projects controlled by department number 5 (use NOT EXISTS operator). 
SELECT E.FNAME, E.LNAME 
FROM EMPLOYEE E
WHERE NOT EXISTS (
    SELECT P.PNO 
    FROM PROJECT P
    WHERE P.DNO = '5'
    AND NOT EXISTS (
        SELECT W.PNO 
        FROM WORKS_ON W 
        WHERE W.SSN = E.SSN 
        AND W.PNO = P.PNO
    )
);

-- 5. Retrieve departments with more than five employees and count employees earning more than Rs. 6,00,000
SELECT D.DNO, COUNT(E.SSN) AS EMP_COUNT
FROM DEPARTMENT D
JOIN EMPLOYEE E ON D.DNO = E.DNO
WHERE E.SALARY > 600000 
AND D.DNO IN (
    SELECT E1.DNO 
    FROM EMPLOYEE E1 
    GROUP BY E1.DNO 
    HAVING COUNT(*) > 5
)
GROUP BY D.DNO;

-- Deleting Database
DROP DATABASE COMPANY;