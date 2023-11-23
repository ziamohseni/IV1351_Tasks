INSERT INTO address (street, zip, city) VALUES
('123 Elm St', '12345', 'Springfield'),
('456 Oak St', '12346', 'Springfield'),
('789 Pine St', '12347', 'Springfield'),
('101 Maple Ave', '12348', 'Springfield'),
('202 Birch Ln', '12349', 'Springfield'),
('303 Cedar Rd', '12350', 'Springfield'),
('404 Dogwood Dr', '12351', 'Springfield'),
('505 Fir Ct', '12352', 'Springfield'),
('606 Hickory St', '12353', 'Springfield'),
('707 Ivy Blvd', '12354', 'Springfield');

INSERT INTO contact_person (full_name, phone_number, email_address, relationship) VALUES
('John Doe', '555-0001', 'john.doe@example.com', 'Father'),
('Jane Smith', '555-0002', 'jane.smith@example.com', 'Mother'),
('Alice Johnson', '555-0003', 'alice.johnson@example.com', 'Guardian'),
('Bob Williams', '555-0004', 'bob.williams@example.com', 'Uncle'),
('Carol Davis', '555-0005', 'carol.davis@example.com', 'Aunt'),
('Dave Wilson', '555-0006', 'dave.wilson@example.com', 'Grandfather'),
('Eve Brown', '555-0007', 'eve.brown@example.com', 'Grandmother'),
('Frank Miller', '555-0008', 'frank.miller@example.com', 'Brother'),
('Grace Lee', '555-0009', 'grace.lee@example.com', 'Sister'),
('Henry White', '555-0010', 'henry.white@example.com', 'Friend');


INSERT INTO instrument (instrument_type, brand, quantity_in_stock, price) VALUES
('Guitar', 'Gibson', 5, 1000.00),
('Guitar', 'Fender', 4, 900.00),
('Piano', 'Steinway', 2, 5000.00),
('Piano', 'Yamaha', 3, 4500.00),
('Violin', 'Steinway', 6, 1500.00),
('Violin', 'Yamaha', 4, 1400.00),
('Drums', 'Roland', 3, 800.00),
('Drums', 'Yamaha', 5, 850.00),
('Other', 'Kawai', 7, 600.00),
('Other', 'Casio', 6, 550.00);


INSERT INTO phone (phone_number) VALUES
('555-1001'),
('555-1002'),
('555-1003'),
('555-1004'),
('555-1005'),
('555-1006'),
('555-1007'),
('555-1008'),
('555-1009'),
('555-1010');


INSERT INTO price_info (lesson_type, base_price, lesson_skill_level, valid_from) VALUES
('Individual', 50.00, 'Beginner', '2023-01-01'),
('Individual', 60.00, 'Intermediate', '2023-01-01'),
('Group', 35.00, 'Beginner', '2023-01-01'),
('Group', 45.00, 'Intermediate', '2023-01-01'),
('Ensemble', 40.00, 'Beginner', '2023-01-01'),
('Ensemble', 50.00, 'Intermediate', '2023-01-01'),
('Individual', 70.00, 'Advanced', '2023-01-01'),
('Group', 55.00, 'Advanced', '2023-01-01'),
('Ensemble', 60.00, 'Advanced', '2023-01-01'),
('Individual', 65.00, 'Advanced', '2023-01-01');


