-- ENUM types
CREATE TYPE instrument_type AS ENUM ('Guitar', 'Piano', 'Violin', 'Drums', 'Other');
CREATE TYPE instrument_brand AS ENUM ('Yamaha', 'Gibson', 'Fender', 'Steinway', 'Kawai', 'Roland', 'Taylor', 'Martin', 'Ibanez', 'Casio');
CREATE TYPE level_type AS ENUM ('Beginner', 'Intermediate', 'Advanced');
CREATE TYPE lesson_type AS ENUM ('Individual', 'Group', 'Ensemble');
CREATE TYPE target_genre AS ENUM ('Punk Rock', 'Gospel Band');
CREATE TYPE day_of_week AS ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Address table
CREATE TABLE address (
 address_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 street VARCHAR(200) NOT NULL,
 zip VARCHAR(5) NOT NULL,
 city VARCHAR(100) NOT NULL
);

ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (address_id);

-- Contact Person table
CREATE TABLE contact_person (
 contact_person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 full_name VARCHAR(100) NOT NULL,
 phone_number VARCHAR(100) NOT NULL,
 email_address VARCHAR(100),
 relationship VARCHAR(100) NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (contact_person_id);

-- ensemble table
CREATE TABLE ensemble (
 ensemble_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 minimum_students INT NOT NULL,
 maximum_students INT NOT NULL,
 target_genre target_genre NOT NULL,
 room VARCHAR(10) NOT NULL,
 planed_date DATE NOT NULL
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (ensemble_id);

-- group_lesson table
CREATE TABLE group_lesson (
 group_lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 number_of_places INT NOT NULL,
 minimum_enrollment INT NOT NULL,
 instrument instrument_type NOT NULL,
 room VARCHAR(10) NOT NULL,
 planed_date DATE NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (group_lesson_id);

-- individual_lesson table
CREATE TABLE individual_lesson (
 individual_lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument instrument_type NOT NULL,
 room VARCHAR(10) NOT NULL,
 planed_date DATE NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (individual_lesson_id);

-- instructor table
CREATE TABLE instructor (
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 can_teach_ensemble BOOLEAN NOT NULL,
 person_number VARCHAR(12) UNIQUE,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 email_address VARCHAR(200)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);

-- instructor_address table
CREATE TABLE instructor_address (
 instructor_id INT NOT NULL,
 address_id INT NOT NULL
);

ALTER TABLE instructor_address ADD CONSTRAINT PK_instructor_address PRIMARY KEY (instructor_id,address_id);

-- instructor_instrument table
CREATE TABLE instructor_instrument (
 instructor_instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id INT NOT NULL,
 instrument instrument_type NOT NULL
);

ALTER TABLE instructor_instrument ADD CONSTRAINT PK_instructor_instrument PRIMARY KEY (instructor_instrument_id,instructor_id);

-- instrument table
CREATE TABLE instrument (
 instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_type instrument_type NOT NULL,
 brand instrument_brand NOT NULL,
 quantity_in_stock INT NOT NULL,
 price DECIMAL(10)
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);

-- phone table
CREATE TABLE phone (
 phone_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 phone_number VARCHAR(100) UNIQUE NOT NULL
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (phone_id);

-- price_info table
CREATE TABLE price_info (
 price_info_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_type lesson_type NOT NULL,
 base_price DECIMAL(10, 2) NOT NULL,
 lesson_skill_level level_type NOT NULL,
 valid_from TIMESTAMP NOT NULL,
 valid_until TIMESTAMP
);

ALTER TABLE price_info ADD CONSTRAINT PK_price_info PRIMARY KEY (price_info_id);

-- student table
CREATE TABLE student (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 enrollment_date DATE NOT NULL,
 rental_limit INT NOT NULL,
 contact_person_id INT NOT NULL,
 instrument_skill_level VARCHAR(100) NOT NULL,
 person_number VARCHAR(12) UNIQUE,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 email_address VARCHAR(200)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);

-- student_address table
CREATE TABLE student_address (
 address_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_address ADD CONSTRAINT PK_student_address PRIMARY KEY (address_id,student_id);

-- student_phone table
CREATE TABLE student_phone (
 phone_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_phone ADD CONSTRAINT PK_student_phone PRIMARY KEY (phone_id,student_id);

-- timeslot table
CREATE TABLE timeslot (
 timeslot_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 start_time TIME NOT NULL,
 end_time TIME NOT NULL,
 day_of_week day_of_week NOT NULL
);

ALTER TABLE timeslot ADD CONSTRAINT PK_timeslot PRIMARY KEY (timeslot_id);

-- instructor_phone table
CREATE TABLE instructor_phone (
 instructor_id INT NOT NULL,
 phone_id INT NOT NULL
);

ALTER TABLE instructor_phone ADD CONSTRAINT PK_instructor_phone PRIMARY KEY (instructor_id,phone_id);

-- instructor_timeslot table
CREATE TABLE instructor_timeslot (
 instructor_timeslot_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 is_available BOOLEAN NOT NULL,
 timeslot_id INT NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE instructor_timeslot ADD CONSTRAINT PK_instructor_timeslot PRIMARY KEY (instructor_timeslot_id);

-- instrument_rental table
CREATE TABLE instrument_rental (
 rental_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_id INT NOT NULL,
 student_id INT NOT NULL,
 rental_start_date DATE NOT NULL,
 rental_end_date DATE NOT NULL,
 is_rental_active BOOLEAN NOT NULL
);

ALTER TABLE instrument_rental ADD CONSTRAINT PK_instrument_rental PRIMARY KEY (rental_id,instrument_id,student_id);

-- lesson table
CREATE TABLE sibling (
 student_id INT NOT NULL,
 sibling_id INT NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (student_id,sibling_id);

-- booking table
CREATE TABLE booking (
 booking_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id INT NOT NULL,
 lesson_id INT NOT NULL,
 lesson_type lesson_type NOT NULL,
 instructor_timeslot_id INT NOT NULL,
 booking_date DATE NOT NULL,
 price_info_id INT NOT NULL
);


ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (booking_id,student_id,lesson_id);


ALTER TABLE instructor_address ADD CONSTRAINT FK_instructor_address_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_address ADD CONSTRAINT FK_instructor_address_1 FOREIGN KEY (address_id) REFERENCES address (address_id);


ALTER TABLE instructor_instrument ADD CONSTRAINT FK_instructor_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (contact_person_id) REFERENCES contact_person (contact_person_id);


ALTER TABLE student_address ADD CONSTRAINT FK_student_address_0 FOREIGN KEY (address_id) REFERENCES address (address_id);
ALTER TABLE student_address ADD CONSTRAINT FK_student_address_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_phone ADD CONSTRAINT FK_student_phone_0 FOREIGN KEY (phone_id) REFERENCES phone (phone_id);
ALTER TABLE student_phone ADD CONSTRAINT FK_student_phone_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE instructor_phone ADD CONSTRAINT FK_instructor_phone_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_phone ADD CONSTRAINT FK_instructor_phone_1 FOREIGN KEY (phone_id) REFERENCES phone (phone_id);


ALTER TABLE instructor_timeslot ADD CONSTRAINT FK_instructor_timeslot_0 FOREIGN KEY (timeslot_id) REFERENCES timeslot (timeslot_id);
ALTER TABLE instructor_timeslot ADD CONSTRAINT FK_instructor_timeslot_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE sibling ADD CONSTRAINT FK_sibling_1 FOREIGN KEY (sibling_id) REFERENCES student (student_id);


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (instructor_timeslot_id) REFERENCES instructor_timeslot (instructor_timeslot_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_2 FOREIGN KEY (price_info_id) REFERENCES price_info (price_info_id);


