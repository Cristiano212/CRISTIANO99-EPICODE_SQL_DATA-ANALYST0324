-- Esplora le tabelle dei prodotti (DimProduct)
SELECT 
    *
FROM
    AdventureWorksDW.dimproduct;

-- Interroga la tabella dei prodotti ed esoni in output i campi ProductKey, ProductAlternateKey, EnglishProductName etc
SELECT 
    ProductKey AS ProductKey,
    ProductAlternateKey AS ProductAlternateKey,
    EnglishProductName AS ProductName,
    Color AS Colore,
    StandardCost AS Costo,
    FinishedGoodsFlag
FROM
    dimproduct
WHERE
    dimproduct.FinishedGoodsFlag = 1 ;
    
   -- Ottieni solo i record della colonna  ProductAlternateKey che iniziano solo per FR o BK alter calcolare listprice meno standardcost e farlo uscire in una sola colonna
   
SELECT 
    ProductKey AS CodiceProdotto,
    ModelName AS Modello,
    EnglishProductName AS NomeProdotto,
    StandardCost AS Costo,
    ListPrice AS Prezzo,
    ProductAlternateKey,
    (ListPrice - StandardCost) AS Risultato
FROM
    dimproduct
WHERE
    dimproduct.ProductAlternateKey LIKE 'FR%' OR  dimproduct.ProductAlternateKey LIKE 'BK%';
    
-- PUNTO BETWEEN

SELECT 
    ProductKey AS CodiceProdotto,
    EnglishProductName as NomeProdotto,
    ListPrice as Prezzo
FROM
    dimproduct
Where dimproduct.ListPrice between 1000 and 2000;

-- TABELLA DIMEPLOYEE SALESPERSONFLAG=1

SELECT 
    EmployeeKey AS CodiceAgente,
    FirstName AS Nome,
    LastName AS Cognome,
    SalesPersonFlag
FROM
    dimemployee
WHERE
    dimemployee.SalesPersonFlag = 1;
    
-- ESPONI IN OUTPUT SOLO LE DATE SUPERIORI A 01/01/2020 E CHE HANNO COME PRODUCTKEY 597,598,477,214 E CALCOLA ANCHE IL RISULTATO TRA SALESAMOUNT-TOTALPRODUCTCOST.(TABELLA factresellersales)
SELECT 
    SalesOrderNumber AS TransazioniRegistrate,
    ProductKey as CodiceProdotto,
    OrderDate as DataOrdine,
    (SalesAmount - TotalProductCost) AS Profitto
FROM
    factresellersales
WHERE
    DATE(factresellersales.OrderDate) >= '2020-01-01'
        AND (Productkey = 597
        OR Productkey = 598
        OR Productkey = 477
        OR Productkey = 214)    
       
        
