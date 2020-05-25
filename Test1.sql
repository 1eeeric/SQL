/*This is a free form SQL exercise where you use this database to extract all relevant layman employee information from this database and tables*/

/*WITH myCTE1 AS (SELECT a.BusinessEntityID, c.PhoneNumber, d.EmailAddress, (FirstName + ' ' + LastName) AS FullName, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, VacationHours, SickLeaveHours
FROM HumanResources.Employee AS a
INNER JOIN Person.Person AS b
	ON a.BusinessEntityID = b.BusinessEntityID
INNER JOIN Person.PersonPhone AS c
	ON a.BusinessEntityID = c.BusinessEntityID
INNER JOIN Person.EmailAddress AS d
	ON a.BusinessEntityID = d.BusinessEntityID)
*/

/*--This selects all female managers from the database
SELECT * FROM myCTE1
WHERE JobTitle LIKE '%Manager%' AND Gender = 'F'
ORDER BY VacationHours DESC;
*/

/*--This selects the hiring year from the full date, and computes it against today's date to get the years of service. Because on first glance it seems that Production guys serve longer, this script then filters away Production Technician and Supervisors
SELECT EmailAddress, FullName, JobTitle, (YEAR(GETDATE()) - YEAR(HireDate)) AS YearsOfService, VacationHours, SickLeaveHours
FROM myCTE1
WHERE JobTitle NOT LIKE '%Production%'
ORDER BY YearsOfService DESC;
*/

/*This next portion of code tries to extract relevant foreign tables information for Sales Order Detail table. Primary key for this portion of the analysis is SalesOrderID*/
WITH myCTE2 AS (SELECT a.SalesOrderID, a.SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, OrderDate, DueDate, ShipDate, SalesOrderNumber, PurchaseOrderNumber, AccountNumber, SubTotal, TaxAmt, Freight, TotalDue, CustomerID, SalesPersonID, TerritoryID, BillToAddressID, ShipToAddressID, ShipMethodID, CreditCardID 
FROM Sales.SalesOrderDetail AS a
INNER JOIN Sales.SalesOrderHeader AS b
ON a.SalesOrderID = b.SalesOrderID)

/* --Sub-Query for sales order ID and product name
SELECT SalesOrderID, Production.Product.Name AS ProductName
FROM myCTE2
INNER JOIN Production.Product
ON myCTE2.ProductID = Production.Product.ProductID;
*/

--Sub-query for sales order ID and customer ID. This expands to 1 more foreign keys, StoreID
SELECT SalesOrderID, StoreID, mytbl3.Name AS StoreLocationName
FROM myCTE2 AS mytbl1
INNER JOIN Sales.Customer AS mytbl2
ON mytbl1.CustomerID = mytbl2.CustomerID
INNER JOIN Sales.SalesTerritory AS mytbl3
ON mytbl1.TerritoryID = mytbl3.TerritoryID;