1. Unpaid fees
SELECT s.first_name, s.last_name, ob.invoice_id, ob.balance
FROM outstanding_balances ob
JOIN students s ON s.student_id = ob.student_id
WHERE ob.balance > 0
ORDER BY s.first_name;

2. Payment history
SELECT s.first_name, s.last_name, p.amount_paid, p.payment_date, p.method
FROM payments p
JOIN invoices i ON i.invoice_id = p.invoice_id
JOIN students s ON s.student_id = i.student_id
ORDER BY p.payment_date;

3. Payment history for one student
SELECT p.payment_date, p.amount_paid, p.method
FROM payments p
JOIN invoices i ON i.invoice_id = p.invoice_id
WHERE i.student_id = 3;

4. Total collections
SELECT SUM(amount_paid) AS total_collected
FROM payments;

5. Total collections by payment method
SELECT method, SUM(amount_paid) AS total_collected
FROM payments
GROUP BY method;

6. Overdue payments
SELECT s.first_name, s.last_name, ob.balance, ob.due_date
FROM outstanding_balances ob
JOIN students s ON s.student_id = ob.student_id
WHERE ob.balance > 0
  AND ob.due_date < CURRENT_DATE
ORDER BY ob.due_date;

7. Outstanding balance per student
SELECT s.first_name, s.last_name, SUM(ob.balance) AS outstanding
FROM students s
JOIN outstanding_balances ob ON ob.student_id = s.student_id
GROUP BY s.first_name, s.last_name
ORDER BY outstanding DESC;

8. Invoices with discounts
SELECT s.first_name, s.last_name, d.discount_name, d.percentage, i.amount
FROM invoices i
JOIN students s  ON s.student_id  = i.student_id
JOIN discounts d ON d.discount_id = i.discount_id;
