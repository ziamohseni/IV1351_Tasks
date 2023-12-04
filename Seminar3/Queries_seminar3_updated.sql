-- 1. Show the number of lessons given per month during a specified year.
-- Create a view that combines all lessons
CREATE VIEW combined_lessons_view AS
SELECT planed_date, 'Individual' AS lesson_type 
FROM individual_lesson
UNION ALL 
SELECT planed_date, 'Group' AS lesson_type 
FROM group_lesson
UNION ALL 
SELECT planed_date, 'Ensemble' AS lesson_type 
FROM ensemble;

-- Query the view to get the number of lessons per month
SELECT 
    TO_CHAR(planed_date, 'Mon') AS Month, 
    COUNT(*) AS Total, 
    SUM(CASE WHEN lesson_type = 'Individual' THEN 1 ELSE 0 END) AS Individual, 
    SUM(CASE WHEN lesson_type = 'Group' THEN 1 ELSE 0 END) AS Group, 
    SUM(CASE WHEN lesson_type = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble 
FROM combined_lessons_view
WHERE EXTRACT(YEAR FROM planed_date) = 2023 -- Replace this if you want to query a different year
GROUP BY TO_CHAR(planed_date, 'Mon'), EXTRACT(MONTH FROM planed_date)
ORDER BY EXTRACT(MONTH FROM MIN(planed_date));


-- 2. Show how many students there are with no sibling, with one sibling, with two siblings, etc.
-- Create a view that counts the number of siblings for each student
CREATE VIEW student_sibling_summary AS
SELECT 
    COALESCE(sc.NumberOfSiblings, 0) AS "No of Siblings", 
    COUNT(*) AS "No of Students"
FROM 
    student s
LEFT JOIN 
    (
        SELECT 
            sb.student_id, 
            COUNT(sb.sibling_id) AS NumberOfSiblings
        FROM 
            sibling sb
        GROUP BY 
            sb.student_id
        HAVING 
            COUNT(sb.sibling_id) <= 2
    ) AS sc ON s.student_id = sc.student_id
GROUP BY 
    sc.NumberOfSiblings
ORDER BY 
    "No of Siblings";

-- Query the view to get the number of students with 0, 1, or 2 siblings
SELECT * FROM student_sibling_summary;


-- 3. List ids and names of all instructors who has given more than a specific number of lessons during the current month.
-- Create a view that counts the number of lessons given by each instructor during the current month
CREATE VIEW instructor_lessons_summary AS
SELECT 
    i.instructor_id,
    i.first_name,
    i.last_name,
    COUNT(*) AS "No of Lessons"
FROM 
    instructor i
JOIN 
    instructor_timeslot it ON i.instructor_id = it.instructor_id
JOIN 
    booking b ON it.instructor_timeslot_id = b.instructor_timeslot_id
WHERE 
    EXTRACT(MONTH FROM b.booking_date) = EXTRACT(MONTH FROM CURRENT_DATE)
    AND EXTRACT(YEAR FROM b.booking_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY 
    i.instructor_id, i.first_name, i.last_name
ORDER BY 
    "No of Lessons" DESC;

-- Query the view to get the instructors who have given more than a specific number of lessons during the current month
SELECT * 
FROM instructor_lessons_summary 
WHERE "No of Lessons" > 5; -- Replace this if you want to check for a different limit


-- 4. List all ensembles held during the next week
-- Create a view that lists all ensembles held during the next week
CREATE VIEW upcoming_ensembles AS
SELECT
    TO_CHAR(e.planed_date, 'Day') AS Day,
    e.target_genre AS Genre,
    CASE 
        WHEN e.maximum_students - COUNT(b.booking_id) = 0 THEN 'No Seats'
        WHEN e.maximum_students - COUNT(b.booking_id) <= 2 THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS "No of Free Seats"
FROM 
    ensemble e
LEFT JOIN 
    booking b ON e.ensemble_id = b.lesson_id AND b.lesson_type = 'Ensemble'
WHERE 
    e.planed_date >= CURRENT_DATE 
    AND e.planed_date < CURRENT_DATE + INTERVAL '7 days'
GROUP BY 
    e.planed_date, e.ensemble_id, e.target_genre, e.maximum_students
ORDER BY 
    e.planed_date, e.target_genre;

-- Query the view to get all ensembles held during the next week
SELECT * FROM upcoming_ensembles;


-- HIGHER GRADE TASK
-- Historical database
CREATE TABLE historical_student_lessons (
    lesson_id INT,
    lesson_type lesson_type,
    genre target_genre,
    instrument instrument_type,
    lesson_price DECIMAL(10, 2),
    student_name VARCHAR(200),
    student_email VARCHAR(200),
    booking_date DATE,
    PRIMARY KEY (lesson_id, student_name, booking_date)
);

-- Insert data into the historical database
INSERT INTO historical_student_lessons (lesson_id, lesson_type, genre, instrument, lesson_price, student_name, student_email, booking_date)

SELECT
    b.lesson_id,
    b.lesson_type::lesson_type,
    CASE 
        WHEN b.lesson_type = 'Ensemble' THEN e.target_genre
        ELSE NULL
    END AS genre,
    CASE 
        WHEN b.lesson_type = 'Individual' THEN il.instrument
        WHEN b.lesson_type = 'Group' THEN gl.instrument
        ELSE NULL
    END AS instrument,
    pi.base_price AS lesson_price,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email_address,
    b.booking_date
FROM
    booking b
LEFT JOIN student s ON b.student_id = s.student_id
LEFT JOIN price_info pi ON b.price_info_id = pi.price_info_id
LEFT JOIN individual_lesson il ON b.lesson_id = il.individual_lesson_id AND b.lesson_type = 'Individual'
LEFT JOIN group_lesson gl ON b.lesson_id = gl.group_lesson_id AND b.lesson_type = 'Group'
LEFT JOIN ensemble e ON b.lesson_id = e.ensemble_id AND b.lesson_type = 'Ensemble';
