--Naming convention for views is vw_result_name_here for the queries
--Specifically drilling into which products do the best from customers who pay with cash, 
--Blog: "Because I ran this a few times I got tired of writing and running a drop view command and modified the CREATE VIEW into CREATE OR ALTER VIEW to allow it to be overwritten

--Need to specify the database to use, otherwise it defaults to master, where the table of SupermarketSales doesn't exist
USE SupermarketAnalysis
GO

CREATE OR ALTER VIEW vw_cash_payment AS 
SELECT City, Gender, Product_line, Unit_price, Quantity, Total, Payment, cogs AS cost_of_good_sold, gross_margin_percentage, gross_income, Rating
FROM SupermarketSales WHERE Payment = 'Cash'
--Without the GO, the creation of view will throw an error about needing to be the only statement in the batch. GO is a batch separate in TSQL
GO 

--View has been created, but will not be visible until selected. Grabbing all the data from our created view.
--Making a view saves a lot of time later if you use a lot of select statements on the same columns and don't wish to type it out every time.
-- Originally just did a SELECT * but this is bad practice if the underlying objects were to change. Better to right click the view and choose
-- "Script View As"
--SELECT * FROM vw_cash_payment

USE [SupermarketAnalysis]
GO

SELECT [City]
      ,[Gender]
      ,[Product_line]
      ,[Unit_price]
      ,[Quantity]
      ,[Total]
      ,[Payment]
      ,[cost_of_good_sold]
      ,[gross_margin_percentage]
      ,[gross_income]
      ,[Rating]
  FROM [dbo].[vw_cash_payment]

GO


--Can aggregate the data by product lines to find where our highest gross income from cash payment is coming from, sorting from 
-- high to low
-- We'll save this as a view to load into PowerBI for visualisation rather than rely on M or DAX expressions in PowerBI
-- Removed ORDER BY clause as it throws an error when defining views
CREATE OR ALTER VIEW vw_productline_profit AS
SELECT Product_line, City, SUM(gross_income) AS ProductLineProfit
FROM vw_cash_payment
GROUP BY Product_line, City
GO

USE [SupermarketAnalysis]
GO

SELECT [Product_line]
      ,[City]
      ,[ProductLineProfit]
  FROM [dbo].[vw_productline_profit]

GO