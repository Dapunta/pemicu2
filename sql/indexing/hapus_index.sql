-- bawaan query
DROP INDEX IF EXISTS index_order_details_pk;
DROP INDEX IF EXISTS index_order_pk;

-- query berat 1
DROP INDEX IF EXISTS idx_orders_ship_region;
DROP INDEX IF EXISTS idx_order_details_unit_price;
DROP INDEX IF EXISTS idx_order_details_discount;
DROP INDEX IF EXISTS idx_orders_order_id;
DROP INDEX IF EXISTS idx_order_details_order_id;
DROP INDEX IF EXISTS idx_orders_customer_id;
DROP INDEX IF EXISTS idx_customers_customer_id;
DROP INDEX IF EXISTS idx_orders_order_date;

-- query berat 2
DROP INDEX IF EXISTS idx_order_details_unit_price;
DROP INDEX IF EXISTS idx_order_details_product_id;
DROP INDEX IF EXISTS idx_order_details_order_id;
DROP INDEX IF EXISTS idx_products_product_id;
DROP INDEX IF EXISTS idx_orders_order_id;
DROP INDEX IF EXISTS idx_order_details_total_expr;
