INSERT INTO students VALUES
(1, 'Aisha',   'Bello',  'JSS1', '08031234567', 'aisha.bello@mail.com'),
(2, 'Ibrahim', 'Musa',   'JSS2', '08029876543', 'ibrahim.musa@mail.com'),
(3, 'Chinedu', 'Okafor', 'SS1',  '07065432198', 'chinedu.o@mail.com'),
(4, 'Fatima',  'Sani',   'SS2',  '08123456789', 'fatima.sani@mail.com');

INSERT INTO fee_types VALUES
(1, 'Tuition',   50000.00),
(2, 'Exam Fee',  10000.00),
(3, 'Transport', 20000.00);

INSERT INTO discounts VALUES
(1, 'Sibling Discount', 10),
(2, 'Scholarship',      50);

INSERT INTO invoices VALUES
(1, 1, 1, NULL, 50000.00, '2026-09-01', '2026-09-30'),
(2, 1, 2, NULL, 10000.00, '2026-09-01', '2026-11-30'),
(3, 2, 1, 1,    45000.00, '2026-09-01', '2026-09-30'),
(4, 3, 1, 2,    25000.00, '2026-09-01', '2026-09-30'),
(5, 4, 1, NULL, 50000.00, '2026-09-01', '2026-09-30'),
(6, 4, 3, NULL, 20000.00, '2026-09-01', '2026-10-15');

INSERT INTO payments VALUES
(1, 1, 50000.00, '2026-09-10', 'Transfer'),
(2, 3, 20000.00, '2026-09-20', 'POS'),
(3, 4, 10000.00, '2026-09-15', 'Cash'),
(4, 4, 15000.00, '2026-09-28', 'Transfer'),
(5, 5, 30000.00, '2026-09-18', 'Cash');
