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

-- 1. List the name of the student with id equal to v1 (id).
-- Used explain analyze to detect a table scan
-- Added clustered index to the table (PK on id column)
ALTER TABLE student ADD CONSTRAINT student_PK PRIMARY KEY(id);
EXPLAIN ANALYZE SELECT name FROM student WHERE id = @v1;