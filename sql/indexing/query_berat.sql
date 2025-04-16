EXPLAIN ANALYZE

-- query berat 1
SELECT 
    o.order_id,
    o.order_date,
    o.ship_region,
    c.company_name,
    d.product_id,
    d.unit_price,
    d.quantity,
    d.discount
FROM orders o
JOIN order_details d ON o.order_id = d.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE 
    (o.ship_region IS NULL
     OR o.ship_region ILIKE 'null'
     OR o.ship_region = '')
  AND o.order_date BETWEEN '1996-01-01' AND '1998-01-01'
  AND d.unit_price > 100
  AND d.discount > 0.2
ORDER BY o.order_date DESC;

-- query berat 2
SELECT 
    o.order_id,
    o.order_date,
    p.product_name,
    d.unit_price,
    d.quantity,
    d.unit_price * d.quantity AS total
FROM orders o
JOIN order_details d ON o.order_id = d.order_id
JOIN products p ON d.product_id = p.product_id
WHERE d.unit_price > 50
ORDER BY total DESC
LIMIT 50;
