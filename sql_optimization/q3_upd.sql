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

-- 3. List the names of students who have taken course v4 (crsCode).
-- Exists() is faster then IN(), especially when subquery returns nullable columns.
-- Added index on transcript to avoid table scan
CREATE INDEX transcript_idx ON transcript (crsCode, studId, semester);
EXPLAIN ANALYZE SELECT s.name FROM Student s WHERE EXISTS (SELECT t.studId FROM Transcript t WHERE t.crsCode = @v4 AND t.studId = s.id);