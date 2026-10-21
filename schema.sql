-- School Fees Management Database (PostgreSQL)
-- Tables: students, fee_types, discounts, invoices, payments

DROP VIEW IF EXISTS outstanding_balances;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS discounts;
DROP TABLE IF EXISTS fee_types;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id   SERIAL PRIMARY KEY,
    first_name   VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    class        VARCHAR(20)  NOT NULL,
    phone        VARCHAR(20),
    email        VARCHAR(100)
);

CREATE TABLE fee_types (
    fee_type_id  SERIAL PRIMARY KEY,
    fee_name     VARCHAR(50)   NOT NULL,
    amount       NUMERIC(10,2) NOT NULL
);

CREATE TABLE discounts (
    discount_id   SERIAL PRIMARY KEY,
    discount_name VARCHAR(50)  NOT NULL,
    percentage    NUMERIC(5,2) NOT NULL   -- e.g. 10 means 10%
);

-- one invoice = one fee charged to one student
CREATE TABLE invoices (
    invoice_id   SERIAL PRIMARY KEY,
    student_id   INT NOT NULL REFERENCES students(student_id),
    fee_type_id  INT NOT NULL REFERENCES fee_types(fee_type_id),
    discount_id  INT REFERENCES discounts(discount_id),  -- NULL if no discount
    amount       NUMERIC(10,2) NOT NULL,                 -- amount after discount
    issue_date   DATE NOT NULL,
    due_date     DATE NOT NULL
);

CREATE TABLE payments (
    payment_id   SERIAL PRIMARY KEY,
    invoice_id   INT NOT NULL REFERENCES invoices(invoice_id),
    amount_paid  NUMERIC(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    method       VARCHAR(20)              -- Cash, Transfer, POS
);

-- balance left on every invoice
CREATE VIEW outstanding_balances AS
SELECT i.invoice_id,
       i.student_id,
       i.amount,
       COALESCE(SUM(p.amount_paid), 0)            AS total_paid,
       i.amount - COALESCE(SUM(p.amount_paid), 0) AS balance,
       i.due_date
FROM invoices i
LEFT JOIN payments p ON p.invoice_id = i.invoice_id
GROUP BY i.invoice_id;
