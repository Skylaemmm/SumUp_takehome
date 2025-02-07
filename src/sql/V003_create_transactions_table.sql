CREATE TABLE private.transactions (
    id                  INTEGER,
    device_id           INTEGER,
    product_name        VARCHAR(100),
    product_sku         VARCHAR(100),
    category_name       VARCHAR(50),
    amount              DECIMAL(10, 2),
    status              VARCHAR(50),
    created_at          TIMESTAMP NOT NULL DEFAULT clock_timestamp(),
    happened_at         TIMESTAMP NOT NULL DEFAULT clock_timestamp(),
    CONSTRAINT transactions PRIMARY KEY(id)
);
