CREATE TABLE public.device (
    id          INT,
    type        INT CHECK (rating BETWEEN 1 AND 5),
    store_id    INT,
    CONSTRAINT device PRIMARY KEY(id)
);
