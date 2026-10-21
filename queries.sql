-- Reports
-- date('now') is used as today's date for the overdue check

-- 1. Unpaid fees (invoices that still have a balance)
SELECT s.first_name || ' ' || s.last_name AS student,
       f.fee_name,
       ob.amount,
       ob.total_paid,
       ob.balance,
       ob.due_date
FROM outstanding_balances ob
JOIN students  s ON s.student_id  = ob.student_id
JOIN invoices  i ON i.invoice_id  = ob.invoice_id
JOIN fee_types f ON f.fee_type_id = i.fee_type_id
WHERE ob.balance > 0
ORDER BY ob.due_date;


-- 2. Payment history (newest first)
SELECT p.payment_id,
       p.payment_date,
       s.first_name || ' ' || s.last_name AS student,
       f.fee_name,
       p.amount_paid,
       p.method
FROM payments p
JOIN invoices  i ON i.invoice_id  = p.invoice_id
JOIN students  s ON s.student_id  = i.student_id
JOIN fee_types f ON f.fee_type_id = i.fee_type_id
ORDER BY p.payment_date DESC;

-- 2b. Payment history for one student (change the id)
SELECT p.payment_date, f.fee_name, p.amount_paid, p.method
FROM payments p
JOIN invoices  i ON i.invoice_id  = p.invoice_id
JOIN fee_types f ON f.fee_type_id = i.fee_type_id
WHERE i.student_id = 3
ORDER BY p.payment_date;


-- 3. Total collections
SELECT SUM(amount_paid) AS total_collected FROM payments;

-- 3b. Collections by fee type
SELECT f.fee_name, SUM(p.amount_paid) AS collected
FROM payments p
JOIN invoices  i ON i.invoice_id  = p.invoice_id
JOIN fee_types f ON f.fee_type_id = i.fee_type_id
GROUP BY f.fee_name
ORDER BY collected DESC;

-- 3c. Collections by payment method
SELECT method, COUNT(*) AS num_payments, SUM(amount_paid) AS collected
FROM payments
GROUP BY method;


-- 4. Overdue payments (past due date and not fully paid)
SELECT s.first_name || ' ' || s.last_name AS student,
       s.phone,
       f.fee_name,
       ob.balance,
       ob.due_date,
       CAST(julianday('now') - julianday(ob.due_date) AS INTEGER) AS days_overdue
FROM outstanding_balances ob
JOIN students  s ON s.student_id  = ob.student_id
JOIN invoices  i ON i.invoice_id  = ob.invoice_id
JOIN fee_types f ON f.fee_type_id = i.fee_type_id
WHERE ob.balance > 0
  AND ob.due_date < date('now')
ORDER BY days_overdue DESC;


-- 5. Outstanding balance per student
SELECT s.student_id,
       s.first_name || ' ' || s.last_name AS student,
       s.class,
       SUM(ob.amount)     AS total_billed,
       SUM(ob.total_paid) AS total_paid,
       SUM(ob.balance)    AS outstanding
FROM students s
JOIN outstanding_balances ob ON ob.student_id = s.student_id
GROUP BY s.student_id
ORDER BY outstanding DESC;


-- 6. Discounts given
SELECT s.first_name || ' ' || s.last_name AS student,
       f.fee_name,
       d.discount_name,
       d.percentage || '%' AS discount,
       f.amount - i.amount AS amount_saved
FROM invoices i
JOIN students  s ON s.student_id  = i.student_id
JOIN fee_types f ON f.fee_type_id = i.fee_type_id
JOIN discounts d ON d.discount_id = i.discount_id;
