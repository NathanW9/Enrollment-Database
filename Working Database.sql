Working Database

CREATE TABLE Classes (
    Cid int PRIMARY KEY,
    name varchar(255),
    subject varchar(4),
    courseCode int
)

INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (0, 'Discrete Structures for Computer Science', 'COMP',  115 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (1, 'Principles of Computing Science I', 'COMP',  171 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (2, 'Principles of Computer Science II', 'COMP',  172 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (3, 'Introduction to Computer Organization and Systems', 'COMP',  210 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (4, 'Introduction to Data Structures', 'COMP',  220 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (5, 'Algorithms and Data Structures', 'COMP',  311 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (6, 'Introduction to Software Engineering', 'COMP',  345 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (7, 'Elective', 'COMP', 1);
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (8, 'Elective', 'COMP', 2);
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (9, 'Elective', 'COMP', 3);
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (10, 'Elective', 'COMP', 4);
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (11, 'Calculus I', 'MATH',  111 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (12, 'Introduction to Applied Linear Algebra', 'MATH',  187 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (13, 'Linear Algebra', 'MATH',  231 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (14, 'Stats for BEM', 'MATH',  144 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (15, 'Stats for HLSS', 'MATH',  145 );
INSERT INTO Classes (Cid, name, subject, courseCode) VALUES (16, 'Statistical Analysis', 'MATH',  216 );

create table semesters(
    Sid int Primary Key,
    year year,
    semester ENUM('Fall', 'Spring', 'Winter', 'Summer') NOT NULL
)


INSERT INTO semesters (Sid, year, semester) VALUES
(1, 2024, 'Fall'),
(2, 2024, 'Spring'),
(3, 2025, 'Fall'),
(4, 2025, 'Spring'),
(5, 2026, 'Fall'),
(6, 2026, 'Spring'),
(7, 2027, 'Fall'),
(8, 2027, 'Spring'),
(9, 2028, 'Fall'),
(10, 2028, 'Spring');

create table students (
    StuID int Primary Key, 
    firstName text,
    lastName text,
    studentId int(9)
)

INSERT INTO students (StuID, firstName, lastName, studentId) VALUES
(1, 'John', 'Doe', 123456789),
(2, 'Jane', 'Smith', 987654321),
(3, 'Alice', 'Johnson', 123123123);

create table classesBeingTaken (
    StuID INT,
    Cid INT,
    Sid INT,
    PRIMARY KEY (StuID, Cid, Sid),
    FOREIGN KEY (StuID) REFERENCES students(StuID),
    FOREIGN KEY (Cid) REFERENCES classes(Cid),
    FOREIGN KEY (Sid) REFERENCES semesters(Sid)
)

-- Advisor table
create table advisors (
	aid int,
	name text,
)

-- prerequisites table
-- course is a prereq for other course
create table prerequisites (
	precid int,
	cid int,
	foreign key (precid) references classes(Cid),
	foreign key (cid) references classes(Cid)
)