-- query berat 1
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_order_details_unit_price ON order_details(unit_price);
CREATE INDEX idx_order_details_order_id ON order_details(order_id);