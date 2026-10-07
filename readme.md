# Grocery Sales Dashboard

A complete data analytics project combining **SQL-based data analysis** and a **Power BI dashboard** for grocery sales performance across regions, customer segments, product categories, payment modes, and delivery operations.

---

## 📊 Overview

This project provides a comprehensive view of grocery sales performance through two complementary tools:

- **SQL Analysis** — Deep-dive queries covering KPIs, trends, segments, products, shipping, geography, and advanced analytics
- **Power BI Dashboard** — Interactive visualizations for executive-level insights

Together, they cover:

- **Sales KPIs** — Total sales, profit, quantity sold, and average delivery time
- **Regional Analysis** — Sales distribution across states and regions
- **Customer Segmentation** — Sales breakdown by Consumer, Corporate, and Home Office
- **Product Analysis** — Sales by category and sub-category
- **Payment Mode Analysis** — Sales distribution across COD, Online, and Cards
- **Shipping Analysis** — Sales by ship mode and delivery performance
- **Sales Forecasting** — 30-day forward-looking sales projection
- **Geographic Mapping** — State-level sales visualization
- **Advanced Analytics** — MoM growth, running totals, CLV, Pareto analysis, discount impact

---

## 📁 Files in This Repository

| File | Description |
|------|-------------|
| `Grocery Sales Dashboard.pbix` | Power BI dashboard file |
| `Grocery_Sales_Dashboard_Analysis.sql` | SQL queries for data extraction and analysis |
| `SuperStore Sales DataSet.xlsx` | Raw source dataset |
| `Grocery Sales Dashboard.pdf` | Exported PDF version of the dashboard |
| `README.md` | This file |

---

## 📈 Dashboard Contents

### Page 1 — Sales Performance Overview

#### KPI Cards
| Metric | Value |
|--------|-------|
| **Sales** | 2M |
| **Profit** | 175K |
| **Quantity** | 22K |
| **Avg Delivery** | 4 days |

#### Visualizations

1. **Sales by Region** (Donut Chart)
   - West: 33%
   - East: 29%
   - Central: 22%
   - South: 16%

2. **Sales by Segment** (Donut Chart)
   - Consumer: 48%
   - Corporate: 33%
   - Home Office: 19%

3. **Sales by Payment Mode** (Donut Chart)
   - COD: 43%
   - Online: 35%
   - Cards: 22%

4. **Sales by Ship Mode** (Bar Chart)
   - Standard Class: 0.33M
   - Second Class: 0.11M
   - First Class: 0.08M
   - Same Day: 0.03M

5. **Sales by Category** (Bar Chart)
   - Office Supplies: 0.64M
   - Furniture: 0.45M

6. **Sales by Sub-Category** (Bar Chart)
   - Phones: ~0.18M
   - Chairs: 0.18M
   - Binders: 0.17M

7. **Sales by State** (Bar Chart) — Page 2
   - Texas: 116K
   - Washington: 93K
   - Virginia: 33K
   - Tennessee: 26K
   - Wisconsin: 21K
   - Utah: 5K
   - Vermont: 4K
   - South Dakota: 2K
   - Wyoming: 2K
   - West Virginia: 1K

8. **Monthly Sales Trend** (Area Chart)
   - January through December
   - Year-over-year comparison: 2019 vs 2020

9. **Monthly Profit Trend** (Area Chart)
   - January through December
   - Year-over-year comparison: 2019 vs 2020

10. **Sales by Region** (Map Visual)
    - Geographic distribution across US states

---

### Page 2 — Forecasting & Geographic Detail

#### Visualizations

1. **Sales Forecast — 30 Days** (Line Chart)
   - Daily sales trend from Jan 2019 to Jan 2021
   - 30-day forward projection

2. **Sales Forecast — 30 Days** (Smoothed Line Chart)
   - Aggregated 30-day rolling forecast
   - Highlights seasonal patterns and trends

3. **Sales by State** (Horizontal Bar Chart)
   - Top 10 states by revenue
   - Color-coded by state

---

## 🗂️ Data Source

### Dataset: SuperStore Sales DataSet

