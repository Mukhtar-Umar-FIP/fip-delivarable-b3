# AI Data-Quality Note

## How AI was used

I used an AI assistant (Claude) to help draft the table design, the sample data, the queries and the ERD. I checked everything it produced myself before submitting:

- Ran `schema.sql`, `seed.sql` and `queries.sql` on PostgreSQL 18. They all ran without errors.
- Checked the query results by hand against the sample data. For example, the total collections (₦227,500) matches the sum of the 9 payments, and the 5 overdue invoices are the ones with a balance whose due date has passed.
- Checked that each invoice amount with a discount is correct. For example, a ₦50,000 tuition fee with the 10% sibling discount gives ₦45,000.
- Made sure the sample data is made up. The names, phone numbers and emails are not real people.

## Data quality checks

`data_quality.sql` has 7 checks. Each one should return **0 rows**. If a check returns any rows, those records need fixing.

| # | Check | Why it matters |
|---|-------|----------------|
| 1 | Students with missing phone or email | We can't contact parents about unpaid fees |
| 2 | Zero or negative invoice/payment amounts | Wrong amounts break the totals |
| 3 | Overpaid invoices | Someone paid more than they owe, or a payment was recorded against the wrong invoice |
| 4 | Due date before issue date | The overdue report would be wrong |
| 5 | Payment made before the invoice was issued | Usually a wrong date was typed in |
| 6 | Invoice amount doesn't match fee minus discount | The student was charged the wrong amount |
| 7 | Same fee charged to a student twice | A duplicate invoice |

**Result:** On the sample data, all 7 checks returned 0 rows. To make sure the checks actually catch problems, I added some bad records on purpose: a student with no phone or email, a negative payment, an overpayment, a due date before the issue date, a payment made before its invoice, a wrong discount amount, and a duplicate invoice. Each check caught its problem. I then removed the bad records.

## Limitations

- The overdue report uses today's date (`CURRENT_DATE`), so its results change from day to day.
- The database does not block bad data on entry. The checks above have to be run to find it. A future improvement would be to add `CHECK` constraints (for example `amount > 0`).
