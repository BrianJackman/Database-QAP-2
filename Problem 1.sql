-- create tables

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    school_enrollment_date DATE
);


CREATE TABLE professors (
    id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    department TEXT
);


CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name TEXT,
    course_description TEXT,
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professors(id)
);


CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Insert data


INSERT INTO students (first_name, last_name, email, school_enrollment_date) VALUES
('John', 'Doe', 'john.doe@example.com', '2022-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', '2021-09-01'),
('Alice', 'Johnson', 'alice.johnson@example.com', '2020-08-20'),
('Bob', 'Brown', 'bob.brown@example.com', '2019-07-10'),
('Charlie', 'Davis', 'charlie.davis@example.com', '2022-02-25');


INSERT INTO professors (first_name, last_name, department) VALUES
('Emily', 'White', 'Physics'),
('Michael', 'Green', 'Mathematics'),
('Sarah', 'Black', 'Chemistry'),
('David', 'Blue', 'Biology');


INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'Introduction to Physics', 1),
('Calculus I', 'Introduction to Calculus', 2),
('Organic Chemistry', 'Introduction to Organic Chemistry', 3);


INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2022-03-01'),
(2, 1, '2022-03-02'),
(3, 2, '2022-03-03'),
(4, 3, '2022-03-04'),
(5, 1, '2022-03-05');

-- SQL Queries

SELECT CONCAT(s.first_name, ' ', s.last_name) AS full_name
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE c.course_name = 'Physics 101';

SELECT c.course_name, CONCAT(p.first_name, ' ', p.last_name) AS professor_full_name
FROM courses c
JOIN professors p ON c.professor_id = p.id;

SELECT DISTINCT c.course_name
FROM courses c
JOIN enrollments e ON c.id = e.course_id;


-- update data

UPDATE students
SET email = 'new.email@example.com'
WHERE id = 1;


-- delete data
DELETE FROM enrollments
WHERE student_id = 1 AND course_id = 1;