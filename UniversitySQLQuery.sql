----------------------------------------------------------------------------------------------------- THE EVIL BASELINE STUFF IG -----------------------------------------------------------------------------------------------------------------

-- I would have made an entire payment thing if I had more time to
-- And I would have included textbooks for the courses as well
-- I am running out of time really really quickly sooo yeah
-- I'll make two versions of the diagram
-- One with the current setup
-- Another with the current set up

USE master;
GO

USE University;
GO

------------------------------------------------------------------------------------------------------- CREATING STUDENTS ----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Student
(
	StudentID INT IDENTITY PRIMARY KEY,
	StudentFirstName VARCHAR(60) NOT NULL,
	StudentAlias VARCHAR(60),
	StudentLastName VARCHAR(100),
	StudentGender VARCHAR(50),
	DegreePath VARCHAR(200),
	StudentPhoneNumber VARCHAR(80),
	StudentPersonalEmail VARCHAR(150) NOT NULL,
	StudentEmail VARCHAR(100),
	IsOnTrack BIT NOT NULL DEFAULT 1,
);

----------------------------------------------------------------------------------------------- CREATING THE CHECK FOR ALUMNI STATUS ------------------------------------------------------------------------------------------------------------------

CREATE TABLE StudentAlumni
(
	StudentAlumniID INT IDENTITY PRIMARY KEY,
	StudentID INT,
	CONSTRAINT FK_StudentID FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	IsAlumnus BIT NOT NULL DEFAULT 1,
	StartDate DATE NOT NULL,
	GraduateDate DATE
);

------------------------------------------------------------------------------------------------------------- CREATING PROFESSORS (10) -------------------------------------------------------------------------------------------------------------

CREATE TABLE Professor
(
	ProfessorID INT IDENTITY PRIMARY KEY,
	ProfFirstName VARCHAR(60) NOT NULL,
	ProfLastName VARCHAR(100),
	ProfTitle VARCHAR(40),
	ProfGender VARCHAR(200),
	ProfPhoneNumber VARCHAR(80) NOT NULL,
	DepartmentSpecialized VARCHAR(150) NOT NULL,
	ProfPersonalEmail VARCHAR(100) NOT NULL,
	ProfEmail VARCHAR(100)
);

-- Professor(s) can be assigned to teach many courses
-- One or more Relationship

----------------------------------------------------------------------------------------------- CREATING THE CHECK FOR EMERITUS STATUS ------------------------------------------------------------------------------------------------------------------

CREATE TABLE ProfEmeritus
(
	ProfEmeritusID INT IDENTITY PRIMARY KEY,
	ProfessorID INT,
	CONSTRAINT FK_ProfEmID FOREIGN KEY (ProfessorID) REFERENCES Professor(ProfessorID),
	Emeritus BIT NOT NULL DEFAULT 1,
	HiredDate DATE,
	LeaveDate DATE
);

---------------------------------------------------------------------------------------------- THE COURSES AVAILABLE --------------------------------------------------------------------------------------------------------------

CREATE TABLE Courses
(
	CourseID INT IDENTITY PRIMARY KEY,
	CourseName VARCHAR(100),
	CourseTag VARCHAR(10), -- the technical name of the course, like MATH-1000
	MainSubject VARCHAR(50),
	Section INT,
	CourseDesc VARCHAR(500),
	SeatsAvailable INT,
	Credits INT,
	CourseLocation VARCHAR(20)
);

---------------------------------------------------------------------------------------------- CREATING THE CHECK FOR ASSIGNED COURSE STATUS --------------------------------------------------------------------------------------------------------------

CREATE TABLE ProfessorInstruct
(
	ProfInstructID INT IDENTITY PRIMARY KEY,
	IsMainInstructor BIT NOT NULL DEFAULT 1,
	HowManyInstructor INT DEFAULT 1,
	ProfessorID INT,
	CourseID INT,
	CONSTRAINT FK_ProfInID FOREIGN KEY (ProfessorID) REFERENCES Professor(ProfessorID),
	CONSTRAINT FK_ProfAssignedCourse FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

SELECT * FROM Professor
SELECT * FROM ProfessorInstruct

---------------------------------------------------------------------------------------------- WHEN DOES THE COURSE BEGIN --------------------------------------------------------------------------------------------------------------

CREATE TABLE CourseTime
(
	CourseTimeID INT IDENTITY PRIMARY KEY,
	CourseID INT,
	CONSTRAINT FK_CourseByTime FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
	LectureStartTime TIME,
	LectureEndTime TIME,
	StartDate DATE,
	EndDate DATE,
	DaysHeld VARCHAR(10)
);

---------------------------------------------------------------------------------------------- THE GRADES FROM THE COURSE --------------------------------------------------------------------------------------------------------------

CREATE TABLE StudentGrade
(
	StudentGradeID INT IDENTITY PRIMARY KEY,
	StudentID INT,
	CONSTRAINT FK_TotalStudentGradeID FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	CourseID INT,
	CONSTRAINT FK_CourseGradeID FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
	GradePercent DECIMAL(5,4),
	LetterGrade CHAR(2),
	Passed BIT
);

