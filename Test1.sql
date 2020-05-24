/*This is a free form SQL exercise where you use this database to extract all relevant layman employee information from this database and tables*/

WITH myCTE1 AS (SELECT a.BusinessEntityID, c.PhoneNumber, d.EmailAddress, (FirstName + ' ' + LastName) AS FullName, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, VacationHours, SickLeaveHours
FROM HumanResources.Employee AS a
INNER JOIN Person.Person AS b
	ON a.BusinessEntityID = b.BusinessEntityID
INNER JOIN Person.PersonPhone AS c
	ON a.BusinessEntityID = c.BusinessEntityID
INNER JOIN Person.EmailAddress AS d
	ON a.BusinessEntityID = d.BusinessEntityID)

/*--This selects all female managers from the database
SELECT * FROM myCTE1
WHERE JobTitle LIKE '%Manager%' AND Gender = 'F'
ORDER BY VacationHours DESC;
*/

--This selects the hiring year from the full date, and computes it against today's date to get the years of service. Because on first glance it seems that Production guys serve longer, this script then filters away Production Technician and Supervisors
SELECT EmailAddress, FullName, JobTitle, (YEAR(GETDATE()) - YEAR(HireDate)) AS YearsOfService, VacationHours, SickLeaveHours
FROM myCTE1
WHERE JobTitle NOT LIKE '%Production%'
ORDER BY YearsOfService DESC;