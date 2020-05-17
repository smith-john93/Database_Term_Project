-- John Smith
-- CS205-01
-- read.sql Version 2

-- Purpose: This file prints out all data

-- The spool file to be created is spoolRead.txt
\o 'spoolAllData.txt'

-- General information on the execution date as well as user and location
\qecho 'All Data scripts were executed ' `date /t` ' at ' `time /t`
\qecho 'Scipt was executed by' :USER 'on' :HOST 'in database' :DBNAME

\qecho 'Reading all data from Employee'
SELECT EmpID, LastName, FirstName, Street, City, Zip, State
FROM Employee;

\qecho 'Reading all data from Department'
SELECT Name, Manager
FROM Department;

\qecho 'Reading all data from Vendor'
SELECT Name, Phone
FROM Vendor;

\qecho 'Reading all data from Item'
SELECT ItemName, VendorName, Price
FROM Item;

\qecho 'Reading all data from Orders'
SELECT OrderId, Manager, Vendor, OrderDate
FROM Orders;

\qecho 'Reading all data from OrderDetail'
SELECT OrderId, ItemName, Quantity, Price
FROM OrderDetail;
\o