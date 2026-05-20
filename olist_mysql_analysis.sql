USE olist_analysis;

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id)                        AS total_orders,
    COUNT(DISTINCT o.customer_id)                     AS unique_customers,
    ROUND(SUM(oi.price), 2)                           AS gross_revenue,
    ROUND(AVG(oi.price), 2)                           AS avg_item_price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY month;

USE olist_analysis;

SELECT
    p.product_category_name          AS category,
    COUNT(DISTINCT oi.order_id)      AS orders,
    ROUND(SUM(oi.price), 2)          AS total_revenue,
    ROUND(AVG(oi.price), 2)          AS avg_price,
    ROUND(AVG(r.review_score), 2)    AS avg_review_score
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 15;




USE olist_analysis;

WITH rfm_raw AS (
    SELECT
        o.customer_id,
        DATEDIFF('2018-09-01', MAX(o.order_purchase_timestamp)) AS recency_days,
        COUNT(DISTINCT o.order_id)                              AS frequency,
        ROUND(SUM(oi.price), 2)                                 AS monetary
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.customer_id
),
rfm_scored AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY recency_days DESC)  AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC)      AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC)       AS m_score
    FROM rfm_raw
)
SELECT
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3                   THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score <= 2                   THEN 'New Customers'
        WHEN r_score >= 3 AND m_score >= 3                   THEN 'Potential Loyalists'
        WHEN r_score <= 2 AND f_score >= 3                   THEN 'At Risk'
        WHEN r_score = 1  AND f_score = 1                    THEN 'Lost'
        ELSE 'Needs Attention'
    END AS segment,
    COUNT(*)                    AS customers,
    ROUND(AVG(recency_days), 0) AS avg_recency_days,
    ROUND(AVG(frequency), 2)    AS avg_orders,
    ROUND(AVG(monetary), 2)     AS avg_spend,
    ROUND(SUM(monetary), 2)     AS total_revenue
FROM rfm_scored
GROUP BY segment
ORDER BY total_revenue DESC;


USE olist_analysis;

SELECT
    CASE
        WHEN DATEDIFF(o.order_delivered_customer_date,
                      o.order_estimated_delivery_date) < 0  THEN 'Early'
        WHEN DATEDIFF(o.order_delivered_customer_date,
                      o.order_estimated_delivery_date) = 0  THEN 'On Time'
        WHEN DATEDIFF(o.order_delivered_customer_date,
                      o.order_estimated_delivery_date) <= 7 THEN 'Slightly Late (1-7d)'
        WHEN DATEDIFF(o.order_delivered_customer_date,
                      o.order_estimated_delivery_date) <= 14 THEN 'Late (8-14d)'
        ELSE 'Very Late (15d+)'
    END                             AS delivery_status,
    COUNT(*)                        AS orders,
    ROUND(AVG(r.review_score), 2)   AS avg_review_score,
    ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,
                       o.order_estimated_delivery_date)), 1) AS avg_delay_days
FROM orders o
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status
ORDER BY avg_delay_days;


USE olist_analysis;

SELECT
    op.payment_type,
    COUNT(*)                                AS transactions,
    ROUND(SUM(op.payment_value), 2)         AS total_value,
    ROUND(AVG(op.payment_value), 2)         AS avg_value,
    ROUND(AVG(op.payment_installments), 1)  AS avg_installments,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS share_pct
FROM order_payments op
GROUP BY op.payment_type
ORDER BY total_value DESC;


USE olist_analysis;

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id)              AS orders,
    COUNT(DISTINCT o.customer_id)           AS customers,
    ROUND(SUM(oi.price), 2)                 AS revenue,
    ROUND(AVG(oi.price), 2)                 AS avg_order_value,
    ROUND(AVG(r.review_score), 2)           AS avg_review_score
FROM customers c
JOIN orders o       ON c.customer_id  = o.customer_id
JOIN order_items oi ON o.order_id     = oi.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC;