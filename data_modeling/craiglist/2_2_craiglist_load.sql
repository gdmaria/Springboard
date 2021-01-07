USE [Springboard]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Region = state
SET IDENTITY_INSERT [dbo].[CLRegion] ON 
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (1, N'Alabama')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (2, N'Alaska')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (3, N'American Samoa')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (4, N'Arizona')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (5, N'Arkansas')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (6, N'California')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (7, N'Colorado')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (8, N'Connecticut')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (9, N'Delaware')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (10, N'District of Columbia')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (11, N'Florida')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (12, N'Georgia')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (13, N'Guam')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (14, N'Hawaii')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (15, N'Idaho')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (16, N'Illinois')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (17, N'Indiana')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (18, N'Iowa')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (19, N'Kansas')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (20, N'Kentucky')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (21, N'Louisiana')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (22, N'Maine')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (23, N'Maryland')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (24, N'Massachusetts')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (25, N'Michigan')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (26, N'Minnesota')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (27, N'Mississippi')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (28, N'Missouri')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (29, N'Montana')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (30, N'Nebraska')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (31, N'Nevada')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (32, N'New Hampshire')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (33, N'New Jersey')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (34, N'New Mexico')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (35, N'New York')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (36, N'North Carolina')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (37, N'North Dakota')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (38, N'Northern Mariana Islands')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (39, N'Ohio')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (40, N'Oklahoma')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (41, N'Oregon')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (42, N'Pennsylvania')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (43, N'Puerto Rico')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (44, N'Rhode Island')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (45, N'South Carolina')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (46, N'South Dakota')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (47, N'Tennessee')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (48, N'Texas')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (49, N'Utah')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (50, N'Vermont')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (51, N'Virgin Islands (U.S.)')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (52, N'Virginia')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (53, N'Washington')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (54, N'West Virginia')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (55, N'Wisconsin')
GO
INSERT [dbo].[CLRegion] ([RegionId], [RegionName]) VALUES (56, N'Wyoming')
GO
SET IDENTITY_INSERT [dbo].[CLRegion] OFF
GO


