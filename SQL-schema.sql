-- ENUM types
CREATE TYPE instrument_type AS ENUM ('Guitar', 'Piano', 'Violin', 'Drums', 'Other');
CREATE TYPE instrument_brand AS ENUM ('Yamaha', 'Gibson', 'Fender', 'Steinway', 'Kawai', 'Roland', 'Taylor', 'Martin', 'Ibanez', 'Casio');
CREATE TYPE level_type AS ENUM ('Beginner', 'Intermediate', 'Advanced');


-- student table
CREATE TABLE student (
 student_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
 person_number VARCHAR(12) UNIQUE,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
 rental_limit INT NOT NULL CHECK (rental_limit >= 0 AND rental_limit <= 2),
 instrument_skill_level level_type NOT NULL,
 email_address VARCHAR(200)
);

-- instrument table
CREATE TABLE instrument (
 instrument_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
 instrument_type instrument_type NOT NULL,
 instrument_brand instrument_brand NOT NULL,
 instrument_price DECIMAL(10, 2) NOT NULL CHECK (instrument_price > 0),
 is_available BOOLEAN NOT NULL DEFAULT TRUE
);

-- instrument_rental table
CREATE TABLE instrument_rental (
 rental_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
 instrument_id INT NOT NULL,
 student_id INT NOT NULL,
 rental_start_date DATE NOT NULL DEFAULT CURRENT_DATE,
 rental_end_date DATE NOT NULL DEFAULT CURRENT_DATE + 30,
 rental_termination_date DATE,
 is_rental_active BOOLEAN NOT NULL DEFAULT TRUE
);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_1 FOREIGN KEY (student_id) REFERENCES student (student_id);

