--Sales Performance Analysis--
--1.1 Over all Business KPIs (Dashboard Cards)

SELECT 
    FORMAT(SUM(Sales), 'N0') AS Total_Sales,
    FORMAT(SUM(Profit), 'N0') AS Total_Profit,
    SUM(Quantity) AS Total_Units_Sold,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    ROUND(AVG(DATEDIFF(day, Order_Date, Ship_Date)), 1) AS Avg_Delivery_Days,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Overall_Profit_Margin_Pct
FROM [SuperStore Sales DataSet];

--1.2 Monthly Sales Trend (Area Chart)

SELECT 
    YEAR(Order_Date) AS Sales_Year,
    MONTH(Order_Date) AS Sales_Month,
    DATENAME(MONTH, Order_Date) AS Month_Name,
    SUM(Sales) AS Monthly_Sales,
    SUM(Profit) AS Monthly_Profit,
    COUNT(DISTINCT Order_ID) AS Orders_Count
FROM [SuperStore Sales DataSet]
GROUP BY YEAR(Order_Date), MONTH(Order_Date), DATENAME(MONTH, Order_Date)
ORDER BY Sales_Year, Sales_Month;

--1.3 Year-over-Year Growth (2019 vs 2020)--

WITH YearlySales AS (
    SELECT 
        YEAR(Order_Date) AS Sales_Year,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM [SuperStore Sales DataSet]
    GROUP BY YEAR(Order_Date)
),
CalculatedMetrics AS (
    SELECT 
        Sales_Year AS Current_Year,
        Total_Sales AS Current_Sales,
        -- Get previous year's sales and profit using LAG
        LAG(Total_Sales, 1) OVER (ORDER BY Sales_Year) AS Previous_Sales,
        LAG(Total_Profit, 1) OVER (ORDER BY Sales_Year) AS Previous_Profit,
        Total_Sales,
        Total_Profit
    FROM YearlySales
)
SELECT 
    Current_Year,
    FORMAT(Current_Sales, 'C', 'en-US') AS Current_Sales,
    FORMAT(Previous_Sales, 'C', 'en-US') AS Previous_Sales,
    ROUND(((Current_Sales - Previous_Sales) / Previous_Sales) * 100, 2) AS YoY_Growth_Pct,
    ROUND(((Total_Profit - Previous_Profit) / Previous_Profit) * 100, 2) AS YoY_Profit_Growth_Pct
FROM CalculatedMetrics
WHERE Current_Year = 2020;

--Section 2: Customer Segment Analysis--



 --Section 2: Customer Segment Analysis--
 --2.1 Sales & Profit by Segment (Donut Chart)--

 SELECT 
    Segment,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    COUNT(DISTINCT Customer_ID) AS Customer_Count,
    COUNT(DISTINCT Order_ID) AS Order_Count,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value,
    -- Window function replaces the scalar subquery
    ROUND((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER ()), 2) AS Sales_Share_Pct,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Pct
FROM [SuperStore Sales DataSet]
GROUP BY Segment
ORDER BY Total_Sales DESC;

 --2.2 Top 10 Customers by Revenue--

SELECT TOP 10
    Customer_ID,
    Customer_Name,
    Segment,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM [SuperStore Sales DataSet]
GROUP BY Customer_ID, Customer_Name, Segment
ORDER BY Total_Sales DESC;


--2.3 Customer Retention Analysis (Repeat vs One-Time Buyers)--

WITH CustomerOrders AS (
    SELECT 
        Customer_ID,
        COUNT(DISTINCT Order_ID) AS Order_Count,
        ROUND(SUM(Sales),2) AS Total_Sales
    FROM [SuperStore Sales DataSet]
    GROUP BY Customer_ID
)
SELECT 
    CASE 
        WHEN Order_Count = 1 THEN 'One-Time Buyer'
        WHEN Order_Count BETWEEN 2 AND 5 THEN 'Occasional (2-5)'
        WHEN Order_Count BETWEEN 6 AND 10 THEN 'Loyal (6-10)'
        ELSE 'VIP (10+)'
    END AS Customer_Tier,
    COUNT(*) AS Customer_Count,
    SUM(Total_Sales) AS Total_Revenue,
    ROUND(AVG(Total_Sales), 2) AS Avg_Revenue_Per_Customer