-- Location = city
SET IDENTITY_INSERT [dbo].[CLLocation] ON 
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (1, N'Birmingham', 1)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (2, N'Anchorage', 2)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (3, N'Tafuna', 3)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (4, N'Phoenix', 4)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (5, N'Little Rock', 5)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (6, N'Los Angeles', 6)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (7, N'Denver', 7)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (8, N'Bridgeport', 8)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (9, N'Wilmington', 9)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (10, N'Washington', 10)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (11, N'Jacksonville', 11)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (12, N'Atlanta', 12)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (13, N'Dededo', 13)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (14, N'Honolulu', 14)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (15, N'Boise', 15)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (16, N'Chicago', 16)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (17, N'Indianapolis', 17)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (18, N'Des Moines', 18)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (19, N'Wichita', 19)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (20, N'Louisville', 20)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (21, N'New Orleans', 21)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (22, N'Portland', 22)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (23, N'Baltimore', 23)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (24, N'Boston', 24)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (25, N'Detroit', 25)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (26, N'Minneapolis', 26)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (27, N'Jackson', 27)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (28, N'Kansas City', 28)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (29, N'Billings', 29)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (30, N'Omaha', 30)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (31, N'Las Vegas', 31)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (32, N'Manchester', 32)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (33, N'Newark', 33)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (34, N'Albuquerque', 34)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (35, N'New York City', 35)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (36, N'Charlotte', 36)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (37, N'Fargo', 37)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (38, N'Saipan', 38)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (39, N'Columbus', 39)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (40, N'Oklahoma City', 40)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (41, N'Portland', 41)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (42, N'Philadelphia', 42)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (43, N'San Juan', 43)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (44, N'Providence', 44)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (45, N'Charleston', 45)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (46, N'Sioux Falls', 46)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (47, N'Nashville', 47)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (48, N'Houston', 48)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (49, N'Salt Lake City', 49)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (50, N'Burlington', 50)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (51, N'Charlotte Amalie', 51)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (52, N'Virginia Beach', 52)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (53, N'Seattle', 53)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (54, N'Charleston', 54)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (55, N'Milwaukee', 55)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (56, N'Cheyenne', 56)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (57, N'Montgomery', 1)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (58, N'Fairbanks', 2)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (59, N'Nu''uuli', 3)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (60, N'Tucson', 4)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (61, N'Fort Smith', 5)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (62, N'San Diego', 6)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (63, N'Colorado Springs', 7)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (64, N'New Haven', 8)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (65, N'Dover', 9)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (66, N'Miami', 11)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (67, N'Augusta', 12)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (68, N'Yigo', 13)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (69, N'Hilo', 14)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (70, N'Meridian', 15)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (71, N'Aurora', 16)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (72, N'Fort Wayne', 17)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (73, N'Cedar Rapids', 18)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (74, N'Overland Park', 19)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (75, N'Lexington', 20)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (76, N'Baton Rouge', 21)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (77, N'Lewiston', 22)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (78, N'Frederick', 23)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (79, N'Worcester', 24)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (80, N'Grand Rapids', 25)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (81, N'Saint Paul', 26)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (82, N'Gulfport', 27)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (83, N'Saint Louis', 28)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (84, N'Missoula', 29)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (85, N'Lincoln', 30)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (86, N'Henderson', 31)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (87, N'Nashua', 32)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (88, N'Jersey City', 33)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (89, N'Las Cruces', 34)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (90, N'Buffalo', 35)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (91, N'Raleigh', 36)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (92, N'Bismarck', 37)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (93, N'Tinian', 38)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (94, N'Cleveland', 39)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (95, N'Tulsa', 40)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (96, N'Salem', 41)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (97, N'Pittsburgh', 42)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (98, N'Bayamón', 43)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (99, N'Warwick', 44)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (100, N'Columbia', 45)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (101, N'Rapid City', 46)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (102, N'Memphis', 47)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (103, N'San Antonio', 48)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (104, N'West Valley City', 49)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (105, N'Essex', 50)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (106, N'Sion Farm', 51)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (107, N'Norfolk', 52)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (108, N'Spokane', 53)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (109, N'Huntington', 54)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (110, N'Madison', 55)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (111, N'Casper', 56)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (112, N'Huntsville', 1)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (113, N'Juneau', 2)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (114, N'Pago Pago', 3)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (115, N'Mesa', 4)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (116, N'Fayetteville', 5)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (117, N'San Jose', 6)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (118, N'Aurora', 7)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (119, N'Hartford', 8)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (120, N'Newark', 9)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (121, N'Tampa', 11)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (122, N'Columbus', 12)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (123, N'Tamuning', 13)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (124, N'Kailua', 14)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (125, N'Nampa', 15)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (126, N'Rockford', 16)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (127, N'Evansville', 17)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (128, N'Davenport', 18)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (129, N'Kansas City', 19)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (130, N'Bowling Green', 20)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (131, N'Shreveport', 21)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (132, N'Bangor', 22)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (133, N'Rockville', 23)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (134, N'Springfield', 24)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (135, N'Warren', 25)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (136, N'Rochester', 26)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (137, N'Southaven', 27)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (138, N'Springfield', 28)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (139, N'Great Falls', 29)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (140, N'Bellevue', 30)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (141, N'Reno', 31)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (142, N'Concord', 32)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (143, N'Paterson', 33)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (144, N'Rio Rancho', 34)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (145, N'Rochester', 35)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (146, N'Greensboro', 36)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (147, N'Grand Forks', 37)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (148, N'Rota', 38)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (149, N'Cincinnati', 39)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (150, N'Norman', 40)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (151, N'Eugene', 41)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (152, N'Allentown', 42)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (153, N'Carolina', 43)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (154, N'Cranston', 44)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (155, N'North Charleston', 45)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (156, N'Aberdeen', 46)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (157, N'Knoxville', 47)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (158, N'Dallas', 48)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (159, N'Provo', 49)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (160, N'South Burlington', 50)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (161, N'Northside', 51)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (162, N'Chesapeake', 52)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (163, N'Tacoma', 53)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (164, N'Morgantown', 54)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (165, N'Green Bay', 55)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (166, N'Laramie', 56)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (167, N'Mobile', 1)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (168, N'Sitka', 2)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (169, N'''Ili''ili', 3)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (170, N'Chandler', 4)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (171, N'Springdale', 5)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (172, N'San Francisco', 6)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (173, N'Fort Collins', 7)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (174, N'Stamford', 8)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (175, N'Middletown', 9)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (176, N'Orlando', 11)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (177, N'Macon', 12)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (178, N'Mangilao', 13)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (179, N'Kapolei', 14)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (180, N'Idaho Falls', 15)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (181, N'Joliet', 16)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (182, N'South Bend', 17)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (183, N'Sioux City', 18)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (184, N'Olathe', 19)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (185, N'Owensboro', 20)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (186, N'Lafayette', 21)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (187, N'South Portland', 22)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (188, N'Gaithersburg', 23)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (189, N'Lowell', 24)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (190, N'Sterling Heights', 25)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (191, N'Bloomington', 26)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (192, N'Hattiesburg', 27)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (193, N'Columbia', 28)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (194, N'Bozeman', 29)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (195, N'Grand Island', 30)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (196, N'North Las Vegas', 31)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (197, N'Derry', 32)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (198, N'Elizabeth', 33)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (199, N'Santa Fe', 34)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (200, N'Yonkers', 35)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (201, N'Durham', 36)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (202, N'Minot', 37)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (203, N'Northern Islands', 38)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (204, N'Toledo', 39)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (205, N'Broken Arrow', 40)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (206, N'Gresham', 41)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (207, N'Erie', 42)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (208, N'Ponce', 43)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (209, N'Pawtucket', 44)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (210, N'Mount Pleasant', 45)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (211, N'Brookings', 46)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (212, N'Chattanooga', 47)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (213, N'Austin', 48)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (214, N'West Jordan', 49)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (215, N'Colchester', 50)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (216, N'East End', 51)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (217, N'Richmond', 52)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (218, N'Vancouver', 53)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (219, N'Parkersburg', 54)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (220, N'Kenosha', 55)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (221, N'Gillette', 56)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (222, N'Tuscaloosa', 1)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (223, N'Ketchikan', 2)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (224, N'Pava''ia''i', 3)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (225, N'Glendale', 4)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (226, N'Jonesboro', 5)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (227, N'Fresno', 6)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (228, N'Lakewood', 7)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (229, N'Waterbury', 8)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (230, N'Smyrna', 9)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (231, N'St. Petersburg', 11)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (232, N'Savannah', 12)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (233, N'Barrigada', 13)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (234, N'Kaneohe', 14)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (235, N'Pocatello', 15)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (236, N'Naperville', 16)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (237, N'Carmel', 17)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (238, N'Iowa City', 18)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (239, N'Topeka', 19)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (240, N'Covington', 20)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (241, N'Lake Charles', 21)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (242, N'Auburn', 22)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (243, N'Bowie', 23)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (244, N'Cambridge', 24)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (245, N'Ann Arbor', 25)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (246, N'Duluth', 26)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (247, N'Biloxi', 27)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (248, N'Independence', 28)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (249, N'Butte', 29)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (250, N'Kearney', 30)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (251, N'Sparks', 31)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (252, N'Rochester', 32)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (253, N'Edison', 33)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (254, N'Roswell', 34)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (255, N'Syracuse', 35)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (256, N'Winston-Salem', 36)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (257, N'West Fargo', 37)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (258, N'Akron', 39)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (259, N'Lawton', 40)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (260, N'Hillsboro', 41)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (261, N'Reading', 42)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (262, N'Caguas', 43)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (263, N'East Providence', 44)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (264, N'Rock Hill', 45)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (265, N'Watertown', 46)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (266, N'Clarksville', 47)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (267, N'Fort Worth', 48)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (268, N'Orem', 49)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (269, N'Rutland', 50)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (270, N'Southcentral (St. Croix)', 51)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (271, N'Newport News', 52)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (272, N'Bellevue', 53)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (273, N'Wheeling', 54)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (274, N'Racine', 55)
GO
INSERT [dbo].[CLLocation] ([LocationId], [LocationName], [RegionID]) VALUES (275, N'Rock Springs', 56)
GO
SET IDENTITY_INSERT [dbo].[CLLocation] OFF
GO


SET IDENTITY_INSERT [dbo].[CLCategory] ON 
GO
INSERT [dbo].[CLCategory] ([CategoryId], [CategoryName]) VALUES (1, N'Appliences')
GO
INSERT [dbo].[CLCategory] ([CategoryId], [CategoryName]) VALUES (2, N'Automotive Parts')
GO
INSERT [dbo].[CLCategory] ([CategoryId], [CategoryName]) VALUES (3, N'Baby')
GO
INSERT [dbo].[CLCategory] ([CategoryId], [CategoryName]) VALUES (4, N'Books')
GO
INSERT [dbo].[CLCategory] ([CategoryId], [CategoryName]) VALUES (5, N'Clothing')
GO
INSERT [dbo].[CLCategory] ([CategoryId], [CategoryName]) VALUES (6, N'Furniture')
GO
SET IDENTITY_INSERT [dbo].[CLCategory] OFF
GO


INSERT INTO dbo.CLUser(FullName)
VALUES (N'Cierra Vega'),
	   (N'Alden Cantrell'),
	   (N'Kierra Gentry'),
	   (N'Pierre Cox'),
	   (N'Thomas Crane'),
	   (N'Miranda Shaffer'),
	   (N'Bradyn Kramer'),
	   (N'Alvaro Mcgee')
GO


-- Assign each user 1-2 random region(s)
WITH regions AS
(
	SELECT RegionId, ROW_NUMBER() OVER(ORDER BY RegionId) AS rn
	FROM dbo.CLRegion
),
users AS
(
	SELECT UserId, (ABS(CHECKSUM(NewId())) % 56 + 1) AS rnd, (ABS(CHECKSUM(NewId())) % 56 + 1) AS rnd2
	FROM dbo.CLUser
)
INSERT INTO dbo.CLUserRegion(UserId, RegionId)
SELECT U.UserId, R.RegionId
FROM users AS U
LEFT JOIN regions AS R ON R.rn = U.rnd OR (U.UserId % 2 = 0 AND R.rn = U.rnd2)
GO


-- Add 3 posts per user with random locations in one of the user's preferred regions
WITH locations AS
(
	SELECT 
		LocationId,
		RegionId,
		ROW_NUMBER() OVER(PARTITION BY RegionId ORDER BY LocationId) AS rn
	FROM dbo.CLLocation
),
users AS
(
	SELECT
		U.UserId,
		UR.RegionId,
		ROW_NUMBER() OVER(PARTITION BY U.UserId ORDER BY UR.RegionId) AS rn	
	FROM dbo.CLUser AS U
	INNER JOIN CLUserRegion AS UR ON U.UserId = UR.UserId
)
INSERT INTO dbo.CLPost(Title, Descr, UserId, LocationId, PostDate)
SELECT 
	N'Post Title ' + CAST(U.UserId AS VARCHAR(10)),
	N'Post Test ' + REPLICATE(CAST(U.UserId AS VARCHAR(10)), 5),
	U.UserId,
	L.LocationId,
	CAST(DATEADD(DAY, ABS(CHECKSUM(NEWID())%364), '2020-01-01') AS DATE) AS PostDate
FROM users AS U
LEFT JOIN locations AS L ON U.RegionID = L.RegionID AND L.rn <= 3
WHERE U.rn = 1
GO


-- Assign each post 1-2 random categories(s)
WITH categories AS
(
	SELECT CategoryId, ROW_NUMBER() OVER(ORDER BY CategoryId) AS rn
	FROM dbo.CLCategory
),
posts AS
(
	SELECT PostId, (ABS(CHECKSUM(NewId())) % 6 + 1) AS rnd, (ABS(CHECKSUM(NewId())) % 6 + 1) AS rnd2
	FROM dbo.CLPost
)
INSERT INTO dbo.CLPostCategory(PostId, CategoryId)
SELECT P.PostId, C.CategoryId
FROM posts AS P
LEFT JOIN categories AS C ON C.rn = P.rnd OR (P.PostId % 2 = 0 AND C.rn = P.rnd2)
GO
