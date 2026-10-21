# AI Data-Quality Note

## 1. Purpose

AI was used to help review the sample payment records for possible data-quality issues.

## 2. Data-Quality Checks

The following issues were considered:

- **Missing values:** Payments without an invoice ID, amount or payment date.
- **Duplicate records:** The same payment recorded more than once.
- **Invalid values:** Negative payment amounts or payment methods other than Cash, Transfer or POS.
- **Inconsistency:** Different date formats, amount formats or payment method labels.
- **Referential integrity:** Payments linked to invoices that do not exist, or invoices linked to students that do not exist.

## 3. Findings

No issues were found in the final sample data.

- **Missing values:** None. Key columns are `NOT NULL`.
- **Duplicate records:** None. No two payments share the same invoice, amount and date.
- **Invalid values:** None. All amounts are above 0 and all methods are Cash, Transfer or POS.
- **Inconsistency:** None. Dates are stored as `DATE` (YYYY-MM-DD), amounts as `NUMERIC(10,2)` in Naira, and method labels are spelled the same way throughout.
- **Referential integrity:** None. Every payment points to a real invoice and every invoice points to a real student.

To confirm the database blocks bad data, some wrong records were inserted as a test: a payment of -500, a payment method of "Cheque", a payment for an invoice that does not exist, an invoice with a due date before its issue date, and a payment with no amount. The database rejected all of them.

## 4. Role of AI

AI helped by suggesting data-quality checks and reviewing the data for possible problems. SQL constraints (`NOT NULL`, `CHECK`, `FOREIGN KEY`) and queries were used to validate the data.

## 5. Limitations

AI-generated findings may contain errors. All findings were checked against the database records before being accepted.

## 6. Conclusion

Data-quality checks make payment records more accurate, consistent and reliable. AI supports the process but does not replace checking the data yourself.
