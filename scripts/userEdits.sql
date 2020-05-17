-- John Smith
-- CS205-01
-- userEdits.sql Version 1

-- Purpose: This file simulates user edits to be entered into the database.
--			Inserts, Updates and Drops will be tested

-- The spool file to be created is spoolDrop.txt
\o 'spooluserEdits.txt'

-- General information on the execution date as well as user and location
\qecho 'The User Edits script was executed' `date /t` 'at' `time /t`
\qecho 'Scipt was executed by' :USER 'on' :HOST 'in database' :DBNAME


\qecho 'Deleting all current data'

\qecho 'Deleting from Orders...'
DELETE FROM Orders CASCADE;
\qecho ''

\qecho 'Deleting from Department...'
DELETE FROM Department CASCADE;
\qecho ''

\qecho 'Deleting from Employee...'
DELETE FROM Employee CASCADE;
\qecho ''

\qecho 'Deleting from OrderDetail...'
DELETE FROM OrderDetail CASCADE;
\qecho ''

\qecho 'Deleting from Item...'
DELETE FROM Item CASCADE;
\qecho ''

\qecho 'Deleting from Vendor...'
DELETE FROM Vendor CASCADE;
\qecho ''

\qecho 'Done Deleting data'
\qecho '__________________________________'

\qecho 'Performing Data Insertion For Employee...'

INSERT INTO Employee (LastName, FirstName, Street, City, Zip, State)
VALUES ('Smith', 'John', '123 Main Street', 'NYC', '12345', 'NY'),
	   ('Tart', 'Pop', '23 Kellog Way', 'Battle Creek', '49016', 'MI'),
	   ('Bit', 'Fit', '19 Fitness Court', 'Danbury', '06810', 'CT'),
	   ('Sung', 'Sam', '85 Korea Avenue', 'Los Angeles', '90210', 'CA'),
	   ('Armour', 'Under', '56 Expedition Lane', 'Bolder', '54321', 'CO'),
	   ('Packard', 'Hewlett', '10 Technology Terrace', 'Silicon Valley', '99999', 'CA'),
	   ('Mander', 'Char', '55 Pokemon Street', 'Kanto', '986753', 'NY');
\qecho 'Done Inserting Into Employee'
\qecho ''

\qecho 'Performing Data Insertion For Department...'

INSERT INTO Department
SELECT 'Seafood'
	 , EmpID
FROM Employee
WHERE LastName = 'Smith';

INSERT INTO Department
SELECT 'Bakery'
	 , EmpID
FROM Employee
WHERE LastName = 'Armour';

INSERT INTO Department
SELECT 'Deli'
	 , EmpID
FROM Employee
WHERE LastName = 'Bit';

INSERT INTO Department
SELECT 'Cheese'
	 , EmpID
FROM Employee
WHERE LastName = 'Sung';

INSERT INTO Department
SELECT 'Meat'
	 , EmpID
FROM Employee
WHERE LastName = 'Tart';

INSERT INTO Department
SELECT 'Prepared Foods'
	 , EmpID
FROM Employee
WHERE LastName = 'Packard';

\qecho 'Done Inserting Into Department'
\qecho ''

\qecho 'Inserting Into Vendor'
INSERT INTO Vendor
VALUES ('Mark''s Meat Market', '(908)-555-1234'),
	   ('Samuel Seafood Supppliers', '132-456-7890'),
	   ('Daniel Deli Delivery', '987-654-3210'),
	   ('Cathy Cheese Corner', '963-852-7410'),
	   ('Bobby Bakery Business','014-258-3690'),
	   ('Patricia Prepared Portions','784-951-6203');
	   
\qecho 'Done inserting into Vendor'
\qecho ''

\qecho 'Inserting into Item'
INSERT INTO Item
VALUES ('Munster', 'Cathy Cheese Corner', 2.32),
	   ('Roast Beef', 'Mark''s Meat Market', 9.15),
	   ('Porterhouse', 'Mark''s Meat Market', 12.75),
	   ('Sliced Deli Meat', 'Daniel Deli Delivery', 5.89),
	   ('Mystery Sandwich', 'Patricia Prepared Portions', 12.25),
	   ('Salmon', 'Samuel Seafood Supppliers', 16.21),
	   ('Tuna', 'Samuel Seafood Supppliers', 10.63),
	   ('Baked Bread', 'Bobby Bakery Business', .99);
\qecho 'Done Inserting into Item'
\qecho ''

\qecho 'Simulating Order Creations and Updates'

DO $$
DECLARE
	b_Item VARCHAR(25) := 'Baked Bread';
	s_Item VARCHAR(25) := 'Salmon';
	st_item VARCHAR(25) := 'Tuna';
	d_Item VARCHAR(25) := 'Sliced Deli Meat';
	p_Item VARCHAR(25) := 'Mystery Sandwich';
	m_Item VARCHAR(25) := 'Roast Beef';
	mp_item VARCHAR(25) := 'Porterhouse';
	c_Item VARCHAR(25) = 'Munster';
