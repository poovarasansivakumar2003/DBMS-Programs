-- College Database
-- The following schema is used for the College Database:

-- STUDENT (USN, SName, Address, Phone, Gender) 
-- SEMSEC (SSID, Sem, Sec) 
-- CLASS (USN, SSID)
-- SUBJECT (Subcode, Title, Sem, Credits)  
-- IAMARKS (USN, Subcode, SSID, Test1, Test2, Test3, FinalIA) 

-- Write SQL queries to 
-- 1. List all the student details studying in fourth semester ‘C’ section. 
-- 2. Compute the total number of male and female students in each semester and in each section. 
-- 3. Create a view of Test1 marks of student USN ‘1BI15CS101’ in all subjects. 
-- 4. Calculate the FinalIA (average of best two test marks) and update the corresponding table for all students.
-- 5. Categorize students based on the following criterion:
-- * If FinalIA = 17 to 20 then CAT = ‘Outstanding’ 
-- * If FinalIA = 12 to 16 then CAT = ‘Average’ 
-- * If FinalIA< 12 then CAT = ‘Weak’ 
-- Give these details only for 8th semester A, B, and C section students. 

-- Creating database and using database
CREATE DATABASE COLLEGE;
USE COLLEGE;

-- Create Table for STUDENT
CREATE TABLE STUDENT ( 
    USN VARCHAR (10) PRIMARY KEY, 
    SNAME VARCHAR (25), 
    ADDRESS VARCHAR (25), 
    PHONE BIGINT, 
    GENDER CHAR (1)
);

-- Describing from STUDENT Table
DESC STUDENT;

-- Create Table for SEMSEC
CREATE TABLE SEMSEC ( 
    SSID VARCHAR (5) PRIMARY KEY, 
    SEM INT, 
    SEC CHAR (1)
); 

-- Describing from SEMSEC Table
DESC SEMSEC;

-- Create Table for CLASS
CREATE TABLE CLASS ( 
    USN VARCHAR (10), 
    SSID VARCHAR (5), 
    PRIMARY KEY (USN, SSID), 
    FOREIGN KEY (USN) REFERENCES STUDENT (USN), 
    FOREIGN KEY (SSID) REFERENCES SEMSEC (SSID)
);

-- Describing from CLASS Table
DESC CLASS;

-- Create Table for SUBJECT
CREATE TABLE SUBJECT ( 
    SUBCODE VARCHAR (8) PRIMARY KEY, 
    TITLE VARCHAR (20), 
    SEM INT, 
    CREDITS INT
); 

-- Describing from SUBJECT Table
DESC SUBJECT;

-- Create Table for IAMARKS
CREATE TABLE IAMARKS ( 
    USN VARCHAR (10), 
    SUBCODE VARCHAR (8), 
    SSID VARCHAR(5), 
    TEST1 INT, 
    TEST2 INT, 
    TEST3 INT, 
    FINALIA INT, 
    PRIMARY KEY (USN, SUBCODE, SSID), 
    FOREIGN KEY (USN) REFERENCES STUDENT (USN), 
    FOREIGN KEY (SUBCODE) REFERENCES SUBJECT (SUBCODE),
    FOREIGN KEY (SSID) REFERENCES SEMSEC (SSID)
);

-- Describing from IAMARKS Table
DESC IAMARKS;

-- showing tables
SHOW TABLES;

-- Inserting Values into STUDENT table
INSERT INTO STUDENT VALUES 
('1RN13CS020','AKSHAY','BELAGAVI', 8877881122,'M'),
('1RN13CS062','SANDHYA','BENGALURU', 7722829912,'F'),
('1RN13CS091','TEESHA','BENGALURU', 7712312312,'F'),
('1RN13CS066','SUPRIYA','MANGALURU', 8877881122,'F'),
('1RN14CS010','ABHAY','BENGALURU', 9900211201,'M'),
('1RN14CS032','BHASKAR','BENGALURU', 9923211099,'M'),
('1RN14CS025','ASMI','BENGALURU', 7894737377,'F'),
('1RN15CS011','AJAY','TUMKUR', 9845091341,'M'),
('1RN15CS029','CHITRA','DAVANGERE', 7696772121,'F'),
('1RN15CS045','JEEVA','BELLARY', 9944850121,'M'),
('1RN15CS091','SANTOSH','MANGALURU', 8812332201,'M'),
('1RN16CS045','ISMAIL','KALBURGI', 9900232201,'M'),
('1RN16CS088','SAMEERA','SHIMOGA', 9905542212,'F'),
('1RN16CS122','VINAYAKA','CHIKAMAGALUR', 8800880011,'M');

-- Selecting all from STUDENT Table
SELECT * FROM STUDENT;

-- Inserting Values into SEMSEC table
INSERT INTO SEMSEC VALUES 
('CSE8A', 8, 'A'),
('CSE8B', 8, 'B'),
('CSE8C', 8, 'C'),
('CSE7A', 7, 'A'),
('CSE7B', 7, 'B'),
('CSE7C', 7, 'C'),
('CSE6A', 6, 'A'),
('CSE6B', 6, 'B'),
('CSE6C', 6, 'C'),
('CSE5A', 5, 'A'),
('CSE5B', 5, 'B'),
('CSE5C', 5, 'C'),
('CSE4A', 4, 'A'),
('CSE4B', 4, 'B'),
('CSE4C', 4, 'C'),
('CSE3A', 3, 'A'),
('CSE3B', 3, 'B'),
('CSE3C', 3, 'C'),
('CSE2A', 2, 'A'),
('CSE2B', 2, 'B'),
('CSE2C', 2, 'C'),
('CSE1A', 1, 'A'),
('CSE1B', 1, 'B'),
('CSE1C', 1, 'C');

