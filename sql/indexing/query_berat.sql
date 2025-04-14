EXPLAIN ANALYZE

-- query berat 1
SELECT 
    o.order_id,
    o.order_date,
    o.ship_city,
    d.product_id,
    d.unit_price,
    d.quantity
FROM 
    orders o
JOIN 
    order_details d ON o.order_id = d.order_id
WHERE 
    o.order_date BETWEEN '1996-01-01' AND '1998-12-31'
    AND d.unit_price > 50
ORDER BY 
    o.order_date DESC;