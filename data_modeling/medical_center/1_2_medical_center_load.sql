USE [Springboard]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

INSERT INTO dbo.Doctor(FullName)
VALUES (N'Dr. Cierra Vega'),
	   (N'Dr. Alden Cantrell'),
	   (N'Dr. Kierra Gentry'),
	   (N'Dr. Pierre Cox')
GO


INSERT INTO dbo.Patient(FullName, SSN)
VALUES (N'Thomas Crane', '067-45-3456'),
	   (N'Miranda Shaffer', '098-41-2432'),
	   (N'Bradyn Kramer', '074-53-6321'),
	   (N'Alvaro Mcgee', '034-45-5676')
GO


INSERT INTO dbo.Disease(DiseaseName, CategoryId)
VALUES (N'Common cold', 1),
	   (N'Flu', 1),
	   (N'Covid-19', 1),
	   (N'Heartburn', 2),
	   (N'Nausea', 2),
	   (N'Pneumonia', 3),
	   (N'Bronchitis', 3)
GO

-- Add visits for random doctor-patient pairs 
WITH doctors AS
(
	SELECT DoctorId, ROW_NUMBER() OVER(ORDER BY DoctorId) AS rn
	FROM dbo.Doctor
),
patients AS
(
	SELECT PatientId, ROW_NUMBER() OVER(ORDER BY PatientId) AS rn
	FROM dbo.Patient
)
INSERT INTO dbo.Visit(DoctorId, PatientId, VisitDate)
SELECT 
	D.DoctorId, 
	P.PatientId, 
	CAST(DATEADD(DAY, ABS(CHECKSUM(NEWID())%364), '2020-01-01') AS DATE) AS VisitDate
FROM doctors AS D
CROSS JOIN patients AS P
WHERE (D.rn % 2 = 0 AND P.rn % 2 != 0) OR (D.rn % 2 != 0 AND P.rn % 2 = 0)
GO

-- Add a random diagnosis of category 1 to each visit
WITH diseases AS
(
	SELECT DiseaseId, ROW_NUMBER() OVER(ORDER BY DiseaseId) AS rn
	FROM dbo.Disease
	WHERE CategoryId = 1
),
visits AS
(
	SELECT VisitId, (ABS(CHECKSUM(NewId())) % 3 + 1) AS rnd
	FROM dbo.Visit
)
INSERT INTO dbo.Diagnosis(VisitId, DiseaseId)
SELECT V.VisitId, D.DiseaseId
FROM visits AS V
LEFT JOIN diseases AS D ON D.rn = V.rnd
GO

-- Add a random diagnosis of category 2 to each visit with an even VisitId
WITH diseases AS
(
	SELECT DiseaseId, ROW_NUMBER() OVER(ORDER BY DiseaseId) AS rn
	FROM dbo.Disease
	WHERE CategoryId = 2
),
visits AS
(
	SELECT VisitId, (ABS(CHECKSUM(NewId())) % 2 + 1) AS rnd
	FROM dbo.Visit
)
INSERT INTO dbo.Diagnosis(VisitId, DiseaseId)
SELECT V.VisitId, D.DiseaseId
FROM visits AS V
LEFT JOIN diseases AS D ON D.rn = V.rnd
WHERE V.VisitId % 2 = 0
GO

-- Add a random diagnosis of category 3 to each visit with an odd VisitId
WITH diseases AS
(
	SELECT DiseaseId, ROW_NUMBER() OVER(ORDER BY DiseaseId) AS rn
	FROM dbo.Disease
	WHERE CategoryId = 3
),
visits AS
(
	SELECT VisitId, (ABS(CHECKSUM(NewId())) % 2 + 1) AS rnd
	FROM dbo.Visit
)
INSERT INTO dbo.Diagnosis(VisitId, DiseaseId)
SELECT V.VisitId, D.DiseaseId
FROM visits AS V
LEFT JOIN diseases AS D ON D.rn = V.rnd
WHERE V.VisitId % 2 != 0
GO
