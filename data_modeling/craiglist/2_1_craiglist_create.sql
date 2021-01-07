USE [Springboard]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.CLRegion
(
	RegionId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CLRegion PRIMARY KEY CLUSTERED (RegionId),
	RegionName VARCHAR(100) NOT NULL	
)
GO

CREATE TABLE dbo.CLLocation
(
	LocationId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CLLocation PRIMARY KEY CLUSTERED (LocationId),
	LocationName VARCHAR(100) NOT NULL,
	RegionID INT NOT NULL CONSTRAINT FK_CLLocation_CLRegion FOREIGN KEY(RegionID) REFERENCES dbo.CLRegion(RegionId)
)
GO

CREATE TABLE dbo.CLCategory
(
	CategoryId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CLCategory PRIMARY KEY CLUSTERED (CategoryId),
	CategoryName VARCHAR(100) NOT NULL
)
GO

CREATE TABLE dbo.CLUser
(
	UserId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CLUser PRIMARY KEY(UserId),
	FullName VARCHAR(250) NOT NULL
)
GO

CREATE TABLE dbo.CLUserRegion
(	
	UserId INT NOT NULL CONSTRAINT FK_CLUserRegion_CLUSer FOREIGN KEY(UserId) REFERENCES dbo.CLUser(UserId),
	RegionID INT NOT NULL CONSTRAINT FK_CLUserRegion_CLRegion FOREIGN KEY(RegionID) REFERENCES dbo.CLRegion(RegionID),
	CONSTRAINT PK_CLUserRegion PRIMARY KEY CLUSTERED (UserId, RegionId)
)
GO

CREATE NONCLUSTERED INDEX IX_CLUserRegion_RegionId ON dbo.CLUserRegion(RegionId)
GO

CREATE TABLE dbo.CLPost
(
	PostId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CLPost PRIMARY KEY CLUSTERED (PostId),
	Title VARCHAR(100) NOT NULL,
	Descr VARCHAR(500) NOT NULL,
	UserId INT NOT NULL CONSTRAINT FK_CLPost_CLUser FOREIGN KEY(UserId) REFERENCES dbo.CLUser(UserId),
	LocationId INT NOT NULL CONSTRAINT FK_CLPost_CLLocation FOREIGN KEY(LocationId) REFERENCES dbo.CLLocation(LocationId),	
	PostDate DATE NOT NULL	
);
GO

CREATE TABLE dbo.CLPostCategory
(
	PostId INT NOT NULL CONSTRAINT FK_CLPostCategory_CLPost FOREIGN KEY(PostId) REFERENCES dbo.CLPost(PostId),
	CategoryId INT NOT NULL CONSTRAINT FK_CLPostCategory_CLCategory FOREIGN KEY(CategoryId) REFERENCES dbo.CLCategory(CategoryId),
	CONSTRAINT PK_CLPostCategory PRIMARY KEY CLUSTERED (PostId, CategoryId)
)
GO

CREATE NONCLUSTERED INDEX IX_CLPostCategory_CategoryId ON dbo.CLPostCategory(CategoryId)
GO