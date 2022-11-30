--From the vw_cash_payment we have sales data for different product lines.
-- But what if we wish for different totals for male and female customers?
-- In classic star schema, the sort of relational database schema that PowerBI is designed to work, and BI specificailly, it prefers "long format"
-- data. If we pursued a wide format, for producing different columns for each gender, it becomes more complicated.
-- We'd be executing two aggregate functions at once, based on two conditions.
-- This is more complicated than it initially seems.
-- Below I'll show both approaches to this.

-- Solution 1, long format **ideal
-- Creates duplicates of each product line, one for females and one for males
-- Can group by Gender as well to separate them into male and female values, then additionally
-- select Gender to show which value is which
-- The resulting table is in "long" format, with repeated values in the Product_line column, but
-- without separate columns for each gender
USE SupermarketAnalysis
GO

CREATE OR ALTER VIEW vw_cash_payment_by_gender_long
AS SELECT Product_line, SUM(gross_income) AS ProductLine_profit, Gender
FROM vw_cash_payment 
GROUP BY Product_line, Gender
GO


--Solution 2, wide format. Came to this after a LOT of fiddling with trying nested queries, JOINs, UNIONs, but those don't
-- make much sense when dealing with data in the same table.
-- This creates three columns, a total gross income for each product line, a total gross income for males, and total gross income for females.
-- This snippit is only for demonstration and absolutely is not recommended for analysis or visualisation purposes.

CREATE OR ALTER VIEW vw_cash_payment_by_gender_wide
AS 
SELECT Product_line, SUM(gross_income) AS gross_total,
SUM(case when Gender = 'Male' then gross_income ELSE 0 END) as male_income,
SUM (case when Gender = 'Female' then gross_income ELSE 0 END) as female_income
FROM vw_cash_payment
GROUP BY Product_line
ORDER BY gross_total DESC
GO