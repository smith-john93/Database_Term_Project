-- John Smith
-- CS205-01
-- create.sql Version 2

-- Purpose: This file creates all tables and populates a spool
--			file with the information from each create.

-- The spool file to be created is spoolCreate.txt
\o 'spoolCreate.txt'


-- General information on the execution date as well as user and location
\qecho 'Create Table scripts were executed ' `date /t` ' at ' `time /t`
\qecho 'Scipt was executed by' :USER 'on' :HOST 'in database' :DBNAME

 BEGIN TRANSACTION;

-- Create the Employee table
\qecho 'Creating the Employee table...'

CREATE TABLE IF NOT EXISTS Employee(
	EmpId SERIAL NOT NULL PRIMARY KEY,
	LastName VARCHAR(25) NOT NULL
		CHECK (CHAR_LENGTH(TRIM(LastName)) > 0 ),
	FirstName VARCHAR(25) NOT NULL
		CHECK (CHAR_LENGTH(TRIM(FirstName)) > 0 ),
	Street VARCHAR(25) NOT NULL
		CHECK (CHAR_LENGTH(TRIM(Street)) > 0 ),
	City VARCHAR(25) NOT NULL
		CHECK (CHAR_LENGTH(TRIM(City)) > 0 ),
	Zip VARCHAR(10) NOT NULL
		CHECK (CHAR_LENGTH(TRIM(Zip)) > 0 ),
	State CHAR(2) NOT NULL
		CHECK (CHAR_LENGTH(TRIM(State)) > 0 )
);

\qecho 'Completed creating the Employee Table'
\qecho '____________________________'

--Create the Department Table
\qecho 'Creating the Department table...'

CREATE TABLE IF NOT EXISTS Department(
	Name VARCHAR(50) NOT NULL PRIMARY KEY
		CHECK (CHAR_LENGTH(TRIM(Name)) > 0 ),
	Manager SERIAL NOT NULL REFERENCES Employee
);

\qecho 'Completed creating the Department Table'
\qecho '____________________________'

--Create the Vendor Table
\qecho 'Creating the Vendor Table...'


CREATE TABLE IF NOT EXISTS Vendor(
	Name VARCHAR(50) NOT NULL PRIMARY KEY
		CHECK (CHAR_LENGTH(TRIM(Name)) > 0 ),
	Phone VARCHAR(14) NOT NULL
		CHECK (CHAR_LENGTH(TRIM(Phone)) > 0 )
);

\qecho 'Completed creating the Vendor Table'
\qecho '____________________________'

--Create the Item Table
\qecho 'Creating the Item table...'

CREATE TABLE IF NOT EXISTS Item(
	ItemName VARCHAR(25) NOT NULL PRIMARY KEY
		CHECK (CHAR_LENGTH(TRIM(ItemName)) > 0 ),
	VendorName VARCHAR(50) NOT NULL REFERENCES Vendor
		CHECK (CHAR_LENGTH(TRIM(VendorName)) > 0 ),
	Price FLOAT NOT NULL
);

\qecho 'Completed creating the Item Table'
\qecho '____________________________'

--Create the Orders Table
\qecho 'Creating the Orders Table...'

CREATE TABLE IF NOT EXISTS Orders(
	OrderID SERIAL NOT NULL PRIMARY KEY,
	Manager SERIAL NOT NULL REFERENCES Employee,
	Vendor VARCHAR(50) NOT NULL REFERENCES Vendor,
	OrderDate DATE NOT NULL DEFAULT CURRENT_DATE
);

\qecho 'Completed creating the Order Table'
\qecho '____________________________'

--Create the OrderDetail Table
\qecho 'Creating the OrderDetail Table...'

CREATE TABLE IF NOT EXISTS OrderDetail(
	OrderID SERIAL NOT NULL REFERENCES Orders,
	ItemName VARCHAR(25) NOT NULL REFERENCES Item,
	Quantity INT NOT NULL 
		CHECK (Quantity > 0),
	Price FLOAT NOT NULL,
	CONSTRAINT orderdetail_pk PRIMARY KEY (OrderID, ItemName)
);
\qecho 'Completed creation the OrderDetail Table'
\qecho ''
\qecho 'All tables have been created'

COMMIT;

-- Close the spooling
\o
