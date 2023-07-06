# Steps to turn CSV into database file and query dataset to produce needed views, which can be loaded or export into various platforms such as PowerBI or Excel.

## 1 Install SQL server express: https://www.microsoft.com/en-au/sql-server/sql-server-downloads

## 2 Choose the additional install of SSMS (SQL server management studio). SQLexpress and other editions install a command line tool SQLCMD. Anything that can be done with SSMS can be done with SQLCMD, but you have to learn T-SQL if you want to use the SQLCMD proficiently.

## 3 Imported the CSV file by choosing select flat file from Tasks - data successfully imported. At this point examined my planned workflow of CSV load into DB -> transform -> export to excel -> analyse. For instance, PowerBI could do all the data transformations within PowerQuery and there would be less SQL manipulation needed.

## 4 Exported the database into excel in SSMS by dealing with error messages related to "'Microsoft.ACE.OLEDB.16.0' provider is not registered on the local machine." This was solved by opening Import and Export Data (64-bit)

## 5 Wrote direct SQL queries instead of Excel for practice. Due to this dataset being relatively small (1000 rows) it would work very well in Excel and doesn't require SQL. 

 Biggest issue came when trying to create separate columns of a SUM of gross_income for each product category based upon Gender. I chased UNION and JOIN approaches, tried to write nested subqueries, but no matter how I formatted it there were always issues. So I stepped back to look at what I was trying to do, and kept revising the question I was typing in Google. Eventually I came across conditional aggregations, which is what I was essentially trying to do - come up with separate sums for things (or aggregates) based upon a condition, and naming them as different columns using the "AS" keyword. Below is the eventual solution I came to, based upon this website: https://www.codecademy.com/courses/sql-table-transformation/lessons/conditional-aggregates/exercises/sum-case-when
<br>

``` SQL
SELECT Product_line, SUM(gross_income) AS gross_total,
SUM(case when Gender = 'Male' then gross_income ELSE 0 END) as male_income,
SUM (case when Gender = 'Female' then gross_income ELSE 0 END) as female_income
FROM vw_cash_payment
GROUP BY Product_line
ORDER BY gross_total DESC
```