-- Selecting all from SEMSEC Table
SELECT * FROM SEMSEC;

-- Inserting Values into CLASS table
INSERT INTO CLASS VALUES 
('1RN13CS020','CSE8A'),
('1RN13CS062','CSE8A'),
('1RN13CS066','CSE8B'),
('1RN13CS091','CSE8C'),
('1RN14CS010','CSE7A'),
('1RN14CS025','CSE7A'),
('1RN14CS032','CSE7A'),
('1RN15CS011','CSE4A'),
('1RN15CS029','CSE4A'),
('1RN15CS045','CSE4B'),
('1RN15CS091','CSE4C'),
('1RN16CS045','CSE3A'),
('1RN16CS088','CSE3B'),
('1RN16CS122','CSE3C');

-- Selecting all from CLASS Table
SELECT * FROM CLASS;

-- Inserting Values into SUBJECT table
INSERT INTO SUBJECT VALUES 
('10CS81', 'ACA', 8, 4),
('10CS82', 'SSM', 8, 4),
('10CS83', 'NM', 8, 4),
('10CS84', 'CC', 8, 4),
('10CS85', 'PW', 8, 4),
('10CS71', 'OOAD', 7, 4),
('10CS72', 'ECS', 7, 4),
('10CS73', 'PTW', 7, 4),
('10CS74', 'DWDM', 7, 4),
('10CS75', 'JAVA', 7, 4),
('10CS76', 'SAN', 7, 4),
('15CS51', 'ME', 5, 4),
('15CS52', 'CN', 5, 4),
('15CS53', 'DBMS', 5, 4),
('15CS54', 'ATC', 5, 4),
('15CS55', 'JAVA', 5, 3),
('15CS56', 'AI', 5, 3),
('15CS41', 'M4', 4, 4),
('15CS42', 'SE', 4, 4),
('15CS43', 'DAA', 4, 4),
('15CS44', 'MPMC', 4, 4),
('15CS45', 'OOC', 4, 3),
('15CS46', 'DC', 4, 3),
('15CS31', 'M3', 3, 4),
('15CS32', 'ADE', 3, 4),
('15CS33', 'DSA', 3, 4),
('15CS34', 'CO', 3, 4),
('15CS35', 'USP', 3, 3),
('15CS36', 'DMS', 3, 3);

-- Selecting all from SUBJECT Table
SELECT * FROM SUBJECT;

-- Inserting Values into IAMARKS table
INSERT INTO IAMARKS (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) VALUES 
('1RN13CS091','10CS81','CSE8C', 15, 16,18),
('1RN13CS091','10CS82','CSE8C', 12, 19,14),
('1RN13CS091','10CS83','CSE8C', 19, 15,20),
('1RN13CS091','10CS84','CSE8C', 20, 16,19),
('1RN13CS091','10CS85','CSE8C', 15, 15,12);

-- Selecting all from SUBJECT Table
SELECT * FROM IAMARKS;

-- 1. List all the student details studying in fourth semester ‘C’ section. 
SELECT S.* 
FROM STUDENT S
JOIN CLASS C ON S.USN = C.USN
JOIN SEMSEC SS ON C.SSID = SS.SSID
WHERE SS.SEM = 4 AND SS.SEC = 'C';

-- 2. Compute the total number of male and female students in each semester and in each section. 
SELECT SS.SEM, SS.SEC, S.GENDER, COUNT(*) AS COUNT 
FROM STUDENT S
JOIN CLASS C ON S.USN = C.USN
JOIN SEMSEC SS ON C.SSID = SS.SSID
GROUP BY SS.SEM, SS.SEC, S.GENDER
ORDER BY SS.SEM;

-- 3. Create a view of Test1 marks of student USN ‘1RN13CS091’ in all subjects. 
CREATE VIEW STU_TEST1_MARKS_VIEW AS 
SELECT USN, SUBCODE, TEST1 
FROM IAMARKS 
WHERE USN = '1RN13CS091';

SELECT * FROM STU_TEST1_MARKS_VIEW;

DROP VIEW STU_TEST1_MARKS_VIEW;

-- 4. Calculate the FinalIA (average of best two test marks) and update the corresponding table for all students. 
SET SQL_SAFE_UPDATES = 0;

UPDATE IAMARKS 
SET FINALIA = (GREATEST(TEST1, TEST2) + GREATEST(TEST1, TEST3, TEST2) - LEAST(TEST1, TEST2, TEST3)) / 2;

SELECT * FROM IAMARKS; 

SET SQL_SAFE_UPDATES = 1;

-- 5. Categorize students based on the following criterion:
-- * If FinalIA = 17 to 20 then CAT = ‘Outstanding’ 
-- * If FinalIA = 12 to 16 then CAT = ‘Average’ 
-- * If FinalIA< 12 then CAT = ‘Weak’ 
-- Give these details only for 8th semester A, B, and C section students. 
SELECT S.USN, S.SNAME, S.ADDRESS, S.PHONE, S.GENDER, 
    CASE 
        WHEN IA.FINALIA BETWEEN 17 AND 20 THEN 'Outstanding'
        WHEN IA.FINALIA BETWEEN 12 AND 16 THEN 'Average'
        ELSE 'Weak' 
    END AS CAT
FROM STUDENT S
JOIN IAMARKS IA ON S.USN = IA.USN
JOIN CLASS C ON S.USN = C.USN
JOIN SEMSEC SS ON C.SSID = SS.SSID
WHERE SS.SEM = 8 AND SS.SEC IN ('A', 'B', 'C');

-- Deleting Database
DROP DATABASE COLLEGE;