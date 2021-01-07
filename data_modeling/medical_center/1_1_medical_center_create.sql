USE [Springboard]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Doctor
(
	DoctorId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Doctor PRIMARY KEY CLUSTERED (DoctorId),
	FullName VARCHAR(250) NOT NULL	
)
GO

CREATE TABLE dbo.Patient
(
	PatientId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Patient PRIMARY KEY(PatientId),
	FullName VARCHAR(250) NOT NULL,
	SSN VARCHAR(11) CONSTRAINT UQ_Patient_SSN UNIQUE
)
GO

CREATE TABLE dbo.Disease
(
	DiseaseId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Disease PRIMARY KEY CLUSTERED (DiseaseId),
	DiseaseName VARCHAR(250) NOT NULL,
	CategoryId INT NOT NULL,
	Descr VARCHAR(500) NULL	
)
GO

CREATE TABLE dbo.Visit
(
	VisitId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Visit PRIMARY KEY CLUSTERED (VisitId),
	DoctorId INT NOT NULL CONSTRAINT FK_Visit_Doctor FOREIGN KEY(DoctorId) REFERENCES dbo.Doctor(DoctorId),
	PatientId INT NOT NULL CONSTRAINT FK_Visit_Patient FOREIGN KEY(PatientId) REFERENCES dbo.Patient(PatientId),
	VisitDate DATE NOT NULL	
);
GO

CREATE TABLE dbo.Diagnosis
(
	DiagnosisId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Diagnosis PRIMARY KEY CLUSTERED (DiagnosisId),
	VisitId INT NOT NULL CONSTRAINT FK_Diagnosis_Visit FOREIGN KEY(VisitId) REFERENCES dbo.Visit(VisitId),
	DiseaseId INT NOT NULL CONSTRAINT FK_Diagnosis_Disease FOREIGN KEY(DiseaseId) REFERENCES dbo.Disease(DiseaseId),
	Notes VARCHAR(500) NULL	
)
GO