FROM CustomerOrders
GROUP BY 
    CASE 
        WHEN Order_Count = 1 THEN 'One-Time Buyer'
        WHEN Order_Count BETWEEN 2 AND 5 THEN 'Occasional (2-5)'
        WHEN Order_Count BETWEEN 6 AND 10 THEN 'Loyal (6-10)'
        ELSE 'VIP (10+)'
    END
ORDER BY Total_Revenue DESC;

--Section 3: Product Analysis--

--3.1 Category & Sub-Category Performance--

SELECT 
    Category,
    Sub_Category,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    SUM(Quantity) AS Units_Sold,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Pct,
    RANK() OVER (PARTITION BY Category ORDER BY SUM(Sales) DESC) AS Rank_In_Category
FROM [SuperStore Sales DataSet]
GROUP BY Category, Sub_Category
ORDER BY Category, Total_Sales DESC;

--3.2 Top 10 Most Profitable Products--

SELECT TOP 10
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    SUM(Quantity) AS Units_Sold,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Pct
FROM [SuperStore Sales DataSet]
GROUP BY Product_ID, Product_Name, Category, Sub_Category
ORDER BY Total_Profit DESC;

--3.3 Loss-Making Products (Negative Profit)--

SELECT 
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Loss,
    SUM(Quantity) AS Units_Sold,
    COUNT(DISTINCT Order_ID) AS Order_Count
FROM [SuperStore Sales DataSet]
GROUP BY Product_ID, Product_Name, Category, Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Total_Loss ASC;

--3.4 Products Frequently Returned--

SELECT 
    Product_ID,
    Product_Name,
    Category,
    -- Converts text indicators ('Yes') into numbers that can be summed
    SUM(CASE WHEN Returns = 'Yes' THEN 1 ELSE 0 END) AS Total_Returns,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND((SUM(CASE WHEN Returns = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT Order_ID)), 2) AS Return_Rate_Pct
FROM [SuperStore Sales DataSet]
GROUP BY Product_ID, Product_Name, Category
HAVING COUNT(DISTINCT Order_ID) > 5  -- Only products with meaningful order volume
ORDER BY Return_Rate_Pct DESC;

--Section 4: Shipping & Logistics Analysis--
--4.1 Sales by Ship Mode (Bar Chart)--

SELECT 
    Ship_Mode,
    -- Divide by 1M, round to 2 decimals, and append 'M'
    CONCAT('$', ROUND(SUM(Sales) / 1000000.0, 2), 'M') AS Total_Sales_Millions,
    COUNT(DISTINCT Order_ID) AS Order_Count,
    ROUND(AVG(DATEDIFF(day, Order_Date, Ship_Date) * 1.0), 1) AS Avg_Delivery_Days,
    ROUND((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER ()), 2) AS Sales_Share_Pct
FROM [SuperStore Sales DataSet]
GROUP BY Ship_Mode
ORDER BY SUM(Sales) DESC;
--4.2 Delivery Performance vs. Ship Mode--

SELECT 
    Ship_Mode,
    MIN(DATEDIFF(day, Order_Date, Ship_Date)) AS Fastest_Delivery,
    MAX(DATEDIFF(day, Order_Date, Ship_Date)) AS Slowest_Delivery,
    AVG(DATEDIFF(day, Order_Date, Ship_Date)) AS Avg_Delivery,
    COUNT(*) AS Total_Shipments
FROM [SuperStore Sales DataSet]
GROUP BY Ship_Mode
ORDER BY Avg_Delivery;

--4.3 Regional Delivery Performance--

SELECT 
    Region,
    ROUND(AVG(DATEDIFF(day, Order_Date, Ship_Date)), 1) AS Avg_Delivery_Days,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    CONCAT('$', ROUND(SUM(Sales)/ 1000000.0,2),'M') AS Total_Sales
FROM [SuperStore Sales DataSet]
GROUP BY Region
ORDER BY Avg_Delivery_Days DESC;

--Section 5: Geographic Analysis--
--5.1 Sales by Region and State (Map Visual)--

