-- sales hanya bisa SELECT pada table `products`
SELECT COUNT(*) FROM products;  -- bisa
SELECT COUNT(*) FROM suppliers; -- tidak bisa
SELECT COUNT(*) FROM orders;    -- tidak bisa

