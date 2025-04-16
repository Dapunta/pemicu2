-- bawaan query
CREATE INDEX IF NOT EXISTS index_order_details_pk ON public.order_details USING btree (order_id);
CREATE INDEX IF NOT EXISTS index_order_pk ON public.orders USING btree (order_id);

-- query berat 1
CREATE INDEX IF NOT EXISTS idx_orders_ship_region ON orders(ship_region);
CREATE INDEX IF NOT EXISTS idx_order_details_unit_price ON order_details(unit_price);
CREATE INDEX IF NOT EXISTS idx_order_details_discount ON order_details(discount);
CREATE INDEX IF NOT EXISTS idx_orders_order_id ON orders(order_id);
CREATE INDEX IF NOT EXISTS idx_order_details_order_id ON order_details(order_id);
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_customers_customer_id ON customers(customer_id);
CREATE INDEX IF NOT EXISTS idx_orders_order_date ON orders(order_date);

-- query berat 2
CREATE INDEX IF NOT EXISTS idx_order_details_unit_price ON order_details(unit_price);
CREATE INDEX IF NOT EXISTS idx_order_details_product_id ON order_details(product_id);
CREATE INDEX IF NOT EXISTS idx_order_details_order_id ON order_details(order_id);
CREATE INDEX IF NOT EXISTS idx_products_product_id ON products(product_id);
CREATE INDEX IF NOT EXISTS idx_orders_order_id ON orders(order_id);
CREATE INDEX IF NOT EXISTS idx_order_details_total_expr ON order_details ((unit_price * quantity));