INSERT INTO student (student_school_id, enrollment_date, rental_limit, contact_person_id, instrument_skill_level, person_number, first_name, last_name, email_address) VALUES
('S1001', '2023-01-01', 3, 1, 'Beginner', 'P1001', 'Alice', 'Johnson', 'alice.johnson@example.com'),
('S1002', '2023-01-02', 2, 2, 'Intermediate', 'P1002', 'Bob', 'Smith', 'bob.smith@example.com'),
('S1003', '2023-01-03', 2, 3, 'Advanced', 'P1003', 'Charlie', 'Brown', 'charlie.brown@example.com'),
('S1004', '2023-01-04', 1, 4, 'Beginner', 'P1004', 'Diana', 'Ross', 'diana.ross@example.com'),
('S1005', '2023-01-05', 3, 5, 'Intermediate', 'P1005', 'Evan', 'Williams', 'evan.williams@example.com'),
('S1006', '2023-01-06', 2, 6, 'Advanced', 'P1006', 'Fiona', 'Green', 'fiona.green@example.com'),
('S1007', '2023-01-07', 1, 7, 'Beginner', 'P1007', 'George', 'King', 'george.king@example.com'),
('S1008', '2023-01-08', 3, 8, 'Intermediate', 'P1008', 'Hannah', 'Lee', 'hannah.lee@example.com'),
('S1009', '2023-01-09', 2, 9, 'Advanced', 'P1009', 'Ian', 'Clark', 'ian.clark@example.com'),
('S1010', '2023-01-10', 1, 10, 'Beginner', 'P1010', 'Jenna', 'Wright', 'jenna.wright@example.com');


INSERT INTO timeslot (start_time, end_time, day_of_week) VALUES
('08:00:00', '09:00:00', 'Monday'),
('09:00:00', '10:00:00', 'Tuesday'),
('10:00:00', '11:00:00', 'Wednesday'),
('11:00:00', '12:00:00', 'Thursday'),
('12:00:00', '13:00:00', 'Friday'),
('13:00:00', '14:00:00', 'Saturday'),
('14:00:00', '15:00:00', 'Sunday'),
('15:00:00', '16:00:00', 'Monday'),
('16:00:00', '17:00:00', 'Tuesday'),
('17:00:00', '18:00:00', 'Wednesday');


INSERT INTO instructor (instructor_school_id, can_teach_ensemble, person_number, first_name, last_name, email_address) VALUES
('I2001', TRUE, 'P2001', 'Kevin', 'Moore', 'kevin.moore@example.com'),
('I2002', FALSE, 'P2002', 'Linda', 'Taylor', 'linda.taylor@example.com'),
('I2003', TRUE, 'P2003', 'Martin', 'Jones', 'martin.jones@example.com'),
('I2004', FALSE, 'P2004', 'Nina', 'White', 'nina.white@example.com'),
('I2005', TRUE, 'P2005', 'Oscar', 'Davis', 'oscar.davis@example.com'),
('I2006', FALSE, 'P2006', 'Pamela', 'Wilson', 'pamela.wilson@example.com'),
('I2007', TRUE, 'P2007', 'Quentin', 'Harris', 'quentin.harris@example.com'),
('I2008', FALSE, 'P2008', 'Rachel', 'Martin', 'rachel.martin@example.com'),
('I2009', TRUE, 'P2009', 'Steven', 'King', 'steven.king@example.com'),
('I2010', FALSE, 'P2010', 'Tina', 'Brown', 'tina.brown@example.com');


INSERT INTO instructor_instrument (person_id, instrument) VALUES
(1, 'Piano'),
(2, 'Guitar'),
(3, 'Violin'),
(4, 'Drums'),
(5, 'Piano'),
(6, 'Guitar'),
(7, 'Violin'),
(8, 'Drums'),
(9, 'Piano'),
(10, 'Guitar');


INSERT INTO instructor_timeslot (person_id, timeslot_id, is_available) VALUES
(1, 1, TRUE),
(2, 2, TRUE),
(3, 3, TRUE),
(4, 4, TRUE),
(5, 5, TRUE),
(6, 6, TRUE),
(7, 7, TRUE),
(8, 8, TRUE),
(9, 9, TRUE),
(10, 10, TRUE);


INSERT INTO instrument_rental (instrument_id, person_id, rental_start_date, rental_end_date) VALUES
(1, 1, '2023-01-01', '2023-06-01'),
(2, 2, '2023-01-02', '2023-06-02'),
(3, 3, '2023-01-03', '2023-06-03'),
(4, 4, '2023-01-04', '2023-06-04'),
(5, 5, '2023-01-05', '2023-06-05'),
(6, 6, '2023-01-06', '2023-06-06'),
(7, 7, '2023-01-07', '2023-06-07'),
(8, 8, '2023-01-08', '2023-06-08'),
(9, 9, '2023-01-09', '2023-06-09'),
(10, 10, '2023-01-10', '2023-06-10');


