USE [Springboard]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER FUNCTION dbo.GetTeamStats
(
	@TeamId INT,
	@LeagueId INT,
	@SeasonId INT
)
RETURNS TABLE
AS
RETURN
	WITH goals AS
	(
		SELECT 
			G.GameID,
			CASE WHEN (G.HomeTeamId = @TeamID AND PL.IsHomeTeam = 1 
					   OR G.AwayTeamId = @TeamID AND PL.IsHomeTeam = 0) 
				 THEN 1
				 ELSE -1
			END AS Scored
		FROM dbo.Game AS G
		LEFT JOIN dbo.Goal AS GL ON G.GameId = GL.GameID
		LEFT JOIN dbo.PlayerLineup AS PL ON G.GameId = PL.GameID AND GL.PlayerId = PL.PlayerId
		WHERE G.LeagueId = @LeagueId
			AND G.SeasonId = @SeasonId
			AND (G.HomeTeamId = @TeamID OR G.AwayTeamId = @TeamID)
	)
	SELECT 
		GameId,
		SUM(IIF(Scored=1, 1, 0)) AS F, 
		SUM(IIF(Scored=-1, 1, 0)) AS A, 
		SUM(Scored) AS GD
	FROM goals
	GROUP BY GameId
GO


CREATE OR ALTER PROCEDURE dbo.GetStandings
	@LeagueId INT,
	@SeasonId INT
AS
BEGIN
	WITH games AS
	(
		SELECT *
		FROM dbo.Game
		WHERE LeagueId = @LeagueId
			AND SeasonId = @SeasonId
	),
	games_teams AS
	(
		SELECT GameId, TeamType, TeamId
		FROM games
		UNPIVOT (TeamId FOR TeamType IN ([HomeTeamId], [AwayTeamId])) AS U
	),
	games_teams_stats AS
	(
		SELECT 
			GT.GameId,
			GT.TeamId,
			GTS.F,
			GTS.A,
			GTS.GD,
			IIF(GTS.GD > 0, 1, 0) AS W,
			IIF(GTS.GD < 0, 1, 0) AS L,
			IIF(GTS.GD = 0, 1, 0) AS D
		FROM games_teams AS GT
		OUTER APPLY dbo.GetTeamStats(GT.TeamId, @LeagueId, @SeasonId) AS GTS
		WHERE GTS.GameId = GT.GameId
	),
	res AS
	(
		SELECT 
			TeamId,
			COUNT(GameId) AS GP,
			SUM(W) AS W,
			SUM(D) AS D,
			SUM(L) AS L,
			SUM(F) AS F,
			SUM(A) AS A,
			SUM(GD) AS GD
		FROM games_teams_stats
		GROUP BY TeamId
	)
	SELECT T.TeamName, res.GP, res.W, res.D, res.L, res.F, res.A, res.GD 
	FROM res
	INNER JOIN dbo.Team AS T on res.TeamId = T.TeamId
	ORDER BY res.GP DESC, res.W DESC, res.D DESC, res.L DESC, res.F DESC, res.A DESC, res.GD DESC;
	
END;
GO


DECLARE @LeagueId INT, @SeasonId INT;
SELECT @LeagueId = LeagueId FROM dbo.League WHERE LeagueName = 'UEFA Champions League';
SELECT @SeasonId = SeasonId FROM dbo.Season WHERE SeasonName = '2018/2019';

EXEC dbo.GetStandings @LeagueId, @SeasonId
GO
