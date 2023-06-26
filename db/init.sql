CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE,
  phone_number VARCHAR(20)
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  date TIMESTAMP NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  description TEXT,
  customer_id INTEGER,
  FOREIGN KEY (customer_id) REFERENCES customers (id)
);

CREATE OR REPLACE FUNCTION populate_tables(num_transactions INTEGER)
RETURNS VOID AS $$
DECLARE
  i INTEGER := 1;
  max_customers INTEGER := 10000;
  actual_customers INTEGER;
BEGIN
  -- Reset sequence for customers.id column
  ALTER SEQUENCE customers_id_seq RESTART WITH 1;

  -- Generate random customer data
  INSERT INTO customers (id, first_name, last_name, email, phone_number)
  SELECT
    nextval('customers_id_seq'),
    'Customer' || c,
    'Lastname' || c,
    concat('customer', c, '@example.com'),
    concat('555-', floor(random() * 900 + 100)::integer, '-', floor(random() * 9000 + 1000)::integer)
  FROM generate_series(1, max_customers) AS c
  ON CONFLICT DO NOTHING;

  -- Generate random transaction data
  INSERT INTO transactions (date, amount, description, customer_id)
  SELECT
    now() - (random() * interval '365 days'),
    (random() * 1000 + 1)::numeric(10, 2),
    'Transaction ' || t,
    (CAST(FLOOR(random() * max_customers) AS INTEGER) % max_customers + 1)::integer
  FROM generate_series(1, num_transactions) AS t;

  RETURN;
END;
$$ LANGUAGE plpgsql;

