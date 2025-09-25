# Olist Data Warehouse for Product and Customer Analytics

## Project Overview
This project involves the design and implementation of a **data warehouse** for Olist, an e-commerce platform, to enable advanced **product and customer analytics**. The original operational database is large, consisting of 9+ tables and numerous columns, optimized for transactional processes (OLTP). 


## Recommended Design Pattern
For the fact table, we recommended a **Transaction-based design**:
- Each row represents a single event, such as a purchase or order item
- Provides granularity at the **item-level within an order**
- Supports queries that require detailed information on items in orders (e.g., multiple items per order, items priced under $2000)
- Avoided Accumulative and Periodic snapshots since analysis requires item-level granularity rather than summaries over time


### Star Schema Components
- **Fact Table**: `fact_order_items`
  - Columns: `order_id`, `order_item_id`, `product_id`, `price`, `freight_value`, `seller_id`, `customer_id`, `order_purchase_timestamp`, `order_date`
- **Dimension Tables**:
  - `dim_product` – enriched with product and category attributes
  - `dim_customer` – customer demographic and behavior information
  - `dim_seller` – seller-related information
  - `dim_order` – enriched with payment type, review score, and order-level attributes
  - `dim_date` – order and purchase timestamps for temporal analysis

### Granularity
- **Item-level granularity** was chosen
- Supports detailed analysis of product, customer, and seller interactions
- Enables multidimensional queries across all dimensions

## ETL Process
The ETL process prepared raw Olist CSV files into the structured data warehouse, split into three main stages:

### 1. Extract
- Collected all raw CSV files into a centralized location
- Performed initial data exploration to identify duplicates, missing values, and inconsistencies

### 2. Transform
- Removed duplicate rows and standardized date columns
- Filled missing values for keys and `product_id` where possible
- Corrected city names and state formats
- Denormalized data by combining relevant fields from multiple tables to reduce joins:
  - Added `product_category_name_english` to `dim_product`
  - Added `review_score` and `payment_type` to `dim_order`

### 3. Load
- Loaded transformed data into MySQL
- Created relationships between fact and dimension tables
- Updated foreign keys in the fact table to ensure referential integrity

## Key Benefits
- Faster analytical queries without affecting operational systems
- Improved strategic decision-making with enriched, multidimensional data
- Flexible structure allows future analysis of new metrics or data sources

## Tools & Technologies
- **Python** - for ETL transformations and data cleaning
- **MySQL** - for querying the data warehouse
- **Pandas / NumPy** - for data manipulation
- **Jupyter Notebook** - for ETL workflow and testing
