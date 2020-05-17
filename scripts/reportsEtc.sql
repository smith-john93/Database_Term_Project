-- John Smith
-- CS205-01
-- reportsEtc Version 1

-- Purpose: This file contains all reports requested

-- The spool file to be created is spoolReportsEtc.txt
\o 'spoolReportsEtc.txt'

-- General information on the execution date as well as user and location
\qecho 'Reports scripts were executed ' `date /t` ' at ' `time /t`
\qecho 'Scipt was executed by' :USER 'on' :HOST 'in database' :DBNAME
\qecho ''

--Order information from past year
\qecho 'Seafood Department Orders'
SELECT ItemName
	 , SUM(Quantity) QuantitySold
	 , SUM(Price) TotalItemRevenue
FROM Orders
	INNER JOIN OrderDetail ON OrderDetail.OrderID = Orders.OrderId
WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Smith')
	AND OrderDate BETWEEN '11/19/2017' AND '11/19/2018'
GROUP BY ItemName;

\qecho 'Seafood Purchase Order'
SELECT ItemName
	 , Name
	 , Phone
	 , Quantity
	 , Orders.OrderId
	 , Manager
FROM Orders
	INNER JOIN OrderDetail ON OrderDetail.OrderId = Orders.OrderID
	INNER JOIN Vendor ON Vendor.Name = Orders.Vendor
WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Smith')
GROUP BY Orders.OrderId, Itemname, Name, Phone, Quantity, Manager
;

\qecho 'Meat Orders'
SELECT itemname
	  , sum(quantity) quantitysold
	 , sum(price) totalitemrevenue
from orders
inner join orderdetail on orderdetail.orderid = orders.orderid
where manager = (select empid from employee where lastname = 'Tart')
	and orderdate between '11/19/2017' and '11/19/2018'
group by itemname;

\qecho 'Meat Purchase Orders'
SELECT ItemName
	 , Name
	 , Phone
	 , Quantity
	 , Orders.OrderId
	 , Manager
FROM Orders
	INNER JOIN OrderDetail ON OrderDetail.OrderId = Orders.OrderID
	INNER JOIN Vendor ON Vendor.Name = Orders.Vendor
WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Tart')
GROUP BY Orders.OrderId, Itemname, Name, Phone, Quantity, Manager
;

\qecho 'Bakery Orders'
SELECT ItemName
	  , SUM(Quantity) QuantitySold
	  , SUM(Price) TotalItemRevenue
 FROM Orders
	 INNER JOIN OrderDetail ON OrderDetail.OrderID = Orders.OrderId
 WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Armour')
	 AND OrderDate BETWEEN '11/19/2017' AND '11/19/2018'
GROUP BY ItemName;

\qecho 'Bakery Purchase Orders'
SELECT ItemName
	 , Name
	 , Phone
	 , Quantity
	 , Orders.OrderId
	 , Manager
FROM Orders
	INNER JOIN OrderDetail ON OrderDetail.OrderId = Orders.OrderID
	INNER JOIN Vendor ON Vendor.Name = Orders.Vendor
WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Armour')
GROUP BY Orders.OrderId, Itemname, Name, Phone, Quantity, Manager
;

\qecho 'Deli Orders'
SELECT ItemName
	  , SUM(Quantity) QuantitySold
	  , SUM(Price) TotalItemRevenue
 FROM Orders
	 INNER JOIN OrderDetail ON OrderDetail.OrderID = Orders.OrderId
 WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Bit')
	 AND OrderDate BETWEEN '11/19/2017' AND '11/19/2018'
GROUP BY ItemName;

\qecho 'Deli Purchase Orders'
SELECT ItemName
	 , Name
	 , Phone
	 , Quantity
	 , Orders.OrderId
	 , Manager
FROM Orders
	INNER JOIN OrderDetail ON OrderDetail.OrderId = Orders.OrderID
	INNER JOIN Vendor ON Vendor.Name = Orders.Vendor
WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Bit')
GROUP BY Orders.OrderId, Itemname, Name, Phone, Quantity, Manager
;

\qecho 'PrePackaged Orders'
SELECT ItemName
	  , SUM(Quantity) QuantitySold
	  , SUM(Price) TotalItemRevenue
 FROM Orders
	 INNER JOIN OrderDetail ON OrderDetail.OrderID = Orders.OrderId
 WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Packard')
	 AND OrderDate BETWEEN '11/19/2017' AND '11/19/2018'
GROUP BY ItemName;

\qecho 'PrePackaged Purchase Orders'
SELECT ItemName
	 , Name
	 , Phone
	 , Quantity
	 , Orders.OrderId
	 , Manager
FROM Orders
	INNER JOIN OrderDetail ON OrderDetail.OrderId = Orders.OrderID
	INNER JOIN Vendor ON Vendor.Name = Orders.Vendor
WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Packard')
GROUP BY Orders.OrderId, Itemname, Name, Phone, Quantity, Manager
;

\qecho 'Cheese Orders'
SELECT ItemName
	  , SUM(Quantity) QuantitySold
	  , SUM(Price) TotalItemRevenue
 FROM Orders
	 INNER JOIN OrderDetail ON OrderDetail.OrderID = Orders.OrderId
 WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Sung')
	 AND OrderDate BETWEEN '11/19/2017' AND '11/19/2018'
GROUP BY ItemName;

\qecho 'Cheese Purchase Orders'
SELECT ItemName
	 , Name
	 , Phone
	 , Quantity
	 , Orders.OrderId
	 , Manager
FROM Orders
	INNER JOIN OrderDetail ON OrderDetail.OrderId = Orders.OrderID
	INNER JOIN Vendor ON Vendor.Name = Orders.Vendor
WHERE Manager = (SELECT EmpID FROM Employee WHERE LastName = 'Sung')
GROUP BY Orders.OrderId, Itemname, Name, Phone, Quantity, Manager
;