| Column | Description |
|--------|-------------|
| Row ID | Unique row identifier |
| Order ID | Unique order identifier |
| Order Date | Date order was placed |
| Ship Date | Date order was shipped |
| Ship Mode | Shipping method (Standard Class, Second Class, First Class, Same Day) |
| Customer ID | Unique customer identifier |
| Customer Name | Customer full name |
| Segment | Customer segment (Consumer, Corporate, Home Office) |
| Country | Country of sale |
| City | City of sale |
| State | State of sale |
| Region | Region (West, East, Central, South) |
| Product ID | Unique product identifier |
| Category | Product category (Furniture, Office Supplies, Technology) |
| Sub-Category | Product sub-category |
| Product Name | Product full name |
| Sales | Sales amount |
| Quantity | Quantity sold |
| Profit | Profit amount |
| Returns | Return flag (Yes / #N/A) |
| Payment Mode | Payment method (COD, Online, Cards) |

### Data Coverage
- **Date Range:** 2019-01-01 to 2020-12-31
- **Records:** ~9,900 line items
- **Regions:** East, West, Central, South
- **Categories:** Furniture, Office Supplies, Technology
- **Sub-Categories:** 17 (Bookcases, Chairs, Tables, Furnishings, Binders, Paper, Labels, Storage, Art, Appliances, Envelopes, Fasteners, Supplies, Phones, Accessories, Copiers, Machines)

---

## 🗄️ SQL Analysis

The SQL analysis file (`Grocery_Sales_Dashboard_Analysis.sql`) contains **7 sections** with detailed queries that mirror the dashboard's visuals. It provides the raw numbers behind every chart.

### Section 1 — Sales Performance Analysis

| Query | Purpose |
|-------|---------|
| 1.1 | Overall Business KPIs (Sales, Profit, Quantity, Orders, Customers, Avg Delivery, Profit Margin) |
| 1.2 | Monthly Sales Trend (Sales, Profit, Orders by month) |
| 1.3 | Year-over-Year Growth (2019 vs 2020 comparison) |

### Section 2 — Customer Segment Analysis

| Query | Purpose |
|-------|---------|
| 2.1 | Sales & Profit by Segment (Consumer, Corporate, Home Office) |
| 2.2 | Top 10 Customers by Revenue |
| 2.3 | Customer Retention Analysis (One-Time, Occasional, Loyal, VIP) |

### Section 3 — Product Analysis

| Query | Purpose |
|-------|---------|
| 3.1 | Category & Sub-Category Performance |
| 3.2 | Top 10 Most Profitable Products |
| 3.3 | Loss-Making Products (Negative Profit) |
| 3.4 | Products Frequently Returned |

### Section 4 — Shipping & Logistics Analysis

| Query | Purpose |
|-------|---------|
| 4.1 | Sales by Ship Mode |
| 4.2 | Delivery Performance vs Ship Mode |
| 4.3 | Regional Delivery Performance |

### Section 5 — Geographic Analysis

| Query | Purpose |
|-------|---------|
| 5.1 | Sales by Region and State |
| 5.2 | Top 10 Cities by Revenue |
| 5.3 | Region Profitability Analysis |

### Section 6 — Payment & Operations Analysis

| Query | Purpose |
|-------|---------|
| 6.1 | Sales by Payment Mode |
| 6.2 | Payment Mode vs Profit Margin |

### Section 7 — Advanced Analytics

| Query | Purpose |
|-------|---------|
| 7.1 | Month-over-Month Growth Rate |
| 7.2 | Running Total of Sales (Cumulative Growth) |
| 7.3 | Customer Lifetime Value (CLV) Ranking |
| 7.4 | Pareto Analysis (80/20 Rule) |
| 7.5 | Discount Impact Analysis |

### SQL Techniques Used
- **Aggregations:** SUM, COUNT, AVG, DISTINCT COUNT
- **Window Functions:** LAG, RANK, NTILE, ROW_NUMBER, SUM() OVER()
- **CTEs (Common Table Expressions):** For multi-step calculations
- **Date Functions:** DATEDIFF, DATEFROMPARTS, YEAR, MONTH
- **Conditional Logic:** CASE WHEN for tiering and classification
- **String Formatting:** FORMAT, CONCAT for readable output

---

## 🔧 Setup & Usage

### Prerequisites

- **Power BI Desktop** (latest version)
- **Microsoft Excel** (for viewing the raw dataset)
- **SQL Server / Azure Data Studio / SSMS** (for running SQL queries)

### Steps to Open the Dashboard

1. Clone or download this repository
2. Open `Grocery Sales Dashboard.pbix` in Power BI Desktop
3. If prompted, update the data source path to point to `SuperStore Sales DataSet.xlsx`
4. Click **Refresh** to load the latest data

### Steps to Run the SQL Analysis

1. Open `Grocery_Sales_Dashboard_Analysis.sql` in SQL Server Management Studio (SSMS) or Azure Data Studio
2. Ensure the `[SuperStore Sales DataSet]` table is loaded in your database
3. Run individual queries by section:
   - **Section 1:** Sales Performance Analysis
   - **Section 2:** Customer Segment Analysis
   - **Section 3:** Product Analysis
   - **Section 4:** Shipping & Logistics Analysis
   - **Section 5:** Geographic Analysis
   - **Section 6:** Payment & Operations Analysis
   - **Section 7:** Advanced Analytics

---

## 📊 Key Insights

### Sales Performance
- **West region** leads with 33% of total sales
- **Consumer segment** is the largest customer group at 48%
- **COD (Cash on Delivery)** is the most popular payment mode at 43%
- **Standard Class** shipping accounts for the majority of sales

### Product Performance
- **Office Supplies** is the top category at 0.64M
- **Furniture** follows at 0.45M
- **Phones, Chairs, and Binders** are the top 3 sub-categories

### Geographic Performance
- **Texas** leads state-level sales at 116K
- **Washington** follows at 93K
- **Virginia** ranks third at 33K

### Delivery Performance
- Average delivery time is **4 days**
- Standard Class has the highest volume but slower delivery
- Same Day shipping has the lowest volume but fastest delivery

### Forecast
- The 30-day sales forecast shows **strong Q4 performance**
- Sales peak in **September and December**
- YoY comparison shows **2020 outperforming 2019** in most months

---

## 🎯 Use Cases

This project is useful for:

- **Sales Managers** — Track regional and segment performance
- **Product Managers** — Identify top-performing categories and sub-categories
- **Operations Teams** — Monitor delivery performance by ship mode
- **Finance Teams** — Analyze profit margins and payment mode distribution
- **Data Analysts** — Reference SQL queries for advanced analytics
- **Executives** — Get a high-level view of business KPIs and forecasts

---

## 🛠️ Technical Details

### Tools Used
- **Power BI Desktop** — Dashboard creation and visualization
- **SQL Server** — Data extraction and transformation
- **Microsoft Excel** — Raw data storage

### Data Transformations (SQL & Power BI)
- Date formatting (YYYY-MM-DD)
- Null handling (`#N/A` in Returns column treated as "not returned")
- Aggregations (SUM, COUNT, AVG, DISTINCT COUNT)
- Window functions (LAG, RANK, NTILE, ROW_NUMBER)
- Date functions (DATEDIFF, DATEFROMPARTS, YEAR, MONTH)

### DAX Measures (Power BI)
- Total Sales
- Total Profit
- Total Quantity
- Average Delivery Days
- YoY Growth %
- MoM Growth %
- Sales Share %
- Profit Margin %

### SQL Measures
- Raw and formatted totals (K/M notation)
- Running totals (cumulative sales)
- MoM and YoY growth percentages
- Rank within category (window function)
- CLV quartile ranking (NTILE)
- Pareto analysis (cumulative % of sales)
- Return rate percentage

---

## 📝 Changelog

### Version 2.0
- Updated dashboard to show full dataset (all regions)
- Corrected KPI values (Sales: 2M, Profit: 175K, Quantity: 22K)
- Fixed Region donut to show all 4 regions
- Updated Segment and Payment Mode distributions
- Aligned SQL analysis findings with dashboard visuals

### Version 1.0
- Initial dashboard release
- Added KPI cards, donut charts, bar charts, and map visuals
- Added 30-day sales forecast
- Added monthly sales and profit trends

---

## 🤝 Contributing

To contribute to this project:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📧 Contact

For questions or feedback:

- **Project Maintainer:** Muhammad Ayyaz
- **Email:** ayyazahmad7786@gmail.com
- **GitHub:** https://github.com/Muhammad9845

---

## 🙏 Acknowledgments

- Dataset source: SuperStore Sales DataSet
- Dashboard inspiration: Retail sales analytics best practices
- Built with: Power BI Desktop, SQL Server, Microsoft Excel

---

## 📸 Screenshots

### Page 1 — Sales Performance Overview
![Sales Performance](screenshots/page1_sales_performance.png)

### Page 2 — Forecasting & Geographic Detail
![Forecasting](screenshots/page2_forecasting.png)

---

## 🔗 Related Files

- [SQL Analysis File](Grocery_Sales_Dashboard_Analysis.sql)
- [Raw Dataset](SuperStore%20Sales%20DataSet.xlsx)
- [Dashboard PDF](Grocery%20Sales%20Dashboard.pdf)

---

**Last Updated:** [Current Date]**