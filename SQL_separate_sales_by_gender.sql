--Naming convention for views is vw_result_name_here for the queries
--Specifically drilling into which products do the best from customers who pay with cash, 

--Need to specify the database to use, otherwise it defaults to master, where the table of SupermarketSales doesn't exist
USE SupermarketAnalysis
GO

----Because I ran this a few times I got tired of writing and running a drop view command and modified the 
--CREATE VIEW into "CREATE OR ALTER VIEW" to allow it to be overwritten
CREATE OR ALTER VIEW vw_cash_payment AS 
SELECT City, Gender, Product_line, Unit_price, Quantity, Total, Payment, cogs AS cost_of_good_sold, gross_margin_percentage, gross_income, Rating
FROM SupermarketSales WHERE Payment = 'Cash'
--Without the GO, the creation of view will throw an error about needing to be the only statement in the batch
GO 

--View has been created, but will not be visible until selected. Grabbing all the data from our created view.
--Making a view saves a lot of time later if you use a lot of select statements on the same columns and don't wish to type it out every time.
SELECT * FROM vw_cash_payment

--Can aggregate the data by product lines to find where our highest gross income from cash payment is coming from, sorting from 
-- high to low
SELECT Product_line, SUM(gross_income) AS ProductLineProfit
FROM vw_cash_payment
GROUP BY Product_line
ORDER BY ProductLineProfit DESC

--But what if we wish for two different totals for genders? Such as if we want to know how to target our advertising based upon sales in certain product lines
-- That means we'd be executing two aggregate functions at once, based on two conditions
-- This is more complicated than it initially seems.
-- There are two possible solutions for this, in either long or wide format

-- Solution 1, long format:
-- Creates duplicates of each product line, one for females and one for males
-- Can group by Gender as well to separate them into male and female values, then additionally
-- select Gender to show which value is which
-- The resulting table is in "long" format, with repeated values in the Product_line column, but
-- without separate columns for each gender
SELECT Product_line, SUM(gross_income) AS ProductLine_profit, Gender
FROM vw_cash_payment 
GROUP BY Product_line, Gender


--Solution 2, wide format. Came to this after a LOT of fiddling with trying nested queries, JOINs, UNIONs, but those don't
-- make much sense when dealing with data in the same table.
-- This creates three columns, a total gross income for each product line, a total gross income for males, and total gross income for females.

SELECT Product_line, SUM(gross_income) AS gross_total,
SUM(case when Gender = 'Male' then gross_income ELSE 0 END) as male_income,
SUM (case when Gender = 'Female' then gross_income ELSE 0 END) as female_income
FROM vw_cash_payment
GROUP BY Product_line
ORDER BY gross_total DESC
GO


