# School Fees Management Database

Weekly deliverable (B3). A simple database for managing students, fee types, invoices, payments, discounts and outstanding balances.

Built with **SQLite**, so no server is needed.

## Files

| File | What it is |
|------|------------|
| `schema.sql` | Creates the tables and the `outstanding_balances` view |
| `seed.sql` | Sample data (6 students, 4 fee types, 3 discounts, 11 invoices, 9 payments) |
| `queries.sql` | Report queries |
| `school_fees.db` | Ready-made database with the sample data loaded |
| `erd.png` | ERD diagram |

## ERD

![ERD](erd.png)

## Tables

- **students** – student details
- **fee_types** – the kinds of fees and their standard amount (Tuition, Exam Fee, Uniform, Transport)
- **discounts** – discount name and percentage (Sibling, Scholarship, Staff Child)
- **invoices** – a fee charged to a student, with an optional discount and a due date. `amount` is the amount after discount
- **payments** – money paid against an invoice. An invoice can be paid in parts

**Relationships**

- One student has many invoices
- One fee type appears on many invoices
- One discount can be used on many invoices (an invoice has zero or one discount)
- One invoice has many payments

**View:** `outstanding_balances` shows each invoice's amount, how much has been paid and the balance left.

## Queries (in `queries.sql`)

1. **Unpaid fees** – invoices with a balance greater than 0
2. **Payment history** – all payments, and payments for a single student
3. **Total collections** – overall total, by fee type and by payment method
4. **Overdue payments** – unpaid invoices past their due date, with days overdue
5. **Outstanding balance per student**
6. **Discounts given**

## How to run

Using the sqlite3 command line:

```bash
sqlite3 school_fees.db < schema.sql
sqlite3 school_fees.db < seed.sql
sqlite3 -header -column school_fees.db < queries.sql
```

Or open `school_fees.db` in [DB Browser for SQLite](https://sqlitebrowser.org/) and run the queries from `queries.sql` in the "Execute SQL" tab.

> Note: the overdue query uses `date('now')`, so the results depend on the day you run it.
