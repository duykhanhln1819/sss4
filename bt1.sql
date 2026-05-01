
create database OnlineLearning;
use OnlineLearning;


create table Student (
    student_id int primary key auto_increment,
    full_name varchar(100) not null,
    birth_date date,
    email varchar(100) unique
);

create table Instructor (
    instructor_id int primary key auto_increment,
    full_name varchar(100) not null,
    email varchar(100) unique
);


create table Course (
    course_id int primary key auto_increment,
    course_name varchar(100) not null,
    description text,
    total_sessions int,
    instructor_id int,
    foreign key (instructor_id) references Instructor(instructor_id)
);

create table Enrollment (
    enrollment_id int primary key auto_increment,
    student_id int,
    course_id int,
    enroll_date date,

    unique (student_id, course_id),

    foreign key (student_id) references Student(student_id),
    foreign key (course_id) references Course(course_id)
);


create table Result (
    result_id int primary key auto_increment,
    student_id int,
    course_id int,
    mid_score float check (mid_score between 0 and 10),
    final_score float check (final_score between 0 and 10),

    unique (student_id, course_id),

    foreign key (student_id, course_id)
        references Enrollment(student_id, course_id)
);

insert into Student (full_name, birth_date, email) values
('Nguyen Van A', '2005-01-01', 'a@gmail.com'),
('Tran Thi B', '2005-02-02', 'b@gmail.com'),
('Le Van C', '2005-03-03', 'c@gmail.com'),
('Pham Thi D', '2005-04-04', 'd@gmail.com'),
('Hoang Van E', '2005-05-05', 'e@gmail.com');

insert into Instructor (full_name, email) values
('Thay Minh', 'minh@gmail.com'),
('Co Lan', 'lan@gmail.com'),
('Thay Hung', 'hung@gmail.com'),
('Co Hoa', 'hoa@gmail.com'),
('Thay Tuan', 'tuan@gmail.com');


insert into Course (course_name, description, total_sessions, instructor_id) values
('Lap trinh C', 'Co ban ve C', 20, 1),
('Java', 'Lap trinh Java', 25, 2),
('SQL', 'Co so du lieu', 15, 3),
('Web', 'HTML CSS JS', 30, 4),
('Python', 'Lap trinh Python', 20, 5);

insert into Enrollment (student_id, course_id, enroll_date) values
(1, 1, '2025-01-10'),
(1, 2, '2025-01-11'),
(2, 1, '2025-01-12'),
(3, 3, '2025-01-13'),
(4, 4, '2025-01-14'),
(5, 5, '2025-01-15');

insert into Result (student_id, course_id, mid_score, final_score) values
(1, 1, 7, 8),
(1, 2, 6, 7),
(2, 1, 8, 9),
(3, 3, 5, 6),
(4, 4, 9, 9),
(5, 5, 7, 8);


update Student
set email = 'newemail@gmail.com'
where student_id = 1;

update Course
set description = 'Khoa hoc SQL nang cao'
where course_id = 3;

update Result
set final_score = 10
where student_id = 1 and course_id = 1;

delete from Result
where student_id = 5 and course_id = 5;

delete from Enrollment
where student_id = 5 and course_id = 5;

select * from Student;
select * from Instructor;
select * from Course;
select * from Enrollment;
select * from Result;