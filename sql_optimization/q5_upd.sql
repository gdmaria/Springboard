USE springboardopt;

-- -------------------------------------
SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- 5. List the names of students who have taken a course from department v6 (deptId), but not v7.
-- Added index on course table
-- IN -> EXISTS
CREATE INDEX course_idx on course (crsCode, deptId);
EXPLAIN ANALYZE SELECT name FROM Student
WHERE EXISTS (
	SELECT studId FROM Transcript, Course WHERE deptId = @v6 AND Course.crsCode = Transcript.crsCode AND Transcript.crsCode = Student.id) 
AND NOT EXISTS (
	SELECT studId FROM Transcript, Course WHERE deptId = @v7 AND Course.crsCode = Transcript.crsCode AND Transcript.crsCode = Student.id);