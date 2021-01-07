USE [Springboard]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


INSERT INTO dbo.League(LeagueName)
VALUES (N'UEFA Champions League'),
	   (N'Premier League'),
	   (N'Bundesliga')
GO

INSERT INTO dbo.Season(SeasonName)
VALUES (N'2018/2019')
GO

INSERT INTO dbo.LeagueSeason(LeagueId, SeasonId, StartDate, EndDate)
SELECT 
	L.LeagueId, 
	S.SeasonID,
	CASE LeagueName
		WHEN 'UEFA Champions League' THEN '20180626'
		WHEN 'Premier League' THEN '20180810'
		WHEN 'Bundesliga' THEN '20180824'
	END AS StartDate,
	CASE LeagueName
		WHEN 'UEFA Champions League' THEN '20190601'
		WHEN 'Premier League' THEN '20190512'
		WHEN 'Bundesliga' THEN '20190518'
	END AS EndDate
FROM dbo.League AS L
CROSS JOIN dbo.Season AS S
GO

INSERT INTO dbo.Team(TeamName, TeamCity)
VALUES (N'Juventus', 'Turin'),
	   (N'Real Madrid', 'Madrid'),
	   (N'Barcelona', 'Barcelona'),
	   (N'Arsenal', 'London'),
	   (N'Liverpool', 'Liverpool'),
	   (N'Manchester United', 'Manchester'),
	   (N'Borussia Dortmund', 'Dortmund'),
	   (N'Bayern Munich', 'Munich')
GO

-- Add 20 dummy players per team
WITH nums AS
(
	SELECT TOP(20) ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS rn
	FROM sys.objects
)
INSERT INTO dbo.Player(TeamId, FullName)
SELECT TeamId, N'Player ' + CAST(TeamId AS VARCHAR(10)) + CAST(rn AS VARCHAR(10))
FROM dbo.Team
CROSS JOIN nums
GO

INSERT INTO dbo.Referee(FullName)
VALUES (N'Sebastian Coltescu'),
	   (N'Daniele Orsato'),
	   (N'Damir Skomina'),
	   (N'Björn Kuipers'),
	   (N'Clément Turpin')
GO

-- Add games for one league (all teams agains each other)
INSERT INTO dbo.Game(GameDate, LeagueId, SeasonId, HomeTeamId, AwayTeamId)
SELECT 
	CAST(DATEADD(DAY, ABS(CHECKSUM(NEWID())%340), '20180626') AS DATE) AS GameDate,
	L.LeagueId,
	S.SeasonId,
	T1.TeamId,
	T2.TeamId
FROM dbo.Season AS S
CROSS JOIN dbo.League AS L
CROSS JOIN dbo.Team AS T1
CROSS JOIN dbo.Team AS T2
WHERE L.LeagueName = N'UEFA Champions League'
	AND T1.TeamId <> T2.TeamId
GO

-- Add random player lineups (11 players per game)
WITH players AS
(
	SELECT PlayerId, TeamId, ROW_NUMBER() OVER(PARTITION BY TeamId ORDER BY PlayerId) AS rn
	FROM dbo.Player
)
INSERT INTO dbo.PlayerLineup(GameId, PlayerId, IsHomeTeam)
SELECT G.GameId, T1.PlayerId, 1
FROM dbo.Game AS G
INNER JOIN players AS T1 ON G.HomeTeamId = T1.TeamId AND T1.rn <= 11
GO

WITH players AS
(
	SELECT PlayerId, TeamId, ROW_NUMBER() OVER(PARTITION BY TeamId ORDER BY PlayerId) AS rn
	FROM dbo.Player
)
INSERT INTO dbo.PlayerLineup(GameId, PlayerId, IsHomeTeam)
SELECT G.GameId, T2.PlayerId, 0
FROM dbo.Game AS G
INNER JOIN players AS T2 ON G.AwayTeamId = T2.TeamId AND T2.rn <= 11
GO

-- Add 3 random goals per game
WITH players AS
(
	SELECT GameId, PlayerId, ROW_NUMBER() OVER(PARTITION BY GameId ORDER BY (ABS(CHECKSUM(NewId())) % 20 + 1)) AS rn
	FROM dbo.PlayerLineup
)
INSERT INTO dbo.Goal(GameId, PlayerId, GoalMinute)
SELECT G.GameID, P.PlayerId, (ABS(CHECKSUM(NewId())) % 90 + 1)
FROM dbo.Game AS G
INNER JOIN players AS P ON G.GameID = P.GameID AND P.rn <= 3
GO