INSERT INTO sibling (person_id, sibling_id) VALUES
(1, 2),
(2, 1),
(3, 4),
(4, 3),
(5, 6),
(6, 5),
(7, 8),
(8, 7),
(9, 10),
(10, 9);


INSERT INTO ensemble (minimum_students, maximum_students, target_genre, room, price_info_id, person_id, timeslot_id) VALUES
(5, 10, 'Punk Rock', 'E1', 1, 1, 1),
(6, 9, 'Gospel Band', 'E2', 2, 2, 2),
(4, 8, 'Punk Rock', 'E3', 3, 3, 3),
(7, 11, 'Gospel Band', 'E4', 4, 4, 4),
(5, 10, 'Punk Rock', 'E5', 5, 5, 5),
(8, 12, 'Gospel Band', 'E6', 6, 6, 6),
(6, 9, 'Punk Rock', 'E7', 7, 7, 7),
(5, 7, 'Gospel Band', 'E8', 8, 8, 8),
(7, 10, 'Punk Rock', 'E9', 9, 9, 9),
(6, 8, 'Gospel Band', 'E10', 10, 10, 10);


INSERT INTO group_lesson (number_of_places, minimum_enrollment, instrument, room, price_info_id, person_id, timeslot_id) VALUES
(10, 5, 'Guitar', 'G1', 1, 1, 1),
(12, 6, 'Piano', 'G2', 2, 2, 2),
(8, 4, 'Violin', 'G3', 3, 3, 3),
(15, 7, 'Drums', 'G4', 4, 4, 4),
(10, 5, 'Guitar', 'G5', 5, 5, 5),
(9, 4, 'Piano', 'G6', 6, 6, 6),
(11, 6, 'Violin', 'G7', 7, 7, 7),
(13, 6, 'Drums', 'G8', 8, 8, 8),
(10, 5, 'Guitar', 'G9', 9, 9, 9),
(8, 4, 'Piano', 'G10', 10, 10, 10);


INSERT INTO individual_lesson (instrument, room, price_info_id, person_id, timeslot_id) VALUES
('Violin', 'I1', 1, 1, 1),
('Drums', 'I2', 2, 2, 2),
('Guitar', 'I3', 3, 3, 3),
('Piano', 'I4', 4, 4, 4),
('Violin', 'I5', 5, 5, 5),
('Drums', 'I6', 6, 6, 6),
('Guitar', 'I7', 7, 7, 7),
('Piano', 'I8', 8, 8, 8),
('Violin', 'I9', 9, 9, 9),
('Drums', 'I10', 10, 10, 10);


INSERT INTO booking (ensemble_id, individual_lesson_id, group_lesson_id, person_id, booking_date) VALUES
(NULL, 1, NULL, 4, '2023-11-23'),
(NULL, NULL, 4, 9, '2023-11-23'),
(2, NULL, NULL, 3, '2023-11-23'),
(NULL, 2, NULL, 9, '2023-11-23'),
(NULL, NULL, 9, 10, '2023-11-23'),
(5, NULL, NULL, 4, '2023-11-23'),
(NULL, 8, NULL, 2, '2023-11-23'),
(NULL, NULL, 6, 10, '2023-11-23'),
(1, NULL, NULL, 8, '2023-11-23'),
(NULL, 8, NULL, 7, '2023-11-23');


INSERT INTO person_phone (student_id, instructor_id, phone_id) VALUES
(NULL, 1, 1),
(2, NULL, 2),
(NULL, 3, 3),
(4, NULL, 4),
(NULL, 5, 5),
(6, NULL, 6),
(NULL, 7, 7),
(8, NULL, 8),
(NULL, 9, 9),
(10, NULL, 10);


INSERT INTO person_address (student_id, instructor_id, address_id) VALUES
(NULL, 1, 1),
(2, NULL, 2),
(NULL, 3, 3),
(4, NULL, 4),
(NULL, 5, 5),
(6, NULL, 6),
(NULL, 7, 7),
(8, NULL, 8),
(NULL, 9, 9),
(10, NULL, 10);