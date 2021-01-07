USE [Springboard]
GO


SELECT * 
FROM dbo.Doctor
ORDER BY DoctorId;

SELECT * 
FROM dbo.Patient
ORDER BY PatientId;

SELECT * 
FROM dbo.Disease
ORDER BY DiseaseId;

-- Visits & diagnoses
WITH diagnoses AS
(
	SELECT D.VisitId, DS.DiseaseName, DS.CategoryID
	FROM dbo.Diagnosis AS D
	INNER JOIN dbo.Disease AS DS ON D.DiseaseId = DS.DiseaseId
)
SELECT V.VisitId, V.VisitDate, D.FullName AS DoctorName, P.FullName AS PatientName, DG.DiseaseName, DG.CategoryID
FROM dbo.Visit AS V
INNER JOIN dbo.Doctor AS D ON V.DoctorId = D.DoctorId
INNER JOIN dbo.Patient AS P ON V.PatientId = P.PatientId
INNER JOIN diagnoses AS DG ON V.VisitId = DG.VisitId
ORDER BY V.VisitDate, V.VisitId, DG.CategoryID
