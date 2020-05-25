--Windowed function using COUNT()
SELECT
	mytbl1.BusinessEntityID,
	Name, 
	City, 
	COUNT(City) OVER (PARTITION BY City) AS Count_of_City, 
	CountryRegionName, 
	COUNT(CountryRegionName) OVER (PARTITION BY CountryRegionName ORDER BY CountryRegionName) AS Count_of_Country, 
	PostalCode,
	CASE WHEN AddressLine2 IS NOT NULL THEN AddressLine1 + ', ' + AddressLine2
		ELSE AddressLine1 END AS Full_Address
FROM [Sales].[vStoreWithAddresses] AS mytbl1
ORDER BY CountryRegionName, Count_of_City DESC;
