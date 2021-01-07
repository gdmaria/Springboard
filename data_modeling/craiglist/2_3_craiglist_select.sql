USE [Springboard]
GO

-- Regions and corresponding locations
SELECT R.RegionName, L.LocationName
FROM dbo.CLRegion AS R
LEFT JOIN dbo.CLLocation AS L ON R.RegionId = L.RegionId
ORDER BY RegionName, LocationName;

-- Categories
SELECT * 
FROM dbo.CLCategory
ORDER BY CategoryId;

-- Users and preferred regions
SELECT U.FullName, R.RegionName AS PreferredRegionName
FROM dbo.CLUser AS U
INNER JOIN dbo.CLUserRegion AS UR ON U.UserId = UR.UserId
INNER JOIN dbo.CLRegion AS R ON UR.RegionId = R.RegionId
ORDER BY U.FullName, R.RegionName;

-- Posts
WITH categories AS
(
	SELECT P.PostId, STRING_AGG(C.CategoryName, ', ') WITHIN GROUP (ORDER BY C.CategoryName) AS Categories
	FROM dbo.CLPost AS P
	INNER JOIN dbo.CLPostCategory AS PC ON PC.PostId = P.PostId
	INNER JOIN dbo.CLCategory AS C ON PC.CategoryId = C.CategoryId
	GROUP BY P.PostId
)
SELECT P.PostId, P.PostDate, P.Title, P.Descr AS PostText, U.FullName AS UserName, L.LocationName, R.RegionName, C.Categories
FROM dbo.CLPost AS P
INNER JOIN dbo.CLUser AS U ON U.UserId = P.UserId
INNER JOIN categories AS C ON C.PostId = P.PostId
INNER JOIN dbo.CLLocation AS L ON P.LocationId = L.LocationId
INNER JOIN dbo.CLRegion AS R ON R.RegionId = L.RegionId
ORDER BY P.PostDate;

GO
