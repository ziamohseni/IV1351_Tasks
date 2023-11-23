-- ENUM types
CREATE TYPE instrument_type AS ENUM ('Guitar', 'Piano', 'Violin', 'Drums', 'Other');
CREATE TYPE instrument_brand AS ENUM ('Yamaha', 'Gibson', 'Fender', 'Steinway', 'Kawai', 'Roland', 'Taylor', 'Martin', 'Ibanez', 'Casio');
CREATE TYPE level_type AS ENUM ('Beginner', 'Intermediate', 'Advanced');
CREATE TYPE lesson_type AS ENUM ('Individual', 'Group', 'Ensemble');
CREATE TYPE target_genre AS ENUM ('Punk Rock', 'Gospel Band');
CREATE TYPE day_of_week AS ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Address table
CREATE TABLE address (
  address_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  street VARCHAR(200) NOT NULL,
  zip VARCHAR(5) NOT NULL,
  city VARCHAR(100) NOT NULL
);

-- Contact Person table
CREATE TABLE contact_person (
  contact_person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  phone_number VARCHAR(100) NOT NULL,
  email_address VARCHAR(100),
  relationship VARCHAR(100) NOT NULL
);

-- Instrument table
CREATE TABLE instrument (
  instrument_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  instrument_type instrument_type NOT NULL,
  brand instrument_brand,
  quantity_in_stock INT NOT NULL,
  price DECIMAL(10, 2)
);

-- Person table
CREATE TABLE person (
  person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  person_number VARCHAR(12) UNIQUE,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email_address VARCHAR(200)
);

-- Phone table
CREATE TABLE phone (
  phone_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  phone_number VARCHAR(100) UNIQUE NOT NULL
);

-- Price Info table
CREATE TABLE price_info (
  price_info_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  lesson_type lesson_type NOT NULL,
  base_price DECIMAL(10, 2) NOT NULL,
  lesson_skill_level level_type NOT NULL,
  valid_from TIMESTAMP NOT NULL,
  valid_until TIMESTAMP
);

-- Student table inherits Person
CREATE TABLE student (
  person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  student_school_id VARCHAR(100) UNIQUE NOT NULL,
  enrollment_date DATE DEFAULT CURRENT_DATE NOT NULL,
  rental_limit INT NOT NULL,
  contact_person_id INT NOT NULL,
  instrument_skill_level level_type NOT NULL,
  FOREIGN KEY (contact_person_id) REFERENCES contact_person (contact_person_id)
) INHERITS (person);

-- Timeslot table
CREATE TABLE timeslot (
  timeslot_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  day_of_week day_of_week NOT NULL
);

-- Instructor table
CREATE TABLE instructor (
  person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  instructor_school_id VARCHAR(100) UNIQUE NOT NULL,
  can_teach_ensemble BOOLEAN NOT NULL
) INHERITS (person);

-- Instructor Instrument join table
CREATE TABLE instructor_instrument (
  instructor_instrument_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  person_id INT NOT NULL,
  instrument instrument_type NOT NULL,
  FOREIGN KEY (person_id) REFERENCES instructor (person_id)
);

-- Instructor Timeslot join table
CREATE TABLE instructor_timeslot (
  person_id INT NOT NULL,
  timeslot_id INT NOT NULL,
  is_available BOOLEAN NOT NULL,
  PRIMARY KEY (person_id, timeslot_id),
  FOREIGN KEY (person_id) REFERENCES instructor (person_id) ON DELETE CASCADE,
  FOREIGN KEY (timeslot_id) REFERENCES timeslot (timeslot_id)
);

-- Instrument Rental table
CREATE TABLE instrument_rental (
  rental_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  instrument_id INT NOT NULL,
  person_id INT NOT NULL,
  rental_start_date DATE NOT NULL,
  rental_end_date DATE NOT NULL,
  is_rental_active BOOLEAN DEFAULT TRUE NOT NULL,
  FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES student (person_id) ON DELETE CASCADE
);

-- Lesson table
CREATE TABLE lesson (
  lesson_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  room VARCHAR(10),
  price_info_id INT,
  person_id INT NOT NULL,
  timeslot_id INT NOT NULL,
  FOREIGN KEY (price_info_id) REFERENCES price_info (price_info_id),
  FOREIGN KEY (person_id, timeslot_id) REFERENCES instructor_timeslot (person_id, timeslot_id)
);

-- Sibling table
CREATE TABLE sibling (
  person_id INT NOT NULL,
  sibling_id INT NOT NULL,
  PRIMARY KEY (person_id, sibling_id),
  FOREIGN KEY (person_id) REFERENCES student (person_id),
  FOREIGN KEY (sibling_id) REFERENCES student (person_id)
);

-- Ensemble table inherits Lesson
CREATE TABLE ensemble (
  lesson_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  minimum_students INT NOT NULL,
  maximum_students INT NOT NULL,
  target_genre target_genre NOT NULL
) INHERITS (lesson);

-- Group Lesson table inherits Lesson
CREATE TABLE group_lesson (
  lesson_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  number_of_places INT NOT NULL,
  minimum_enrollment INT NOT NULL,
  instrument instrument_type NOT NULL
) INHERITS (lesson);

-- Individual Lesson table inherits Lesson
CREATE TABLE individual_lesson (
  lesson_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  instrument instrument_type NOT NULL
) INHERITS (lesson);

-- Booking table
CREATE TABLE booking (
  booking_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  ensemble_id INT,
  individual_lesson_id INT,
  group_lesson_id INT,
  person_id INT NOT NULL,
  booking_date DATE DEFAULT CURRENT_DATE NOT NULL,
  FOREIGN KEY (ensemble_id) REFERENCES ensemble (lesson_id) ON DELETE CASCADE,
  FOREIGN KEY (individual_lesson_id) REFERENCES individual_lesson (lesson_id) ON DELETE CASCADE,
  FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (lesson_id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES student (person_id) ON DELETE CASCADE,
  CHECK ((ensemble_id IS NOT NULL AND individual_lesson_id IS NULL AND group_lesson_id IS NULL) OR
         (ensemble_id IS NULL AND individual_lesson_id IS NOT NULL AND group_lesson_id IS NULL) OR
         (ensemble_id IS NULL AND individual_lesson_id IS NULL AND group_lesson_id IS NOT NULL))
);

-- Person Address join table
CREATE TABLE person_address (
  student_id INT,
  instructor_id INT,
  address_id INT NOT NULL,
  PRIMARY KEY (address_id),
  FOREIGN KEY (student_id) REFERENCES student (person_id) ON DELETE CASCADE,
  FOREIGN KEY (instructor_id) REFERENCES instructor (person_id) ON DELETE CASCADE,
  FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE CASCADE,
  CHECK ((student_id IS NULL AND instructor_id IS NOT NULL) OR 
         (student_id IS NOT NULL AND instructor_id IS NULL))
);

-- Person Phone join table
CREATE TABLE person_phone (
  student_id INT,
  instructor_id INT,
  phone_id INT NOT NULL,
  PRIMARY KEY (phone_id),
  FOREIGN KEY (student_id) REFERENCES student (person_id),
  FOREIGN KEY (instructor_id) REFERENCES instructor (person_id),
  FOREIGN KEY (phone_id) REFERENCES phone (phone_id),
  CHECK ((student_id IS NULL AND instructor_id IS NOT NULL) OR 
         (student_id IS NOT NULL AND instructor_id IS NULL))
);