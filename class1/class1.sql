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



