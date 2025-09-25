# Olist Data Warehouse for Product and Customer Analytics

## Project Overview
This project involves the design and implementation of a **data warehouse** for Olist, an e-commerce platform, to enable advanced **product and customer analytics**. The original operational database is large, consisting of 9+ tables and numerous columns, optimized for transactional processes (OLTP). 

The data warehouse supports multidimensional analysis and allows executing complex business queries without affecting operational systems.

---

## Recommended Design Pattern
For the fact table, a **Transaction-based design** was chosen:
- Each row represents a single event, such as a purchase or order item.
- Provides granularity at the **item-level within an order**.
- Supports queries requiring detailed information on items in orders.
- Accumulative and Periodic snapshots were avoided, as analysis requires item-level granularity.

---

## Star Schema Components
- **Fact Table**: `fact_order_items`
  - Tracks individual order items, including quantities, prices, and related identifiers.
- **Dimension Tables**:
  - `dim_product` – enriched with product and category attributes.
  - `dim_customer` – customer demographic and behavioral information.
  - `dim_seller` – seller-related information.
  - `dim_order` – enriched with payment type, review score, and order-level attributes.
  - `dim_date` – order and purchase timestamps for temporal analysis.

### Granularity
- **Item-level granularity** was chosen to allow detailed analysis of products, customers, and sellers.
- Supports multidimensional queries across all dimensions and enables precise business insights.

---

## ETL Process
The ETL process prepared raw Olist CSV files into the structured data warehouse, split into three main stages:

### 1. Extract
- Collected all raw CSV files into a centralized location.
- Performed initial data exploration to identify duplicates, missing values, and inconsistencies.

### 2. Transform
- Removed duplicate rows and standardized date columns.
- Filled missing values for keys and product identifiers where possible.
- Corrected city names, state formats, and applied regional mappings.
- Denormalized data by combining relevant fields from multiple tables to reduce joins:
  - Example: product category name was added directly to the product dimension, and review score & payment type were integrated into the order dimension.

### 3. Load
- Loaded transformed data into MySQL.
- Created relationships between fact and dimension tables.
- Updated foreign keys in the fact table to ensure referential integrity.

---

## Business Questions Using MySQL
The data warehouse enables answering key strategic business questions efficiently. Some examples include:

1. **Seller Performance Analysis**
   - Identify sellers involved in orders containing multiple products, where at least one product was sold in multiple quantities.
   - This analysis provides insights into top-performing sellers and their contribution to complex orders, supporting strategic partnership and inventory decisions.

2. **Customer Spending and Regional Trends**
   - Determine the top cities based on total customer payments, considering order values and review scores.
   - Helps identify high-value markets, regional demand patterns, and opportunities for targeted marketing campaigns.

These types of analyses demonstrate the value of a **transactional fact table** combined with enriched dimensions, allowing the business to answer complex questions at a detailed, item-level granularity.

---

## Key Benefits
- Enables faster analytical queries without impacting operational systems.
- Improves strategic decision-making with enriched, multidimensional data.
- Provides flexibility for future analyses and integration of new metrics or data sources.
- Supports both high-level reporting and granular, item-level investigations.

---

## Tools & Technologies
- **Python** – for ETL transformations and data cleaning.
- **MySQL** – for querying the data warehouse.
- **Pandas / NumPy** – for data manipulation.
- **Jupyter Notebook** – for ETL workflow and testing.

---

This project showcases the implementation of a robust data warehouse, structured for advanced analytics, demonstrating the ability to transform raw operational data into actionable business insights.
