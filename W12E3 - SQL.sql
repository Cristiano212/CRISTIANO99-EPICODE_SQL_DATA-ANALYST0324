-- 1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?
SELECT 
    COUNT(ProductKey)
FROM
    dimproduct
GROUP BY ProductKey
HAVING COUNT(ProductKey) > 1
;

-- 2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
SELECT 
    COUNT(*) 
FROM
    factresellersales
GROUP BY SalesOrderNumber , SalesOrderLineNumber
HAVING COUNT(*)>1;


-- TERZO TASK
SELECT 
    COUNT(DISTINCT SalesOrderNumber) AS nOrder, OrderDate
FROM
    factresellersales
WHERE
    OrderDate >= '2020-01-01'
GROUP BY OrderDate
ORDER BY OrderDate;

-- QUARTO TASK
SELECT 
    dimproduct.EnglishProductName,
    SUM(factresellersales.SalesAmount) AS TOTALE_FATTURATO,
    SUM(factresellersales.OrderQuantity) AS TOTALE_QTA,
    AVG(factresellersales.UnitPrice) AS PREZZO_MEDIO
FROM
    factresellersales
        INNER JOIN
    dimproduct ON factresellersales.ProductKey = dimproduct.ProductKey
WHERE
    factresellersales.OrderDate >= '2020-01-01'
GROUP BY dimproduct.EnglishProductName;

-- QUINTO TASK
SELECT*FROM dimproductcategory;
SELECT*FROM factresellersales;

SELECT 
    dimproductcategory.EnglishProductCategoryName,
    SUM(factresellersales.SalesAmount) AS TOTALE_FATTURATO,
    SUM(factresellersales.OrderQuantity) AS TOTALE_QTA
FROM
    factresellersales
        INNER JOIN
    dimproduct ON factresellersales.ProductKey = dimproduct.ProductKey
        INNER JOIN
    dimproductsubcategory ON dimproduct.ProductSubcategoryKey = dimproductsubcategory.ProductSubcategoryKey
        INNER JOIN
    dimproductcategory ON dimproductsubcategory.ProductCategoryKey = dimproductcategory.ProductCategoryKey
GROUP BY dimproductcategory.EnglishProductCategoryName;


/*6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.*/
SELECT*FROM dimgeography;
SELECT*FROM factresellersales;

SELECT 
    dimgeography.City,
    SUM(factresellersales.SalesAmount) AS TOTALE_FATTURATO
FROM
    factresellersales
        JOIN
    dimreseller ON factresellersales.ResellerKey = dimreseller.ResellerKey
        JOIN
    dimgeography ON dimreseller.GeographyKey = dimgeography.GeographyKey
WHERE
    factresellersales.OrderDate >= '2020-01-01'
GROUP BY dimgeography.City
HAVING SUM(factresellersales.SalesAmount) > 60000