BEGIN

--A Simulation for an order for Bakery
INSERT INTO Orders (Manager, Vendor)
SELECT EmpID
	 , 'Bobby Bakery Business'
FROM Employee
WHERE Employee.LastName = 'Armour';

--Insert an order detail line for the above order
INSERT INTO OrderDetail 
SELECT OrderID
	 , b_Item
	 , 15
	 , 15 * (SELECT Price FROM Item WHERE ItemName = b_Item)
FROM Orders
WHERE Vendor = 'Bobby Bakery Business'
;
--Update the quantity ordered and the price 
UPDATE OrderDetail
SET Quantity = 5
  , Price = 5 * (SELECT Price FROM Item WHERE ItemName = b_item)
;


--A Simulated order for Seafood
--AN order for seafood is created
INSERT INTO Orders (Manager, Vendor)
SELECT EmpID
	 , 'Samuel Seafood Supppliers'
FROM Employee
WHERE Employee.LastName = 'Smith';

--An order detail for 95 Salmon is accidentally created
INSERT INTO OrderDetail 
SELECT OrderID
	 , s_Item
	 , 95
	 , 95 * (SELECT Price FROM Item WHERE ItemName = s_Item)
FROM Orders
WHERE Vendor = 'Samuel Seafood Supppliers';

--The detail line is deleted by the user
DELETE FROM OrderDetail
WHERE ItemName = s_item;

--A new detail line for tuna is entered
INSERT INTO OrderDetail
SELECT OrderID
	 , st_item
	 , 6
	 , 6 * (SELECT Price FROM Item WHERE ItemName = st_item)
FROM Orders
WHERE Vendor = 'Samuel Seafood Supppliers';

--A proper order detail line for salmon is entered
INSERT INTO OrderDetail 
SELECT OrderID
	 , s_Item
	 , 5
	 , 5 * (SELECT Price FROM Item WHERE ItemName = s_Item)
FROM Orders
WHERE Vendor = 'Samuel Seafood Supppliers';


--A Simulated order for Deli
--An order for Deli
INSERT INTO Orders (Manager, Vendor)
SELECT EmpID
	 , 'Daniel Deli Delivery'
FROM Employee
WHERE Employee.LastName = 'Bit';

INSERT INTO OrderDetail 
SELECT OrderID
	 , d_Item
	 , 1
	 , 1 * (SELECT Price FROM Item WHERE ItemName = d_Item)
FROM Orders
WHERE Vendor = 'Daniel Deli Delivery';

--The user realises they did not order enough, so they add to the order
UPDATE OrderDetail
SET Quantity = 9
  , Price = 9 * (SELECT Price FROM Item WHERE ItemName = b_Item);

  
--A Simulated order for Prepared Foods
--An order for Prepared Food
INSERT INTO Orders (Manager, Vendor)
SELECT EmpID
	 , 'Patricia Prepared Portions'
FROM Employee
WHERE Employee.LastName = 'Packard';

INSERT INTO OrderDetail 
SELECT OrderID
	 , p_Item
	 , 15
	 , 15 * (SELECT Price FROM Item WHERE ItemName = p_Item)
FROM Orders
WHERE Vendor = 'Patricia Prepared Portion';

--The user realises they do not need the order
DELETE FROM OrderDetail
WHERE OrderID = (
				 SELECT OrderID
				 FROM Orders
					INNER JOIN Employee ON Employee.EmpId = Orders.Manager
				 WHERE OrderDate = CURRENT_DATE
					AND LastName = 'Packard'
				);

DELETE FROM Orders
WHERE OrderID = (
				 SELECT OrderID
				 FROM Orders
					INNER JOIN Employee ON Employee.EmpId = Orders.Manager
				 WHERE OrderDate = CURRENT_DATE
					AND LastName = 'Packard'
				);
		
		
--A Simulated Order for Cheese
--An order for Cheese
INSERT INTO Orders (Manager, Vendor)
SELECT EmpID
	 , 'Cathy Cheese Corner'
FROM Employee
WHERE Employee.LastName = 'Sung';

INSERT INTO OrderDetail 
SELECT OrderID
	 , c_Item
	 , 15
	 , 15 * (SELECT Price FROM Item WHERE ItemName = c_Item)
FROM Orders
WHERE Vendor = 'Cathy Cheese Corner';


--A Simulated order for Meat
INSERT INTO Orders (Manager, Vendor)
SELECT EmpID
	 , 'Mark''s Meat Market'
FROM Employee
WHERE Employee.LastName = 'Tart';

INSERT INTO OrderDetail 
SELECT OrderID
	 , m_item
	 , 15
	 , 15 * (SELECT Price FROM Item WHERE ItemName = m_Item)
FROM Orders
WHERE Vendor = 'Mark''s Meat Market';

END $$;

\qecho 'Done Simulating Order Creations and Updated'


\qecho '__________________________________'
\qecho 'End of script reached'

\o


	