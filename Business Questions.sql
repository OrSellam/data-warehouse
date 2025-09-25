USE olist;

### Q1: Names of the sellers involved in orders with at least 2 different products which one of them sold at least twice ###
SELECT s.seller_company_name, COUNT(DISTINCT f.order_id) AS num_orders,
MAX(f.order_purchase_timestamp) AS last_order_date
FROM olist.fact_order_items f
JOIN olist.dim_product p ON f.product_id = p.product_id
JOIN olist.dim_seller s ON f.seller_id = s.seller_id
WHERE f.order_id IN 
(
    SELECT order_id
    FROM olist.fact_order_items
    GROUP BY order_id
    HAVING COUNT(DISTINCT product_id) >= 2
       AND MAX(order_item_id) > 1
)
GROUP BY s.seller_id, s.seller_company_name
ORDER BY num_orders DESC;

### Q2: Top 5 cities with the highest customer payments###
SELECT c.customer_city, COUNT(*) AS num_orders, ROUND(SUM(f.price + f.freight_value) ,2) AS total_value
FROM olist.fact_order_items f
JOIN olist.dim_customer c ON f.customer_unique_id = c.customer_unique_id
JOIN  olist.dim_order o ON f.order_id = o.order_id
WHERE o.review_score >=4
AND f.price+ f.freight_value <=2000
GROUP BY c.customer_city
ORDER BY total_value DESC
LIMIT 5;




