----------------------------------------------------------------------------------------------------- THE EVIL BASELINE STUFF IG -----------------------------------------------------------------------------------------------------------------

USE master;
GO

USE University;
GO

----------------------------------------------------------------------------------------------- OPTIMIZED LOOK FOR CHECKING STUDENT STATUS ----------------------------------------------------------------------------------------------------------

 -- Try to find a way to optimize the SELECT feature here and exclude "IsOnTrack Boolean"
SELECT 
S.StudentID, S.StudentFirstName, S.StudentAlias,
S.StudentLastName, S.StudentGender, 
S.DegreePath, S.StudentPhoneNumber, 
S.StudentPersonalEmail, S.StudentEmail, SA.StartDate,
SA.GraduateDate,
	
	IIF(S.IsOnTrack = 1, 'Will Graduate', 'Will not Graduate') AS IsOnTrack,
	IIF(SA.IsAlumnus = 1, 'Yes', 'No') AS IsAlumnus

FROM Student AS S LEFT JOIN StudentAlumni AS SA 
ON S.StudentID = SA.StudentID;

----------------------------------------------------------------------------------------------- OPTIMIZED LOOK FOR CHECKING PROFESSOR STATUS ----------------------------------------------------------------------------------------------------------

SELECT 
P.ProfessorID, P.ProfFirstName, P.ProfLastName, P.ProfGender, 
P.ProfTitle, P.ProfEmail, P.ProfPersonalEmail, P.ProfPhoneNumber,
P.DepartmentSpecialized, PE.HiredDate, PE.LeaveDate,
	
	IIF(PE.Emeritus = 1, 'Retired', 'Not Retired') AS Retired

FROM Professor AS P LEFT JOIN ProfEmeritus AS PE 
ON P.ProfessorID = PE.ProfessorID;

----------------------------------------------------------------------------------------------- OPTIMIZED LOOK FOR CHECKING ASSIGNED COURSES ----------------------------------------------------------------------------------------------------------

-- SELECT PROFESSORS AND COURSES

SELECT 
P.ProfessorID, P.ProfTitle, P.ProfFirstName, P.ProfLastName, P.ProfGender, P.ProfEmail, P.DepartmentSpecialized, 
C.CourseTag, C.Section, C.CourseName, C.MainSubject, C.CourseDesc, C.CourseLocation,
CT.StartDate, CT.EndDate, CT.DaysHeld, CT.LectureStartTime, CT.LectureEndTime
FROM Professor P
INNER JOIN ProfessorInstruct PrIn ON P.ProfessorID = PrIn.ProfessorID
INNER JOIN Courses C ON C.CourseID = PrIn.CourseID
INNER JOIN CourseTime CT ON CT.CourseID = PrIn.CourseID
ORDER BY P.ProfFirstName;


-- SELECT STUDENTS AND COURSES

SELECT 
S.StudentID, S.StudentFirstName, S.StudentLastName, S.DegreePath, S.StudentEmail,
SG.GradePercent, SG.LetterGrade, SG.Passed, 
C.CourseTag, C.Section, C.CourseName, C.MainSubject, C.CourseLocation,
CT.StartDate, CT.EndDate, CT.DaysHeld, CT.LectureStartTime, CT.LectureEndTime
FROM Student S
INNER JOIN StudentGrade SG ON S.StudentID = SG.StudentID
INNER JOIN Courses C ON C.CourseID = SG.CourseID
INNER JOIN CourseTime CT ON CT.CourseID = SG.CourseID
ORDER BY S.StudentFirstName;