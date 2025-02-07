CREATE TABLE public.store (
    id              INTEGER,
    name            VARCHAR(255),
    address         VARCHAR(255),
    city            VARCHAR(100),
    country         VARCHAR(100),
    created_at      TIMESTAMP NOT NULL DEFAULT clock_timestamp(),
    typology        VARCHAR(50),
    customer_id     INTEGER,
    CONSTRAINT device PRIMARY KEY(id)
);
