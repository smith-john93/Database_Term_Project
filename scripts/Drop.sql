-- John Smith
-- CS205-01
-- drop.sql Version 2

-- Purpose: This file drops all tables and populates a spool
--			file with the information from each drop.

-- The spool file to be created is spoolDrop.txt
\o 'spoolDrop.txt'

-- General information on the execution date as well as user and location
\qecho 'Drop Table scripts were executed ' `date /t` ' at ' `time /t`
\qecho 'Scipt was executed by' :USER 'on' :HOST 'in database' :DBNAME


BEGIN;
--Drop the Employee Table
\qecho 'Dropping Employee Table'
DROP TABLE IF EXISTS Employee CASCADE;
\qecho 'Employee Table Dropped'
\qecho ''

--Drop the Department Table
\qecho 'Dropping Department Table'
DROP TABLE IF EXISTS Department CASCADE;
\qecho 'Department Table Dropped'
\qecho ''

--Item
\qecho 'Dropping Item Table'
DROP TABLE IF EXISTS Item CASCADE;
\qecho 'Item Table Dropped'
\qecho ''

--Vendor
\qecho 'Dropping Vendor Table'
DROP TABLE IF EXISTS Vendor CASCADE;
\qecho 'Vendor Table Dropped'
\qecho ''

--OrderDetail
\qecho 'Dropping OrderDetail Table'
DROP TABLE IF EXISTS OrderDetail CASCADE;
\qecho 'OrderDetail Table Dropped'
\qecho ''

--Orders
\qecho 'Dropping Order Table'
DROP TABLE IF EXISTS Orders CASCADE;
\qecho 'Order Table Dropped'
\qecho ''

\qecho 'All tables have been dropped'
END;

-- Close the spooling
\o