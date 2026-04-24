CREATE DATABASE OnlineLearning;
USE OnlineLearning;

-- Bảng Student
CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    dob DATE,
    CHECK (dob <= CURDATE())
);

-- Bảng Instructor
CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Bảng Course
CREATE TABLE Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

-- Bảng Enrollment
CREATE TABLE Enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Bảng Result
CREATE TABLE Result (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    mid_score FLOAT CHECK (mid_score BETWEEN 0 AND 10),
    final_score FLOAT CHECK (final_score BETWEEN 0 AND 10),
    FOREIGN KEY (enrollment_id) REFERENCES Enrollment(enrollment_id)
);
-- Student
INSERT INTO Student(name, email, dob) VALUES
('Nguyen Van A', 'a@gmail.com', '2004-01-01'),
('Tran Thi B', 'b@gmail.com', '2003-05-10'),
('Le Van C', 'c@gmail.com', '2004-07-15'),
('Pham Thi D', 'd@gmail.com', '2003-09-20'),
('Hoang Van E', 'e@gmail.com', '2004-12-25');

-- Instructor
INSERT INTO Instructor(name, email) VALUES
('Thay Minh', 'minh@gmail.com'),
('Co Lan', 'lan@gmail.com'),
('Thay Hung', 'hung@gmail.com'),
('Co Hoa', 'hoa@gmail.com'),
('Thay Nam', 'nam@gmail.com');

-- Course
INSERT INTO Course(course_name, description, instructor_id) VALUES
('SQL', 'Hoc SQL co ban', 1),
('Java', 'Lap trinh Java', 2),
('Python', 'Lap trinh Python', 3),
('Web', 'Thiet ke web', 4),
('AI', 'Tri tue nhan tao', 5);

-- Enrollment
INSERT INTO Enrollment(student_id, course_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

-- Result
INSERT INTO Result(enrollment_id, mid_score, final_score) VALUES
(1,7,8),
(2,6,7),
(3,8,9),
(4,5,6),
(5,9,9);

-- Cập nhật email sinh viên
UPDATE Student
SET email = 'newemail@gmail.com'
WHERE student_id = 1;

-- Cập nhật mô tả khóa học
UPDATE Course
SET description = 'SQL nang cao'
WHERE course_id = 1;

-- Cập nhật điểm cuối kỳ
UPDATE Result
SET final_score = 10
WHERE result_id = 1;

-- Xóa enrollment không hợp lệ (ví dụ id = 5)
DELETE FROM Enrollment
WHERE enrollment_id = 5;

-- Xóa kết quả liên quan
DELETE FROM Result
WHERE enrollment_id = 5;


-- Danh sách sinh viên
SELECT * FROM Student;

-- Danh sách giảng viên
SELECT * FROM Instructor;

-- Danh sách khóa học
SELECT * FROM Course;

-- Thông tin đăng ký học
SELECT 
    e.enrollment_id,
    s.name AS student_name,
    c.course_name
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Course c ON e.course_id = c.course_id;

-- Thông tin kết quả học tập
SELECT 
    r.result_id,
    s.name,
    c.course_name,
    r.mid_score,
    r.final_score
FROM Result r
JOIN Enrollment e ON r.enrollment_id = e.enrollment_id
JOIN Student s ON e.student_id = s.student_id
JOIN Course c ON e.course_id = c.course_id;