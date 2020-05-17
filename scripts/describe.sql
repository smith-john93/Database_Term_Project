-- John Smith
-- CS205-01
-- describe.sql Version 2

-- Purpose: This file describes all tables and populates a spool
--			file with the information for each table.

-- The spool file to be created is spoolDescribe.txt

\o 'spoolDescribe.txt'

-- general information on the execution date as well as user and location
\qecho 'The Describe Table script was executed' `date /t` 'at' `time /t`
\qecho 'Scipt was executed by' :USER 'on' :HOST 'in database' :DBNAME


BEGIN TRANSACTION;

-- Output information on the Employee Table
\d Employee

-- Output information on the Department Table
\d Department

-- Output information on the Vendor Table
\d Vendor

-- Output information on the Item Table
\d Item

-- Output information on the Orders Table
\d Orders

-- Output information on the OrderDetail Table
\d OrderDetail

COMMIT;

\qecho 'End of table descriptions'

-- Turn off spooling
\o