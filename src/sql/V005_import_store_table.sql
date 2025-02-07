COPY device(id, name, address, city, country, created_at, typology, customer_id)
FROM 'data/store_(2)_(1).csv'
DELIMITER ','
CSV HEADER;