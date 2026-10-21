-- Sample data

INSERT INTO students VALUES
(1, 'Aisha',   'Bello',   'JSS1', '08031234567', 'aisha.bello@mail.com'),
(2, 'Ibrahim', 'Musa',    'JSS2', '08029876543', 'ibrahim.musa@mail.com'),
(3, 'Chinedu', 'Okafor',  'SS1',  '07065432198', 'chinedu.o@mail.com'),
(4, 'Fatima',  'Sani',    'SS2',  '08123456789', 'fatima.sani@mail.com'),
(5, 'Tunde',   'Adeyemi', 'JSS3', '09011223344', 'tunde.a@mail.com'),
(6, 'Zainab',  'Yusuf',   'SS3',  '08099887766', 'zainab.y@mail.com');

INSERT INTO fee_types VALUES
(1, 'Tuition',   50000.00),
(2, 'Exam Fee',  10000.00),
(3, 'Uniform',   15000.00),
(4, 'Transport', 20000.00);

INSERT INTO discounts VALUES
(1, 'Sibling Discount', 10),
(2, 'Scholarship',      50),
(3, 'Staff Child',      25);

-- amount = fee amount minus discount
INSERT INTO invoices VALUES
(1,  1, 1, NULL, 50000.00, '2026-09-01', '2026-09-30'),
(2,  1, 2, NULL, 10000.00, '2026-09-01', '2026-10-15'),
(3,  2, 1, 1,    45000.00, '2026-09-01', '2026-09-30'),
(4,  2, 4, NULL, 20000.00, '2026-09-01', '2026-09-30'),
(5,  3, 1, 2,    25000.00, '2026-09-01', '2026-09-30'),
(6,  3, 3, NULL, 15000.00, '2026-09-05', '2026-11-30'),
(7,  4, 1, NULL, 50000.00, '2026-09-01', '2026-09-30'),
(8,  4, 2, NULL, 10000.00, '2026-09-01', '2026-10-15'),
(9,  5, 1, 3,    37500.00, '2026-09-01', '2026-09-30'),
(10, 6, 1, NULL, 50000.00, '2026-09-01', '2026-09-30'),
(11, 6, 4, NULL, 20000.00, '2026-09-01', '2026-12-15');

INSERT INTO payments VALUES
(1, 1,  50000.00, '2026-09-10', 'Transfer'),
(2, 2,   5000.00, '2026-10-01', 'Cash'),
(3, 3,  45000.00, '2026-09-20', 'POS'),
(4, 5,  10000.00, '2026-09-15', 'Cash'),
(5, 5,  15000.00, '2026-09-28', 'Transfer'),
(6, 7,  20000.00, '2026-09-25', 'Transfer'),
(7, 9,  37500.00, '2026-09-12', 'Transfer'),
(8, 10, 30000.00, '2026-09-18', 'POS'),
(9, 6,  15000.00, '2026-10-05', 'Cash');
