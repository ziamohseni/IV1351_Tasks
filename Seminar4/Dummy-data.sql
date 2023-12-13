-- Dummy data for student table
INSERT INTO student (person_number, first_name, last_name, enrollment_date, rental_limit, instrument_skill_level, email_address)
VALUES
('1234567890', 'Alice', 'Smith', '2023-01-10', 2, 'Beginner', 'alice.smith@email.com'),
('1234567891', 'Bob', 'Johnson', '2023-02-15', 2, 'Intermediate', 'bob.johnson@email.com'),
('1234567892', 'Carol', 'Williams', '2023-03-20', 2, 'Advanced', 'carol.williams@email.com'),
('1234567893', 'David', 'Brown', '2023-04-25', 2, 'Beginner', 'david.brown@email.com'),
('1234567894', 'Eve', 'Davis', '2023-05-30', 2, 'Intermediate', 'eve.davis@email.com'),
('1234567895', 'Frank', 'Miller', '2023-06-04', 2, 'Advanced', 'frank.miller@email.com'),
('1234567896', 'Grace', 'Wilson', '2023-07-09', 2, 'Beginner', 'grace.wilson@email.com'),
('1234567897', 'Henry', 'Moore', '2023-08-14', 2, 'Intermediate', 'henry.moore@email.com'),
('1234567898', 'Isabel', 'Taylor', '2023-09-19', 2, 'Advanced', 'isabel.taylor@email.com'),
('1234567899', 'Jack', 'Anderson', '2023-10-24', 2, 'Beginner', 'jack.anderson@email.com');

-- Dummy data for instrument table
INSERT INTO instrument (instrument_type, instrument_brand, instrument_price, is_available)
VALUES
('Guitar', 'Yamaha', 1200.00, TRUE),
('Piano', 'Steinway', 5000.00, TRUE),
('Violin', 'Gibson', 800.00, TRUE),
('Drums', 'Roland', 1500.00, TRUE),
('Guitar', 'Kawai', 600.00, TRUE),
('Guitar', 'Fender', 1100.00, TRUE),
('Piano', 'Yamaha', 3000.00, TRUE),
('Violin', 'Ibanez', 900.00, TRUE),
('Drums', 'Taylor', 1400.00, TRUE),
('Guitar', 'Martin', 550.00, TRUE),
('Guitar', 'Gibson', 1300.00, TRUE),
('Piano', 'Casio', 4000.00, TRUE),
('Violin', 'Yamaha', 850.00, TRUE),
('Drums', 'Fender', 1600.00, TRUE),
('Guitar', 'Steinway', 700.00, TRUE),
('Guitar', 'Martin', 1000.00, TRUE),
('Piano', 'Roland', 4500.00, TRUE),
('Violin', 'Taylor', 750.00, TRUE),
('Drums', 'Ibanez', 1550.00, TRUE),
('Guitar', 'Gibson', 650.00, TRUE);
