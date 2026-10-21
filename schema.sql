-- School Fees Management Database
-- Tables: students, fee_types, discounts, invoices, payments

DROP VIEW IF EXISTS outstanding_balances;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS discounts;
DROP TABLE IF EXISTS fee_types;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id   INTEGER PRIMARY KEY,
    first_name   VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    class        VARCHAR(20)  NOT NULL,
    phone        VARCHAR(20),
    email        VARCHAR(100)
);

CREATE TABLE fee_types (
    fee_type_id  INTEGER PRIMARY KEY,
    fee_name     VARCHAR(50)   NOT NULL,
    amount       DECIMAL(10,2) NOT NULL
);

CREATE TABLE discounts (
    discount_id   INTEGER PRIMARY KEY,
    discount_name VARCHAR(50)  NOT NULL,
    percentage    DECIMAL(5,2) NOT NULL   -- e.g. 10 means 10%
);

-- one invoice = one fee charged to one student
CREATE TABLE invoices (
    invoice_id   INTEGER PRIMARY KEY,
    student_id   INTEGER NOT NULL,
    fee_type_id  INTEGER NOT NULL,
    discount_id  INTEGER,                 -- NULL if no discount
    amount       DECIMAL(10,2) NOT NULL,  -- amount after discount
    issue_date   DATE NOT NULL,
    due_date     DATE NOT NULL,
    FOREIGN KEY (student_id)  REFERENCES students(student_id),
    FOREIGN KEY (fee_type_id) REFERENCES fee_types(fee_type_id),
    FOREIGN KEY (discount_id) REFERENCES discounts(discount_id)
);

CREATE TABLE payments (
    payment_id   INTEGER PRIMARY KEY,
    invoice_id   INTEGER NOT NULL,
    amount_paid  DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    method       VARCHAR(20),             -- Cash, Transfer, POS
    FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id)
);

-- balance left on every invoice
CREATE VIEW outstanding_balances AS
SELECT i.invoice_id,
       i.student_id,
       i.amount,
       IFNULL(SUM(p.amount_paid), 0)            AS total_paid,
       i.amount - IFNULL(SUM(p.amount_paid), 0) AS balance,
       i.due_date
FROM invoices i
LEFT JOIN payments p ON p.invoice_id = i.invoice_id
GROUP BY i.invoice_id;