SELECT 
    Region,
    State,
    CONCAT('$',ROUND(SUM(Sales) / 1000.0 ,2), 'K') AS Total_Sales,
    CONCAT('$',ROUND(SUM(Profit) / 1000.0 ,2), 'K') AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Order_Count,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Pct
FROM [SuperStore Sales DataSet]
GROUP BY Region, State
ORDER BY Total_Sales DESC;

--5.2 Top 10 Cities by Revenue--
SELECT TOP 10
    City,
    State,
    Region,
    CONCAT('$',ROUND(SUM(Sales) / 1000.0 ,2), 'K') AS Total_Sales,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    COUNT(DISTINCT Order_ID) AS Order_Count
FROM [SuperStore Sales DataSet]
GROUP BY City, State, Region
ORDER BY Total_Sales DESC;

--5.3 Region Profitability Analysis--
SELECT 
    Region,
    CONCAT('$',ROUND(SUM(Sales) / 1000.0 ,2), 'K') AS Total_Sales,
    CONCAT('$',ROUND(SUM(Profit) / 1000.0 ,2), 'K') AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Pct,
    CASE 
        WHEN SUM(Profit) < 0 THEN 'LOSS'
        WHEN (SUM(Profit) / SUM(Sales)) * 100 < 10 THEN 'LOW MARGIN'
        ELSE 'HEALTHY'
    END AS Status
FROM [SuperStore Sales DataSet]
GROUP BY Region
ORDER BY Total_Profit DESC;

--Section 6: Payment & Operations Analysis--
--6.1 Sales by Payment Mode (Donut Chart)--

SELECT 
    Payment_Mode,
    CONCAT('$',ROUND(SUM(Sales) / 1000000.0 ,2), 'M') AS Total_Sales,
    COUNT(DISTINCT Order_ID) AS Order_Count,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value,
    ROUND((SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM [SuperStore Sales DataSet])), 2) AS Sales_Share_Pct
FROM [SuperStore Sales DataSet]
GROUP BY Payment_Mode
ORDER BY Total_Sales DESC;

--6.2 Payment Mode vs Profit Margin--
SELECT 
    Payment_Mode,
    CONCAT('$',ROUND(SUM(Sales) / 1000.0 ,2), 'K') AS Total_Sales,
    CONCAT('$',ROUND(SUM(Profit) / 1000.0 ,2), 'K') AS Total_Sales,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Pct
FROM [SuperStore Sales DataSet]
GROUP BY Payment_Mode
ORDER BY Profit_Margin_Pct DESC;

--Section 7: Advanced Analytics--
--7.1 Month-over-Month Growth Rate--
WITH MonthlySales AS (
    SELECT 
        DATEFROMPARTS(YEAR(Order_Date), MONTH(Order_Date), 1) AS Month_Start,
        -- Keep this as a raw numeric value for calculations down the line
        SUM(Sales) AS Raw_Monthly_Sales
    FROM [SuperStore Sales DataSet]
    GROUP BY YEAR(Order_Date), MONTH(Order_Date)
),
CalculatedMetrics AS (
    SELECT 
        Month_Start,
        Raw_Monthly_Sales,
        -- Pull the raw numeric value from the previous month
        LAG(Raw_Monthly_Sales) OVER (ORDER BY Month_Start) AS Raw_Previous_Sales
    FROM MonthlySales
)
SELECT 
    Month_Start,
    -- Apply the '$' and 'K' formatting only at the very end
    CONCAT('$', ROUND(Raw_Monthly_Sales / 1000.0, 2), 'K') AS Monthly_Sales,
    CONCAT('$', ROUND(Raw_Previous_Sales / 1000.0, 2), 'K') AS Previous_Month_Sales,
    -- Mathematical operations work perfectly now since they use raw numbers
    ROUND(((Raw_Monthly_Sales - Raw_Previous_Sales) / Raw_Previous_Sales) * 100, 2) AS MoM_Growth_Pct
FROM CalculatedMetrics
ORDER BY Month_Start;

