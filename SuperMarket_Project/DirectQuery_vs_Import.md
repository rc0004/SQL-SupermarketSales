# Comparing DirectQuery to Import in PowerBI

Need to create custom date table to refer to properly.

"Auto date/time is unavailable in DirectQuery. For example, special treatment of date columns (drill down by using year, quarter, month, or day) isn't supported in DirectQuery mode."

**Auto date/time**

Directly from the docs

```
Each auto date/time table is in fact a calculated table that generates rows of data by using the DAX CALENDAR function. Each table also includes six calculated columns: Day, MonthNo, Month, QuarterNo, Quarter, and Year.
Power BI Desktop also creates a relationship between the auto date/time table's Date column and the model date column.
```

So to do proper time intelligence analysis if you've used DirectQuery mode, you will need to create and designate
your own date table and create relationships to the other tables that have date information.

**Year, Quarter, Year Quarter, Weekday Num, Month name through DAX**

```
Year = YEAR([Date])
Quarter = CONCATENATE("Qtr ", QUARTER([Date]))
Year-Quarter = CONCATENATE([Year],CONCATENATE(" ",[Quarter]))
Weekday-Nr = WEEKDAY([Date],2)
Month = FORMAT('Calendar'[Date],"mmm")

```

I ended up changing DirectQuery to Import, simply due to impracticality of sharing the final report without the data files. By this point I'd already manually created the Date/Calendar table (DIM_date) for use in time intelligence, and it has performance benefits over the auto date/time which creates a separate date table for every single column that has dates in it.