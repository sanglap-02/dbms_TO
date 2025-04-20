show databases;


-- seeding 
 
-- this is the database name 
create database CMS;

use CMS;



-- create the student table with all the nessasary attribute and studentID as the primary key  
create table student (

	studentID int primary key ,
    firstName varchar(100) not null ,
    middleName varchar(100),
    lastName varchar(100) ,
    Email varchar(1000) not null,
    password varchar(100) not null
    
);

-- this is the course tabel with primary key courseID and we haven'nt created the foreign key yet , we will do that laket
create table course (
	courseID int primary key ,
    courseName varchar(1000) not null,
    credit decimal(5,2) not null, -- (5,2) there sould be total 5 number and 2 numbers are allowed after the decimal . 45.30 100.00
    instructorID int 
);

-- creating the instructor table with instructorID as pk
create table instructor (
	instructorID int primary key ,
    firstName varchar(100) not null,
    middleName varchar(100) ,
    lastName varchar(100) ,
    email varchar(1000) not null,
    password varchar(100) not null
);

create table assignment (
	assignmentID int primary key ,
    title varchar(100) not null,
    descripton varchar(1000) ,
    deadline datetime not null,
    courseID int
);


create table reminder(
	reminderID int primary key ,
    assignmentID int not null,
    reminderDateTime datetime not null,
    message varchar(1000) ,
    studentID int 
) ;

create table enrollment (
	id int primary key ,
	studentID int not null,
    courseID int not null
);


create table assignment_submission (

	id int primary key ,
    studentID int not null,
    assignmentID int not null

);

-- create the fk ( DML query ) 
alter table course
add constraint fk_course_instructor
foreign key (instructorID)
references instructor(instructorID);


alter table assignment
add constraint fk_assignment_course
foreign key (courseID)
references course(courseID);


alter table reminder
add constraint fk_assignment_reminder
foreign key (assignmentID)
references assignment(assignmentID);

alter table reminder
add constraint fk_assignment_student
foreign key (studentID)
references student(studentID);

alter table enrollment
add constraint fk_enrollment_student
foreign key (studentID)
references student(studentID);

alter table enrollment
add constraint fk_enrollment_course
foreign key (courseID)
references course(courseID);

alter table assignment_submission
add constraint fk_assignment_submission_student
foreign key (studentID)
references student(studentID);

alter table assignment_submission
add constraint fk_assignment_submission_assignment
foreign key (assignmentID)
references assignment(assignmentID);



select * from course ;

use CMS;


-- filling up the student table
select * from student;
insert into student (studentID , firstName, middleName , lastName ,Email, password)
values
(201, 'Alice', 'M.', 'Wong', 'alice.wong@example.com', 'alice123'),
(202, 'Bob', NULL, 'Johnson', 'bob.johnson@example.com', 'bob123'),
(203, 'Charlie', 'L.', 'Brown', 'charlie.brown@example.com', 'charlie123'),
( 204 ,'jon',null, 'doe','jon.doe@gamil.com','pass'),
( 205 ,'ram','mid', 'sam','ram.sam@gamil.com','password');


-- filling the data in instructor table
select * from instructor;

insert into instructor (instructorID , firstName, middleName , lastName ,email, password)
values 
(1, 'John', 'A.', 'Smith', 'john.smith@example.com', 'pass123'),
(2, 'Emily', 'B.', 'Clark', 'emily.clark@example.com', 'pass456'),
( 3 ,'deniel',null, 'job','deniel.job@gamil.com','pass'),
( 4 ,'natalia',null, 'smith','natalia.smith@gamil.com' , 'pass');


-- filling the data in course table
insert into course (courseID,courseName,credit,instructorID)
values 
(101, 'Database Systems', 4, 1),
(102, 'Operating Systems', 3, 2),
(103, 'chemistry', 2, 4),
(104, 'python' , 1, 3) ;

select * from course;


-- filling the data in assignment table 
select * from assignment;

insert into assignment ( assignmentID,title,descripton,deadline,courseID)
value 
(301, 'ER Diagram', 'Draw an ER diagram for the given requirements', '2025-04-25', 101),
(302, 'Normalization', 'Normalize the schema up to 3NF', '2025-04-30', 101),
(303, 'Process Management', 'Write a report on process scheduling algorithms', '2025-05-01', 102),
(304, 'organic chemistry' , 'write down the molecular formulas' , '2025-04-28', 103),
(305 , 'chat bot', 'create a chatbot with flask and pandas' , '2025-04-29', 104),
(306, 'inorganic chemistry' , 'write down the molecular formulas new' , '2025-05-10', 103);


-- filling the reminder table 

select * from reminder;

