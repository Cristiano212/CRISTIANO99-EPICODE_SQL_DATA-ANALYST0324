-- 1TASK
SELECT 
    dsc.EnglishProductSubcategoryName,
    dsc.ProductSubcategoryKey,
    dp.ProductSubcategoryKey,
    dp.EnglishProductName,
    dp.ProductKey
FROM
    dimproductsubcategory AS dsc
        inner join
    dimproduct AS dp ON dsc.ProductSubcategoryKey = dp.ProductSubcategoryKey;
    
 -- SECONDO TASK   
SELECT 
    dimproduct.ProductKey,
    dimproduct.EnglishProductName,
    dimproductcategory.EnglishProductCategoryName,
    dimproductsubcategory.EnglishProductSubcategoryName
FROM
    dimproduct
        INNER  JOIN
    dimproductsubcategory ON dimproduct.ProductSubcategoryKey = dimproductsubcategory.ProductSubcategoryKey
        INNER JOIN
    dimproductcategory ON dimproductsubcategory.ProductCategoryKey = dimproductcategory.ProductCategoryKey
    order by ProductKey;


-- TERZO TASK
SELECT*
FROM dimproduct
WHERE ProductKey IN 
(SELECT ProductKey FROM factresellersales);


-- QUARTO TASK
SELECT*
FROM dimproduct
WHERE ProductKey NOT IN 
(SELECT ProductKey FROM factresellersales)
AND FinishedGoodsFlag =1;


-- QUINTO TASK
SELECT 
    dimproduct.EnglishProductName,
    factresellersales.SalesOrderNumber,
    factresellersales.OrderDate
FROM
    dimproduct
        INNER JOIN
    factresellersales ON dimproduct.ProductKey = factresellersales.Productkey;
    
-- SESTO TASK
SELECT 
    factresellersales.ProductKey,
    factresellersales.SalesOrderNumber,
    dimproduct.EnglishProductName,
    dimproductcategory.EnglishProductCategoryName,
    dimproductsubcategory.EnglishProductSubcategoryName
FROM
    dimproduct
        INNER JOIN
    dimproductsubcategory ON dimproductsubcategory.ProductSubcategoryKey = dimproduct.ProductSubcategoryKey
        INNER JOIN
    dimproductcategory ON dimproductsubcategory.ProductCategoryKey = dimproductcategory.ProductCategoryKey
        INNER JOIN
    factresellersales ON factresellersales.ProductKey = dimproduct.ProductKey
;


-- SETTIMO TASK
SELECT*
FROM dimreseller;

-- 8. Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica
SELECT 
    dimreseller.ResellerName,
    dimreseller.ResellerKey,
    dimgeography.City,
    dimgeography.StateProvinceName,
dimgeography.EnglishCountryRegionName,
dimsalesterritory.SalesTerritoryCountry,
dimsalesterritory.SalesTerritoryRegion
    FROM
    dimreseller
        INNER JOIN
   dimgeography on dimreseller.GeographyKey = dimgeography.GeographyKey
	 inner join
     dimsalesterritory on dimgeography.SalesTerritoryKey = dimsalesterritory.SalesTerritoryKey;
    
    
-- NONO TASK
SELECT 
    dimproduct.EnglishProductName,
    dimproductcategory.EnglishProductCategoryName,
    dimreseller.ResellerName,
    dimsalesterritory.SalesTerritoryCountry,
    factresellersales.SalesOrderNumber,
    factresellersales.SalesOrderLineNumber,
    factresellersales.OrderDate,
    factresellersales.UnitPrice,
    factresellersales.OrderQuantity,
    factresellersales.TotalProductCost
FROM
    factresellersales
        INNER JOIN
    dimproduct ON factresellersales.ProductKey = dimproduct.ProductKey
        INNER JOIN
    dimsalesterritory ON dimsalesterritory.SalesTerritoryKey = factresellersales.SalesTerritoryKey
        INNER JOIN
    dimreseller ON dimreseller.ResellerKey = factresellersales.ResellerKey
        INNER JOIN
    dimproductsubcategory ON dimproductsubcategory.ProductSubcategoryKey = dimproduct.ProductSubcategoryKey
        INNER JOIN
    dimproductcategory ON dimproductcategory.ProductCategoryKey = dimproductsubcategory.ProductCategoryKey





