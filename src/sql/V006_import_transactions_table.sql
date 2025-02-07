COPY transactions(id, device_id, product_name, product_sku, category_name, amount, status, created_at, happened_at)
FROM 'data/transaction_(2)_(1)_(1).csv'
DELIMITER ','
CSV HEADER;