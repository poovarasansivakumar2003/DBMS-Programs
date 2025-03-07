-- Movie Database
-- The following schema is used for the Movie Database:

-- ACTOR (Act_id, Act_Name, Act_Gender)
-- DIRECTOR (Dir_id, Dir_Name, Dir_Phone)
-- MOVIES (Mov_id, Mov_Title, Mov_Year, Mov_Lang, Dir_id)
-- MOVIE_CAST (Act_id, Mov_id, Role)
-- RATING (Mov_id, Rev_Stars)

-- Write SQL queries to 
-- 1. List the titles of all movies directed by 'Hitchcock'
-- 2. Find the movie names where one or more actors acted in two or more movies.
-- 3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).
-- 4. Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movie title.
-- 5. Update rating of all movies directed by 'Steven Spielberg' to 5.

-- Creating database and using database
CREATE DATABASE MOVIE;
USE MOVIE;

-- Create Table for ACTOR
CREATE TABLE ACTOR ( 
    ACT_ID INT PRIMARY KEY, 
    ACT_NAME VARCHAR(50), 
    ACT_GENDER CHAR(1)
);

-- Describing from ACTOR Table
DESC ACTOR;

-- Create Table for DIRECTOR
CREATE TABLE DIRECTOR ( 
    DIR_ID INT PRIMARY KEY, 
    DIR_NAME VARCHAR(50), 
    DIR_PHONE BIGINT
);

-- Describing from DIRECTOR Table
DESC DIRECTOR;

-- Create Table for MOVIES
CREATE TABLE MOVIES ( 
    MOV_ID INT PRIMARY KEY, 
    MOV_TITLE VARCHAR(100), 
    MOV_YEAR INT, 
    MOV_LANG VARCHAR(20), 
    DIR_ID INT,
    FOREIGN KEY (DIR_ID) REFERENCES DIRECTOR(DIR_ID)
);

-- Describing from MOVIES Table
DESC MOVIES;

-- Create Table for MOVIE_CAST
CREATE TABLE MOVIE_CAST ( 
    ACT_ID INT, 
    MOV_ID INT, 
    ROLE VARCHAR(50), 
    PRIMARY KEY (ACT_ID, MOV_ID), 
    FOREIGN KEY (ACT_ID) REFERENCES ACTOR(ACT_ID), 
    FOREIGN KEY (MOV_ID) REFERENCES MOVIES(MOV_ID)
);

-- Describing from MOVIE_CAST Table
DESC MOVIE_CAST;

-- Create Table for Rating
CREATE TABLE RATING ( 
    MOV_ID INT PRIMARY KEY, 
    REV_STARS TINYINT, 
    FOREIGN KEY (MOV_ID) REFERENCES MOVIES(MOV_ID)
);

-- Describing from RATING Table
DESC RATING;

-- showing tables
SHOW TABLES;

-- Insert data into ACTOR
INSERT INTO ACTOR VALUES 
(301, 'ANUSHKA', 'F'),
(302, 'PRABHAS', 'M'),
(303, 'PUNITH', 'M'),
(304, 'JERMY', 'M');

-- Selecting all from ACTOR Table
SELECT * FROM ACTOR;

-- Insert data into DIRECTOR
INSERT INTO DIRECTOR VALUES 
(60, 'RAJAMOULI', 8751611001), 
(61, 'HITCHCOCK', 7766138911),
(62, 'FARAN', 9986776531),
(63, 'STEVEN SPIELBERG', 8989776530);

-- Selecting all from DIRECTOR Table
SELECT * FROM DIRECTOR;

-- Insert data into MOVIES
INSERT INTO MOVIES VALUES 
(1001, 'BAHUBALI-2', 2017, 'TELUGU', 60),
(1002, 'BAHUBALI-1', 2015, 'TELUGU', 60),
(1003, 'AKASH', 2008, 'KANNADA', 61),
(1004, 'WAR HORSE', 2011, 'ENGLISH', 63),
(1005, 'OLD CLASSIC', 1995, 'ENGLISH', 62);

-- Selecting all from MOVIES Table
SELECT * FROM MOVIES;

-- Insert data into MOVIE_CAST
INSERT INTO MOVIE_CAST VALUES 
(301, 1002, 'HEROINE'),
(301, 1001, 'HEROINE'),
(303, 1003, 'HERO'),
(303, 1002, 'GUEST'),
(304, 1004, 'HERO'),
(301, 1005, 'LEAD');

-- Selecting all from MOVIE_CAST Table
SELECT * FROM MOVIE_CAST;

-- Insert data into RATING
INSERT INTO RATING VALUES 
(1001, 4),
(1002, 2),
(1003, 5),
(1004, 4);

-- Selecting all from RATING Table
SELECT * FROM RATING;

-- 1. List the titles of all movies directed by 'Hitchcock'
SELECT MOV_TITLE 
FROM MOVIES 
WHERE DIR_ID = (SELECT DIR_ID FROM DIRECTOR WHERE DIR_NAME = 'HITCHCOCK');

-- 2. Find the movie names where one or more actors acted in two or more movies
SELECT DISTINCT M.MOV_TITLE 
FROM MOVIES M
JOIN MOVIE_CAST MC ON M.MOV_ID = MC.MOV_ID
WHERE MC.ACT_ID IN (
    SELECT ACT_ID 
    FROM MOVIE_CAST 
    GROUP BY ACT_ID 
    HAVING COUNT(DISTINCT MOV_ID) > 1
);

-- 3. List all actors who acted in a movie before 2000 and also in a movie after 2015
SELECT DISTINCT A.ACT_NAME 
FROM ACTOR A
JOIN MOVIE_CAST MC1 ON A.ACT_ID = MC1.ACT_ID
JOIN MOVIES M1 ON MC1.MOV_ID = M1.MOV_ID
JOIN MOVIE_CAST MC2 ON A.ACT_ID = MC2.ACT_ID
JOIN MOVIES M2 ON MC2.MOV_ID = M2.MOV_ID
WHERE M1.MOV_YEAR < 2000 AND M2.MOV_YEAR > 2015;

-- 4. Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movie title.
SELECT M.MOV_TITLE, MAX(R.REV_STARS) AS MAX_STARS
FROM MOVIES M
JOIN RATING R ON M.MOV_ID = R.MOV_ID
GROUP BY M.MOV_TITLE
ORDER BY M.MOV_TITLE;

-- 5. Update rating of all movies directed by ‘Steven Spielberg’ to 5.

-- Check current ratings for movies directed by 'Steven Spielberg'
SELECT D.DIR_NAME, M.MOV_TITLE, R.REV_STARS
FROM DIRECTOR D
JOIN MOVIES M ON D.DIR_ID = M.DIR_ID
JOIN RATING R ON M.MOV_ID = R.MOV_ID
WHERE D.DIR_NAME = 'STEVEN SPIELBERG';

-- Update rating of all movies directed by ‘Steven Spielberg’ to 5
UPDATE RATING 
SET REV_STARS = 5 
WHERE MOV_ID IN (
    SELECT MOV_ID FROM MOVIES 
    WHERE DIR_ID = (SELECT DIR_ID FROM DIRECTOR WHERE DIR_NAME = 'STEVEN SPIELBERG')
);

-- Check if the update was successful
SELECT D.DIR_NAME, M.MOV_TITLE, R.REV_STARS
FROM DIRECTOR D
JOIN MOVIES M ON D.DIR_ID = M.DIR_ID
JOIN RATING R ON M.MOV_ID = R.MOV_ID
WHERE D.DIR_NAME = 'STEVEN SPIELBERG';

-- Deleting Database
DROP DATABASE MOVIE;