--7.2 Running Total of Sales (Cumulative Growth)--
WITH DailySales AS (
    SELECT 
        Order_Date,
        SUM(Sales) AS Daily_Sales
    FROM [SuperStore Sales DataSet]
    WHERE YEAR(Order_Date) = 2020
    GROUP BY Order_Date
),
CalculatedWindows AS (
    SELECT 
        Order_Date,
        Daily_Sales,
        -- Calculate window totals as numbers first
        SUM(Daily_Sales) OVER (ORDER BY Order_Date) AS Raw_Cumulative,
        SUM(Daily_Sales) OVER () AS Raw_Annual_Total
    FROM DailySales
)
SELECT 
    Order_Date,
    -- Format to thousands (K) at the final display layer
    CONCAT('$', ROUND(Daily_Sales / 1000.0, 2), 'K') AS Daily_Sales,
    CONCAT('$', ROUND(Raw_Cumulative / 1000.0, 2), 'K') AS Cumulative_Sales,
    -- Math runs safely using raw numeric inputs
    ROUND((Raw_Cumulative * 100.0 / Raw_Annual_Total), 2) AS Pct_Of_Annual_Target
FROM CalculatedWindows
ORDER BY Order_Date;

--7.3 Customer Lifetime Value (CLV) Ranking--
SELECT 
    Customer_ID,
    Customer_Name,
    Segment,
    MIN(Order_Date) AS First_Purchase,
    MAX(Order_Date) AS Last_Purchase,
    DATEDIFF(day, MIN(Order_Date), MAX(Order_Date)) AS Customer_Lifespan_Days,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    -- Scale to thousands, round to 2 decimal places, and format with $ and K
    CONCAT('$', ROUND(SUM(Sales) / 1000.0, 2), 'K') AS Lifetime_Value,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value,
    -- Keep the raw aggregate inside the window function for correct evaluation
    NTILE(4) OVER (ORDER BY SUM(Sales) DESC) AS CLV_Quartile  
FROM [SuperStore Sales DataSet]
GROUP BY Customer_ID, Customer_Name, Segment
-- Order by the raw numeric sum instead of the string alias
ORDER BY SUM(Sales) DESC; 

--7.4 Pareto Analysis (80/20 Rule)--
WITH ProductSales AS (
    SELECT 
        Product_ID,
        Product_Name,
        SUM(Sales) AS Total_Sales,
        ROW_NUMBER() OVER (ORDER BY SUM(Sales) DESC) AS Product_Rank,
        COUNT(*) OVER () AS Total_Products
    FROM [SuperStore Sales DataSet]
    GROUP BY Product_ID, Product_Name
),
CumulativeSales AS (
    SELECT 
        Product_ID,
        Product_Name,
        Total_Sales,
        Product_Rank,
        Total_Products,
        SUM(Total_Sales) OVER (ORDER BY Product_Rank) AS Running_Total,
        SUM(Total_Sales) OVER () AS Grand_Total
    FROM ProductSales
)
SELECT 
    Product_ID,
    Product_Name,
    Total_Sales,
    Product_Rank,
    ROUND((Product_Rank * 100.0 / Total_Products), 2) AS Pct_Of_Products,
    ROUND((Running_Total * 100.0 / Grand_Total), 2) AS Cumulative_Sales_Pct
FROM CumulativeSales
WHERE (Running_Total * 100.0 / Grand_Total) <= 80
ORDER BY Product_Rank;

--7.5 Discount Impact Analysis--
SELECT 
    CASE 
        WHEN Profit < 0 THEN 'Loss-Making'
        WHEN Profit = 0 THEN 'Break-Even'
        WHEN (Profit / Sales) * 100 < 10 THEN 'Low Margin (0-10%)'
        WHEN (Profit / Sales) * 100 < 25 THEN 'Healthy Margin (10-25%)'
        ELSE 'High Margin (25%+)'
    END AS Profitability_Band,
    COUNT(*) AS Product_Lines,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Profit / Sales) * 100, 2) AS Avg_Margin_Pct
FROM [SuperStore Sales DataSet]
GROUP BY 
    CASE 
        WHEN Profit < 0 THEN 'Loss-Making'
        WHEN Profit = 0 THEN 'Break-Even'
        WHEN (Profit / Sales) * 100 < 10 THEN 'Low Margin (0-10%)'
        WHEN (Profit / Sales) * 100 < 25 THEN 'Healthy Margin (10-25%)'
        ELSE 'High Margin (25%+)'
    END
ORDER BY Total_Sales DESC;
 





