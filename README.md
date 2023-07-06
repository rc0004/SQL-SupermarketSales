## SuperMarket_Project source data at https://www.kaggle.com/datasets/aungpyaeap/supermarket-sales

 This data is a good use case for querying with SQL inside of SSMS to build up experience with SQL to extract data, rather than relying on PowerBI to transform the incoming dataset. While PowerBI is a powerful tool, we will aim to perform transformations according to Roche's Maxim: "Transform your data as upstream as possible, as downstream as necessary."

There is a secondary benefit of using SQL and creating views of the dataset. If we are generating several reports and the underlying dataset were to change, while this would break our report, we could fix this by simply updating the SQL Code that determines how the view is generated. If we had loaded the databases into each report, we would need to go through each report and update it to grab a different column name. 

Therefore, the current project will utilise SQL to generate views to focus on specific aspects of the data, perform some highly efficient aggregation in SQL, and this view will then be exported for visualisation in PowerBI.

**Inside the folder, download Supermarket_Analysis.pbix for the final visualisation.**

SQL files are also available for download to check how imported views were created from the source file.
