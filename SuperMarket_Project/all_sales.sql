USE SupermarketAnalysis
GO

-- Also going to create day of week to correspond to the dates. This is because for update reasons we are using DirectQuery option
-- in PowerBI instead of the Import option. This is for 2 main reasons, the first is to make sure we always have up to date data, and the second is to reduce file size.
-- A drawback is that we can't use DAX expressions to extra DOW from the data using BI's dot notation, so instead we'll do it in SQL.
CREATE OR ALTER VIEW vw_all_sales AS
SELECT        Invoice_ID, City, Customer_type, Gender, Product_line, Unit_price, Quantity, Date, Time, DATEPART(WEEKDAY,Date) AS day_num, DATENAME(month, Date) AS month, DATENAME(dw, Date) AS day_of_week, gross_income
FROM            dbo.SupermarketSales
GO

SELECT * FROM vw_all_sales
GO

CREATE OR ALTER VIEW vw_all_sales_aggregate AS
SELECT Product_line, City, SUM(gross_income) AS ProductLineProfit
FROM vw_all_sales
GROUP BY Product_line, City
GO