insert into reminder (reminderID, assignmentID,reminderDateTime,message,studentID)
values 
(1, 301, '2025-04-23 10:00:00', 'Don’t forget to submit your ER diagram assignment!', 201),
( 2, 304, '2025-04-27' , 'I need to submit the organic chemistry assignment', 204),
( 3, 305 ,'2025-04-28' , 'I need to submit the pyhton assignment' ,'204' ) ,
( 4, 306 ,'2025-05-08', 'I need to submit the inorganic chemistry assignment' ,'205' );

-- adding some reminders that are in the past
insert into reminder (reminderID, assignmentID,reminderDateTime,message,studentID)
values 
( 5, 306 ,'2025-04-17', 'I need to submit the inorganic chemistry assignment - early reminder' ,'205' );
-- fillign the data in enrollment table

select * from enrollment;


insert into enrollment ( id, studentID,courseID)
values 
(1, 201, 101),
(2, 202, 101),
(3, 203, 102),
(4, 204, 103),
(5, 204, 104),
(6, 205, 103);


-- filling the assignment_submission table 

select * from assignment_submission;

insert into assignment_submission ( id, studentID,assignmentID)
value 
( 1, 204 , 304) ;


-- the 2nd question in the assignment : we are shoing the assignment from a perticular student , so we frist need to select the student we want to check the assignment for 

select a.assignmentID , 
		a.title,
        a.descripton,
        a.deadline,
        c.courseName,
        c.credit,
        s.studentID
from 
	assignment a
join
	course c on a.courseID= c.courseID
join 
	enrollment e on c.courseID= e.courseID
join 
	student s on e.studentID = s.studentID
where s.studentID= '205';


-- the thrid question : here we are showing the assignment title and deadline for respective instructors 

select
	a.title,
	a.deadline,
    i.instructorID,
    i.firstName
from 
assignment a 
join course c on a.courseID= c.courseID
join instructor i on c.instructorID = i.instructorID;


-- fourth question : we are shoing the upcomign reminders for respective assignments that are upcoming and we are doing it by the NOW() function in myslq 

select 
	a.title,
	a.deadline,
    r.reminderDateTime,
    r.message
from 
assignment a 
join reminder r on a.assignmentID= r.assignmentID
where r.reminderDateTime >= NOW();

-- fifth question : we are showing the assignment those are submitted with the course and respective instructor

select 
	a.title,
	c.courseName,
    i.instructorID,
    i.firstName
from assignment a 
join course c on a.courseID= c.courseID
join instructor i on c.instructorID=i.instructorID
join assignment_submission s on a.assignmentID=s.assignmentID;

-- creating show case the required details to provide restriction on the data

-- 1. student view : view their own assignment with course info, Purpose: Shows all assignments that a student is expected to submit, organized by course.

CREATE VIEW student_assignments_view AS
SELECT s.studentID, CONCAT(s.firstName, ' ', s.lastName) AS studentName,
       a.assignmentID, a.title, a.deadline, c.courseName
FROM student s
JOIN enrollment e ON s.studentID = e.studentID
JOIN course c ON e.courseID = c.courseID
JOIN assignment a ON a.courseID = c.courseID;

select * from student_assignments_view;



-- 2. Instructor View: Assignments per Course Taught ,Purpose: Allows instructors to view all assignments they are responsible for.
CREATE VIEW instructor_assignment_view AS
SELECT i.instructorID, CONCAT(i.firstName, ' ', i.lastName) AS instructorName,
       c.courseName, a.assignmentID, a.title, a.deadline
FROM instructor i
JOIN course c ON i.instructorID = c.instructorID
JOIN assignment a ON a.courseID = c.courseID;

select * from instructor_assignment_view;

-- 3. Assignment Due Listing for Instructors, Purpose: Sorted list of upcoming deadlines for each instructor.

CREATE VIEW instructor_due_assignments AS
SELECT i.instructorID, c.courseName, a.title AS assignmentTitle, a.deadline
FROM instructor i
JOIN course c ON i.instructorID = c.instructorID
JOIN assignment a ON a.courseID = c.courseID
ORDER BY a.deadline ASC;

select * from instructor_due_assignments;


-- 4. Reminders for Students , Purpose: Students can see their assignment reminders without accessing the reminder table directly.

CREATE VIEW student_reminder_view AS
SELECT r.studentID, s.firstName, s.lastName, a.title AS assignmentTitle, r.reminderDateTime, r.message
FROM reminder r
JOIN student s ON r.studentID = s.studentID
JOIN assignment a ON r.assignmentID = a.assignmentID
ORDER BY r.reminderDateTime ASC;

select * from student_reminder_view;

-- 







	
