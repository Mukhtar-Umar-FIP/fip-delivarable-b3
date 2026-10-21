-- Data quality checks
-- Each query should return 0 rows. Any row returned is a problem to fix.

-- 1. Students with missing phone or email
SELECT student_id, first_name, last_name
FROM students
WHERE phone IS NULL OR email IS NULL;

-- 2. Invoices or payments with zero or negative amounts
SELECT 'invoice' AS record, invoice_id AS id, amount
FROM invoices
WHERE amount <= 0
UNION ALL
SELECT 'payment', payment_id, amount_paid
FROM payments
WHERE amount_paid <= 0;

-- 3. Overpaid invoices (paid more than the invoice amount)
SELECT invoice_id, amount, total_paid
FROM outstanding_balances
WHERE balance < 0;

-- 4. Invoices where the due date is before the issue date
SELECT invoice_id, issue_date, due_date
FROM invoices
WHERE due_date < issue_date;

-- 5. Payments made before the invoice was issued
SELECT p.payment_id, p.payment_date, i.issue_date
FROM payments p
JOIN invoices i ON i.invoice_id = p.invoice_id
WHERE p.payment_date < i.issue_date;

-- 6. Invoice amount does not match fee amount minus discount
SELECT i.invoice_id, f.amount AS fee_amount, d.percentage, i.amount
FROM invoices i
JOIN fee_types f ON f.fee_type_id = i.fee_type_id
LEFT JOIN discounts d ON d.discount_id = i.discount_id
WHERE i.amount <> f.amount * (1 - COALESCE(d.percentage, 0) / 100);

-- 7. Same fee charged to the same student more than once
SELECT student_id, fee_type_id, COUNT(*) AS times
FROM invoices
GROUP BY student_id, fee_type_id
HAVING COUNT(*) > 1;
