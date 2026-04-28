
CREATE DATABASE OnlineLearning;
USE OnlineLearning;

CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    total_sessions INT CHECK (total_sessions > 0),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),

    UNIQUE (student_id, course_id)
);

CREATE TABLE Score (
    score_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    mid_score DECIMAL(4,2) CHECK (mid_score BETWEEN 0 AND 10),
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),

    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),

    UNIQUE (student_id, course_id)
);

INSERT INTO Student (name, birth_date, email) VALUES
('Nguyen Van A', '2003-05-10', 'a@gmail.com'),
('Tran Thi B', '2002-08-15', 'b@gmail.com'),
('Le Van C', '2003-12-20', 'c@gmail.com'),
('Pham Thi D', '2001-03-05', 'd@gmail.com'),
('Hoang Van E', '2002-07-25', 'e@gmail.com');

INSERT INTO Teacher (name, email) VALUES
('Nguyen Van T1', 't1@gmail.com'),
('Tran Thi T2', 't2@gmail.com');

INSERT INTO Course (course_name, description, total_sessions, teacher_id) VALUES
('SQL Basics', 'Hoc SQL co ban', 10, 1),
('Java Core', 'Lap trinh Java', 15, 1),
('Web Development', 'HTML CSS JS', 20, 2);

INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
(1, 1, '2025-01-01'),
(1, 2, '2025-01-02'),
(2, 1, '2025-01-03'),
(3, 3, '2025-01-04'),
(4, 2, '2025-01-05');

INSERT INTO Score (student_id, course_id, mid_score, final_score) VALUES
(1, 1, 8.5, 9.0),
(1, 2, 7.0, 8.0),
(2, 1, 6.5, 7.5),
(3, 3, 9.0, 9.5),
(4, 2, 5.5, 6.5);

SELECT * FROM Student;

SELECT s.name, sc.final_score
FROM Student s
JOIN Score sc ON s.student_id = sc.student_id
WHERE sc.final_score > 8;

SELECT s.name, c.course_name
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Course c ON e.course_id = c.course_id;

SELECT s.name, AVG(sc.final_score) AS avg_score
FROM Student s
JOIN Score sc ON s.student_id = sc.student_id
GROUP BY s.name;

SELECT s.name
FROM Student s
WHERE s.student_id IN (
    SELECT e.student_id
    FROM Enrollment e
    WHERE e.course_id = (
        SELECT course_id
        FROM Course
        WHERE course_name = 'SQL Basics'
    )
);

SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;
