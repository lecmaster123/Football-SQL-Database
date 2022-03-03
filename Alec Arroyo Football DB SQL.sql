/*
Author: Alec Arroyo
Course: IST659 M400
Term: Spring 2021

Project Football DB
*/

------------------------DROP TABLES, VIEWS, STORED PROCS-----------------------------------------------------------

--Drop any tables with data in them
IF OBJECT_ID('Team_Game_List') is not null drop table Team_Game_List

--Drop any tables with data in them
IF OBJECT_ID('Player_Stat_List') is not null drop table Player_Stat_List

--Drop any tables with data in them
IF OBJECT_ID('Player') is not null drop table Player

--Drop any tables with data in them
IF OBJECT_ID('Team') is not null drop table Team

--Drop any tables with data in them
IF OBJECT_ID('Game') is not null drop table Game

--Drop any tables with data in them
IF OBJECT_ID('Stat') is not null drop table Stat

--Drop any views with data in them
IF Object_ID('topPlayers') is not null drop view topPlayers

--Drop any views with data in them
IF Object_ID('FullPlayerInfo') is not null drop view FullPlayerInfo

--Drop any views with data in them
IF Object_ID('HomeStadiumTeam') is not null drop view HomeStadiumTeam

--Drop any stored procedures with data in them
IF Object_ID('AddPlayer') is not null drop procedure AddPlayer

--Drop any stored procedures with data in them
IF Object_ID('AddStat') is not null drop procedure AddStat

--Drop any stored procedures with data in them
IF Object_ID('DeletePlayer') is not null drop procedure DeletePlayer

--Drop any functions with data in them
IF Object_ID('PlayerLookup') is not null drop function PlayerLookup

/**************CREATING TABLES***************/----------------------------------------------------------------------------

--Creating the Team Table
CREATE TABLE Team
(
	--columns for Team table
	Team_ID int identity,
	Team_Name varchar(50) not null,
	City varchar(50) not null,
	State varchar(50) not null,
	Number_of_Wins int not null,
	Number_of_Losses int not null,
	--Constraints on the Team Table
	CONSTRAINT PK_Team PRIMARY KEY (Team_ID),
	CONSTRAINT U1_Team UNIQUE (Team_Name),
)
--End creating Team Table

--Creating the Game Table
CREATE TABLE Game
(
	--columns for Game table
	Game_ID int identity,
	Game_Day datetime not null,
	Game_Time datetime not null,
	Team_Won varchar(50) not null,
	Team_Lost varchar(50) not null,
	Final_Score char(5) not null,
	Stadium varchar(50) not null,
	--Constraints on the Game Table
	CONSTRAINT PK_Game PRIMARY KEY (Game_ID),
)
--End creating Game Table

--Creating the Player Table
CREATE TABLE Player
(
	--columns for Player table
	Player_ID int identity,
	Player_First_Name varchar(50) not null,
	Player_Last_Name varchar(50) not null,
	Age int not null,
	Player_Position char(2) not null,
	Team_ID int not null,
	Game_ID int not null,
	--Constraints on the Player Table
	CONSTRAINT PK_Player PRIMARY KEY (Player_ID),
	CONSTRAINT FK1_Player FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID),
	CONSTRAINT FK2_Player FOREIGN KEY (Game_ID) REFERENCES Game(Game_ID)
)
--End creating Player Table

--Creating the Stat Table
CREATE TABLE Stat
(
	--columns for Stat table
	Stat_ID int identity,
	Stat_Position char(2) not null,
	Number_of_Yards int not null,
	Touchdowns int not null,
	Total_Field_Goal_Points int not null,
	--Constraints on the Stat Table
	CONSTRAINT PK_Stat PRIMARY KEY (Stat_ID)
)
--End creating Stat Table

--Creating the Team_Game_List Table
CREATE TABLE Team_Game_List
(
	--columns for Team_Game_List table
	Team_Game_List_ID int identity,
	Team_ID int not null,
	Game_ID int not null,
	--Constraints on the Team_Game_List Table
	CONSTRAINT PK_Team_Game_List PRIMARY KEY (Team_Game_List_ID),
	CONSTRAINT U1_Team_Game_List UNIQUE (Team_ID, Game_ID),
	CONSTRAINT FK1_Team_Game_List FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID),
	CONSTRAINT FK2_Team_Game_List FOREIGN KEY (Game_ID) REFERENCES Game(Game_ID)
)
--End creating Team_Game_List Table

--Creating the Player_Stat_List Table
CREATE TABLE Player_Stat_List
(
	--columns for Player_Stat_List table
	Player_Stat_List_ID int identity,
	Player_ID int not null,
	Stat_ID int not null,
	--Constraints on the Player_Stat_List Table
	CONSTRAINT PK_Player_Stat_List PRIMARY KEY (Player_Stat_List_ID),
	CONSTRAINT U1_Player_Stat_List UNIQUE (Player_ID, Stat_ID),
	CONSTRAINT FK1_Player_Stat_List FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID),
	CONSTRAINT FK2_Player_Stat_List FOREIGN KEY (Stat_ID) REFERENCES Stat(Stat_ID)
)
--End creating Player_Stat_List Table

----------------------------------INSERT DATA INTO TABlES------------------------------------------------------------------

--Insert Team data into Team table
INSERT INTO Team (Team_Name, City, State, Number_of_Wins, Number_of_Losses)
VALUES ('Arizona Cardinals','Phoenix','Arizona','8','8'),
('Atlanta Falcons','Atlanta','Georgia','4','12'),
('Baltimore Ravens','Baltimore','Maryland','11','5'),
('Buffalo Bills','Buffalo','New York','13','3'),
('Carolina Panthers','Charlotte','North Carolina','5','11'),
('Chicago Bears','Chicago','Illinois','8','8'),
('Cincinnati Bengals','Cincinatti','Ohio','4','11'),
('Cleveland Browns','Cleveland','Ohio','11','5'),
('Dallas Cowboys','Dallas','Texas','6','10'),
('Denver Broncos','Denver','Colorado','5','11'),
('Detroit Lions','Detroit','Michigan','5','11'),
('Green Bay Packers','Green Bay','Wisconsin','13','3'),
('Houston Texans','Houston','Texas','4','12'),
('Indianapolis Colts','Indianapolis','Indiana','11','5'),
('Jacksonville Jaguars','Jacksonville','Florida','1','15'),
('Kansas City Chiefs','Kansas City','Missouri','14','2'),
('Las Vegas Raiders','Las Vegas','Nevada','8','8'),
('Los Angeles Chargers','Los Angeles','California','7','9'),
('Los Angeles Rams','Los Angeles','California','10','6'),
('Miami Dolphins','Miami','Florida','10','6'),
('Minnesota Vikings','Minneapolis','Minnessota','7','9'),
('New England Patriots','Boston','Massachusetts','7','9'),
('New Orleans Saints','New Orleans','Louisiana','12','4'),
('New York Giants','New York','New York','6','10'),
('New York Jets','New York','New York','2','14'),
('Philadelphia Eagles','Philadelphia','Pennsylvania','4','11'),
('Pittsburgh Steelers','Pittsburgh','Pennsylvania','12','4'),
('San Francisco 49rs','San Francisco','California','6','10'),
('Seattle Seahawks','Seattle','Washington','12','4'),
('Tampa Bay Buccaneers','Tampa','Florida','11','5'),
('Tennessee Titans','Nashville','Tennessee','11','5'),
('Washington Football Team','Washington','DC','7','9')

SELECT * FROM Team

--Insert Game data into Game table
INSERT INTO Game (Game_Day, Game_Time, Team_Won, Team_Lost, Final_Score, Stadium)
VALUES ('2020-09-10','8:20:00 PM','Kansas City Chiefs','Houston Texans','34-20','Arrowhead Stadium Kansas City Chiefs'),
('2020-09-11','1:00:00 PM','Seattle Seahawks','Atlanta Falcons','38-25','Mercedes-Benz Stadium Atlanta Falcons'),
('2020-09-12','1:00:00 PM','Baltimore Ravens','Cleveland Browns','38-6','M&T Bank Stadium Baltimore Ravens'),
('2020-09-13','1:00:00 PM','Buffalo Bills','New York Jets','27-17','Bills Stadium Buffalo Bills'),
('2020-09-14','1:00:00 PM','Las Vegas Raiders','Carolina Panthers','34-30','Bank of America Stadium Carolina Panthers'),
('2020-09-15','1:00:00 PM','Chicago Bears','Detroit Lions','27-23','Ford Field Detroit Lions'),
('2020-09-16','1:00:00 PM','Jacksonville Jaguars','Indianapolis Colts','27-20','TIAA Bank Field Jacksonville Jaguars'),
('2020-09-17','1:00:00 PM','Green Bay Packers','Minnesota Vikings','43-34','U.S. Bank Stadium Minnesota Vikings'),
('2020-09-18','1:00:00 PM','New England Patriots','Miami Dolphins','21-11','Gillette Stadium New England Patriots'),
('2020-09-19','1:00:00 PM','Washington Football Team','Philadelphia Eagles','27-17','FedExField Washington Football Team'),
('2020-09-20','4:05:00 PM','Los Angeles Chargers','Cincinnati Bengals','16-13','Paul Brown Stadium Cincinnati Bengals'),
('2020-09-21','4:25:00 PM','New Orleans Saints','Tampa Bay Buccaneers','34-23','Mercedes-Benz Superdome New Orleans Saints'),
('2020-09-22','4:25:00 PM','Arizona Cardinals','San Francisco 49rs','24-20','Levis Stadium San Francisco 49rs'),
('2020-09-23','8:20:00 PM','Los Angeles Rams','Dallas Cowboys','20-17','SoFi Stadium Los Angeles Rams'),
('2020-09-24','7:10:00 PM','Pittsburgh Steelers','New York Giants','26-16','MetLife Stadium New York Giants'),
('2020-09-25','10:20:00 PM','Tennessee Titans','Denver Broncos','16-14','Empower Field at Mile High Denver Broncos'),
('2020-09-26','8:20:00 PM','Cleveland Browns','Cincinnati Bengals','35-30','FirstEnergy Stadium Cleveland Browns'),
('2020-09-27','1:00:00 PM','Chicago Bears','New York Giants','17-13','Soldier Field Chicago Bears'),
('2020-09-28','1:00:00 PM','Dallas Cowboys','Atlanta Falcons','40-39','AT&T Stadium Dallas Cowboys'),
('2020-09-29','1:00:00 PM','Green Bay Packers','Detroit Lions','42-21','Lambeau Field Green Bay Packers'),
('2020-09-30','1:00:00 PM','Indianapolis Colts','Minnesota Vikings','28-11','Lucas Oil Stadium Indianapolis Colts'),
('2020-10-01','1:00:00 PM','Buffalo Bills','Miami Dolphins','31-28','Hard Rock Stadium Miami Dolphins'),
('2020-10-02','1:00:00 PM','San Francisco 49rs','New York Jets','31-13','MetLife Stadium New York Jets'),
('2020-10-03','1:00:00 PM','Los Angeles Rams','Philadelphia Eagles','37-19','Lincoln Financial Field Philadelphia Eagles'),
('2020-10-04','1:00:00 PM','Pittsburgh Steelers','Denver Broncos','26-21','Heinze Field Pittsburgh Steelers'),
('2020-10-05','1:00:00 PM','Tampa Bay Buccaneers','Carolina Panthers','31-17','Raymond James Stadium Tampa Bay Buccaneers'),
('2020-10-06','1:00:00 PM','Tennessee Titans','Jacksonville Jaguars','33-30','Nissan Stadium Nashville Tennessee Titans'),
('2020-10-07','4:05:00 PM','Arizona Cardinals','Washington Football Team','30-15','State Farm Stadium Arizona Cardinals'),
('2020-10-08','4:25:00 PM','Baltimore Ravens','Houston Texans','33-16',' NRG Stadium Houston Texans'),
('2020-10-09','4:25:00 PM','Kansas City Chiefs','Los Angeles Chargers','23-20','SoFi Stadium Los Angeles Chargers'),
('2020-10-10','8:20:00 PM','Seattle Seahawks','New England Patriots','35-30','Lumen Field Seattle Seahawks'),
('2020-10-11','8:15:00 PM','Las Vegas Raiders','New Orleans Saints','34-24','Allegiant Stadium Las Vegas Raiders'),
('2020-10-12','8:20:00 PM','Miami Dolphins','Jacksonville Jaguars','31-13','TIAA Bank Field Jacksonville Jaguars'),
('2020-10-13','1:00:00 PM','Chicago Bears','Atlanta Falcons','30-26','Mercedes-Benz Stadium Atlanta Falcons'),
('2020-10-14','1:00:00 PM','Buffalo Bills','Los Angeles Rams','35-32','Bills Stadium Buffalo Bills'),
('2020-10-15','1:00:00 PM','Cleveland Browns','Washington Football Team','34-20','FirstEnergy Stadium Cleveland Browns'),
('2020-10-16','1:00:00 PM','Tennessee Titans','Minnesota Vikings','31-30','U.S. Bank Stadium Minnesota Vikings'),
('2020-10-17','1:00:00 PM','New England Patriots','Las Vegas Raiders','36-20','Gillette Stadium New England Patriots'),
('2020-10-18','1:00:00 PM','San Francisco 49rs','New York Giants','36-9','MetLife Stadium New York Giants'),
('2020-10-19','1:00:00 PM','Philadelphia Eagles','Philadelphia Eagles','23-23','Lincoln Financial Field Philadelphia Eagles'),
('2020-10-20','1:00:00 PM','Pittsburgh Steelers','Houston Texans','28-21','Heinze Field Pittsburgh Steelers'),
('2020-10-21','4:05:00 PM','Indianapolis Colts','New York Jets','36-7','Lucas Oil Stadium Indianapolis Colts'),
('2020-10-22','4:05:00 PM','Carolina Panthers','Los Angeles Chargers','21-16','SoFi Stadium Los Angeles Chargers'),
('2020-10-23','4:25:00 PM','Detroit Lions','Arizona Cardinals','26-23','State Farm Stadium Arizona Cardinals'),
('2020-10-24','4:25:00 PM','Tampa Bay Buccaneers','Denver Broncos','28-10','Empower Field at Mile High Denver Broncos'),
('2020-10-25','4:25:00 PM','Seattle Seahawks','Dallas Cowboys','38-31','Lumen Field Seattle Seahawks'),
('2020-10-26','8:20:00 PM','Green Bay Packers','New Orleans Saints','37-30','Mercedes-Benz Superdome New Orleans Saints'),
('2020-10-27','8:15:00 PM','Kansas City Chiefs','Baltimore Ravens','34-20','M&T Bank Stadium Baltimore Ravens'),
('2020-10-28','8:20:00 PM','Denver Broncos','New York Jets','37-28','MetLife Stadium New York Jets'),
('2020-10-29','1:00:00 PM','Carolina Panthers','Arizona Cardinals','31-21','Bank of America Stadium Carolina Panthers'),
('2020-10-30','1:00:00 PM','Cincinnati Bengals','Jacksonville Jaguars','33-25','Paul Brown Stadium Cincinnati Bengals'),
('2020-10-31','1:00:00 PM','Cleveland Browns','Dallas Cowboys','49-38','AT&T Stadium Dallas Cowboys'),
('2020-11-01','1:00:00 PM','New Orleans Saints','Detroit Lions','35-29','Ford Field Detroit Lions'),
('2020-11-02','1:00:00 PM','Minnesota Vikings','Houston Texans','31-23',' NRG Stadium Houston Texans'),
('2020-11-03','1:00:00 PM','Seattle Seahawks','Miami Dolphins','31-23','Hard Rock Stadium Miami Dolphins'),
('2020-11-04','1:00:00 PM','Tampa Bay Buccaneers','Los Angeles Chargers','38-31','Raymond James Stadium Tampa Bay Buccaneers'),
('2020-11-05','1:00:00 PM','Baltimore Ravens','Washington Football Team','31-17','FedExField Washington Football Team'),
('2020-11-06','4:05:00 PM','Los Angeles Rams','New York Giants','17-9','SoFi Stadium Los Angeles Rams'),
('2020-11-07','4:25:00 PM','Indianapolis Colts','Chicago Bears','19-11','Soldier Field Chicago Bears'),
('2020-11-08','4:25:00 PM','Buffalo Bills','Las Vegas Raiders','30-23','Allegiant Stadium Las Vegas Raiders'),
('2020-11-09','8:20:00 PM','Philadelphia Eagles','San Francisco 49rs','25-20','Levis Stadium San Francisco 49rs'),
('2020-11-10','7:05:00 PM','Kansas City Chiefs','New England Patriots','26-10','Arrowhead Stadium Kansas City Chiefs'),
('2020-11-11','9:00:00 PM','Green Bay Packers','Atlanta Falcons','30-16','Lambeau Field Green Bay Packers'),
('2020-11-12','8:20:00 PM','Chicago Bears','Tampa Bay Buccaneers','20-19','Soldier Field Chicago Bears'),
('2020-11-13','1:00:00 PM','Carolina Panthers','Atlanta Falcons','23-16','Mercedes-Benz Stadium Atlanta Falcons'),
('2020-11-14','1:00:00 PM','Baltimore Ravens','Cincinnati Bengals','27-3','M&T Bank Stadium Baltimore Ravens'),
('2020-11-15','1:00:00 PM','Houston Texans','Jacksonville Jaguars','30-14',' NRG Stadium Houston Texans'),
('2020-11-16','1:00:00 PM','Las Vegas Raiders','Kansas City Chiefs','40-32','Arrowhead Stadium Kansas City Chiefs'),
('2020-11-17','1:00:00 PM','Arizona Cardinals','New York Jets','30-10','MetLife Stadium New York Jets'),
('2020-11-18','1:00:00 PM','Pittsburgh Steelers','Philadelphia Eagles','38-29','Heinze Field Pittsburgh Steelers'),
('2020-11-19','1:00:00 PM','Los Angeles Rams','Washington Football Team','30-10','FedExField Washington Football Team'),
('2020-11-20','4:05:00 PM','Miami Dolphins','San Francisco 49rs','43-17','Levis Stadium San Francisco 49rs'),
('2020-11-21','4:25:00 PM','Cleveland Browns','Indianapolis Colts','32-23','FirstEnergy Stadium Cleveland Browns'),
('2020-11-22','4:25:00 PM','Dallas Cowboys','New York Giants','37-34','AT&T Stadium Dallas Cowboys'),
('2020-11-23','8:20:00 PM','Seattle Seahawks','Minnesota Vikings','27-26','Lumen Field Seattle Seahawks'),
('2020-11-24','8:15:00 PM','New Orleans Saints','Los Angeles Chargers','30-27','Mercedes-Benz Superdome New Orleans Saints'),
('2020-11-25','7:00:00 PM','Tennessee Titans','Buffalo Bills','42-16','Nissan Stadium Nashville Tennessee Titans'),
('2020-11-26','1:00:00 PM','Denver Broncos','New England Patriots','18-12','Gillette Stadium New England Patriots'),
('2020-11-27','1:00:00 PM','Chicago Bears','Carolina Panthers','23-16','Bank of America Stadium Carolina Panthers'),
('2020-11-28','1:00:00 PM','Indianapolis Colts','Cincinnati Bengals','31-27','Lucas Oil Stadium Indianapolis Colts'),
('2020-11-29','1:00:00 PM','Detroit Lions','Jacksonville Jaguars','34-16','TIAA Bank Field Jacksonville Jaguars'),
('2020-11-30','1:00:00 PM','Atlanta Falcons','Minnesota Vikings','40-23','U.S. Bank Stadium Minnesota Vikings'),
('2020-12-01','1:00:00 PM','New York Giants','Washington Football Team','20-19','MetLife Stadium New York Giants'),
('2020-12-02','1:00:00 PM','Baltimore Ravens','Philadelphia Eagles','30-28','Lincoln Financial Field Philadelphia Eagles'),
('2020-12-03','1:00:00 PM','Pittsburgh Steelers','Cleveland Browns','38-7','Heinze Field Pittsburgh Steelers'),
('2020-12-04','1:00:00 PM','Tennessee Titans','Houston Texans','42-36','Nissan Stadium Nashville Tennessee Titans'),
('2020-12-05','4:05:00 PM','Miami Dolphins','New York Jets','24-0','Hard Rock Stadium Miami Dolphins'),
('2020-12-06','4:25:00 PM','Tampa Bay Buccaneers','Green Bay Packers','38-10','Raymond James Stadium Tampa Bay Buccaneers'),
('2020-12-07','8:20:00 PM','San Francisco 49rs','Los Angeles Rams','24-16','Levis Stadium San Francisco 49rs'),
('2020-12-08','5:00:00 PM','Kansas City Chiefs','Buffalo Bills','26-17','Bills Stadium Buffalo Bills'),
('2020-12-09','8:15:00 PM','Arizona Cardinals','Dallas Cowboys','38-10','AT&T Stadium Dallas Cowboys'),
('2020-12-10','8:20:00 PM','Philadelphia Eagles','New York Giants','22-21','Lincoln Financial Field Philadelphia Eagles'),
('2020-12-11','1:00:00 PM','Pittsburgh Steelers','Tennessee Titans','27-24','Nissan Stadium Nashville Tennessee Titans'),
('2020-12-12','1:00:00 PM','Detroit Lions','Atlanta Falcons','23-22','Mercedes-Benz Stadium Atlanta Falcons'),
('2020-12-13','1:00:00 PM','Cleveland Browns','Cincinnati Bengals','37-34','Paul Brown Stadium Cincinnati Bengals'),
('2020-12-14','1:00:00 PM','Green Bay Packers','Houston Texans','35-20',' NRG Stadium Houston Texans'),
('2020-12-15','1:00:00 PM','New Orleans Saints','Carolina Panthers','27-24','Mercedes-Benz Superdome New Orleans Saints'),
('2020-12-16','1:00:00 PM','Buffalo Bills','New York Jets','18-10','MetLife Stadium New York Jets'),
('2020-12-17','1:00:00 PM','Washington Football Team','Dallas Cowboys','25-3','FedExField Washington Football Team'),
('2020-12-18','4:05:00 PM','Tampa Bay Buccaneers','Las Vegas Raiders','45-20','Allegiant Stadium Las Vegas Raiders'),
('2020-12-19','4:25:00 PM','Kansas City Chiefs','Denver Broncos','43-16','Empower Field at Mile High Denver Broncos'),
('2020-12-20','4:25:00 PM','San Francisco 49rs','New England Patriots','33-6','Gillette Stadium New England Patriots'),
('2020-12-21','4:25:00 PM','Los Angeles Chargers','Jacksonville Jaguars','39-29','SoFi Stadium Los Angeles Chargers'),
('2020-12-22','8:20:00 PM','Arizona Cardinals','Seattle Seahawks','37-34','State Farm Stadium Arizona Cardinals'),
('2020-12-23','8:15:00 PM','Los Angeles Rams','Chicago Bears','24-10','SoFi Stadium Los Angeles Rams'),
('2020-12-24','8:20:00 PM','Atlanta Falcons','Carolina Panthers','25-17','Bank of America Stadium Carolina Panthers'),
('2020-12-25','1:00:00 PM','Pittsburgh Steelers','Baltimore Ravens','28-24','M&T Bank Stadium Baltimore Ravens'),
('2020-12-26','1:00:00 PM','Buffalo Bills','New England Patriots','24-21','Bills Stadium Buffalo Bills'),
('2020-12-27','1:00:00 PM','Cincinnati Bengals','Tennessee Titans','31-20','Paul Brown Stadium Cincinnati Bengals'),
('2020-12-28','1:00:00 PM','Las Vegas Raiders','Cleveland Browns','16-6','FirstEnergy Stadium Cleveland Browns'),
('2020-12-29','1:00:00 PM','Indianapolis Colts','Detroit Lions','41-21','Ford Field Detroit Lions'),
('2020-12-30','1:00:00 PM','Minnesota Vikings','Green Bay Packers','28-22','Lambeau Field Green Bay Packers'),
('2020-12-31','1:00:00 PM','Kansas City Chiefs','New York Jets','35-9','Arrowhead Stadium Kansas City Chiefs'),
('2021-01-01','1:00:00 PM','Miami Dolphins','Los Angeles Rams','28-17','Hard Rock Stadium Miami Dolphins'),
('2021-01-02','4:05:00 PM','Denver Broncos','Los Angeles Chargers','31-30','Empower Field at Mile High Denver Broncos'),
('2021-01-03','4:25:00 PM','New Orleans Saints','Chicago Bears','26-23','Soldier Field Chicago Bears'),
('2021-01-04','4:25:00 PM','Seattle Seahawks','San Francisco 49rs','37-27','Lumen Field Seattle Seahawks'),
('2021-01-05','8:20:00 PM','Philadelphia Eagles','Dallas Cowboys','23-9','Lincoln Financial Field Philadelphia Eagles'),
('2021-01-06','8:15:00 PM','Tampa Bay Buccaneers','New York Giants','25-23','MetLife Stadium New York Giants'),
('2021-01-07','8:20:00 PM','Green Bay Packers','San Francisco 49rs','34-17','Levis Stadium San Francisco 49rs'),
('2021-01-08','1:00:00 PM','Atlanta Falcons','Denver Broncos','34-27','Mercedes-Benz Stadium Atlanta Falcons'),
('2021-01-09','1:00:00 PM','Buffalo Bills','Seattle Seahawks','44-34','Bills Stadium Buffalo Bills'),
('2021-01-10','1:00:00 PM','Baltimore Ravens','Indianapolis Colts','24-10','Lucas Oil Stadium Indianapolis Colts'),
('2021-01-11','1:00:00 PM','Houston Texans','Jacksonville Jaguars','27-25','TIAA Bank Field Jacksonville Jaguars'),
('2021-01-12','1:00:00 PM','Kansas City Chiefs','Carolina Panthers','33-31','Arrowhead Stadium Kansas City Chiefs'),
('2021-01-13','1:00:00 PM','Minnesota Vikings','Detroit Lions','34-20','U.S. Bank Stadium Minnesota Vikings'),
('2021-01-14','1:00:00 PM','Tennessee Titans','Chicago Bears','24-17','Nissan Stadium Nashville Tennessee Titans'),
('2021-01-15','1:00:00 PM','New York Giants','Washington Football Team','23-20','FedExField Washington Football Team'),
('2021-01-16','4:05:00 PM','Las Vegas Raiders','Los Angeles Chargers','31-26','SoFi Stadium Los Angeles Chargers'),
('2021-01-17','4:25:00 PM','Miami Dolphins','Arizona Cardinals','34-31','State Farm Stadium Arizona Cardinals'),
('2021-01-18','4:25:00 PM','Pittsburgh Steelers','Dallas Cowboys','24-19','AT&T Stadium Dallas Cowboys'),
('2021-01-19','8:20:00 PM','New Orleans Saints','Tampa Bay Buccaneers','38-3','Raymond James Stadium Tampa Bay Buccaneers'),
('2021-01-20','8:15:00 PM','New England Patriots','New York Jets','30-27','MetLife Stadium New York Jets'),
('2021-01-21','8:20:00 PM','Indianapolis Colts','Tennessee Titans','34-17','Nissan Stadium Nashville Tennessee Titans'),
('2021-01-22','1:00:00 PM','Tampa Bay Buccaneers','Carolina Panthers','46-23','Bank of America Stadium Carolina Panthers'),
('2021-01-23','1:00:00 PM','Cleveland Browns','Houston Texans','10-7','FirstEnergy Stadium Cleveland Browns'),
('2021-01-24','1:00:00 PM','Detroit Lions','Washington Football Team','30-27','Ford Field Detroit Lions'),
('2021-01-25','1:00:00 PM','Green Bay Packers','Jacksonville Jaguars','24-20','Lambeau Field Green Bay Packers'),
('2021-01-26','1:00:00 PM','New York Giants','Philadelphia Eagles','27-17','MetLife Stadium New York Giants'),
('2021-01-27','4:05:00 PM','Miami Dolphins','Los Angeles Chargers','29-21','Hard Rock Stadium Miami Dolphins'),
('2021-01-28','4:05:00 PM','Arizona Cardinals','Buffalo Bills','32-30','State Farm Stadium Arizona Cardinals'),
('2021-01-29','4:05:00 PM','Las Vegas Raiders','Denver Broncos','37-12','Allegiant Stadium Las Vegas Raiders'),
('2021-01-30','4:25:00 PM','Pittsburgh Steelers','Cincinnati Bengals','36-10','Heinze Field Pittsburgh Steelers'),
('2021-01-31','4:25:00 PM','Los Angeles Rams','Seattle Seahawks','23-16','SoFi Stadium Los Angeles Rams'),
('2021-02-01','4:25:00 PM','New Orleans Saints','San Francisco 49rs','27-13','Mercedes-Benz Superdome New Orleans Saints'),
('2021-02-02','8:20:00 PM','New England Patriots','Baltimore Ravens','23-17','Gillette Stadium New England Patriots'),
('2021-02-03','8:15:00 PM','Minnesota Vikings','Chicago Bears','19-13','Soldier Field Chicago Bears'),
('2021-02-04','8:20:00 PM','Seattle Seahawks','Arizona Cardinals','28-21','Lumen Field Seattle Seahawks'),
('2021-02-05','1:00:00 PM','Tennessee Titans','Baltimore Ravens','30-24','M&T Bank Stadium Baltimore Ravens'),
('2021-02-06','1:00:00 PM','Carolina Panthers','Detroit Lions','20-0','Bank of America Stadium Carolina Panthers'),
('2021-02-07','1:00:00 PM','Cleveland Browns','Philadelphia Eagles','22-17','FirstEnergy Stadium Cleveland Browns'),
('2021-02-08','1:00:00 PM','Houston Texans','New England Patriots','27-20',' NRG Stadium Houston Texans'),
('2021-02-09','1:00:00 PM','Pittsburgh Steelers','Jacksonville Jaguars','27-3','TIAA Bank Field Jacksonville Jaguars'),
('2021-02-10','1:00:00 PM','New Orleans Saints','Atlanta Falcons','24-9','Mercedes-Benz Superdome New Orleans Saints'),
('2021-02-11','1:00:00 PM','Washington Football Team','Cincinnati Bengals','20-9','FedExField Washington Football Team'),
('2021-02-12','4:05:00 PM','Denver Broncos','Miami Dolphins','20-13','Empower Field at Mile High Denver Broncos'),
('2021-02-13','4:05:00 PM','Los Angeles Chargers','New York Jets','34-28','SoFi Stadium Los Angeles Chargers'),
('2021-02-14','4:25:00 PM','Indianapolis Colts','Green Bay Packers','34-31','Lucas Oil Stadium Indianapolis Colts'),
('2021-02-15','4:25:00 PM','Dallas Cowboys','Minnesota Vikings','31-28','U.S. Bank Stadium Minnesota Vikings'),
('2021-02-16','8:20:00 PM','Kansas City Chiefs','Las Vegas Raiders','35-31','Allegiant Stadium Las Vegas Raiders'),
('2021-02-17','8:15:00 PM','Los Angeles Rams','Tampa Bay Buccaneers','27-24','Raymond James Stadium Tampa Bay Buccaneers'),
('2021-02-18','12:30:00 PM','Houston Texans','Detroit Lions','41-25','Ford Field Detroit Lions'),
('2021-02-19','4:30:00 PM','Washington Football Team','Dallas Cowboys','41-16','AT&T Stadium Dallas Cowboys'),
('2021-02-20','1:00:00 PM','Atlanta Falcons','Las Vegas Raiders','43-6','Mercedes-Benz Stadium Atlanta Falcons'),
('2021-02-21','1:00:00 PM','Buffalo Bills','Los Angeles Chargers','27-17','Bills Stadium Buffalo Bills'),
('2021-02-22','1:00:00 PM','New York Giants','Cincinnati Bengals','19-17','Paul Brown Stadium Cincinnati Bengals'),
('2021-02-23','1:00:00 PM','Tennessee Titans','Indianapolis Colts','45-26','Lucas Oil Stadium Indianapolis Colts'),
('2021-02-24','1:00:00 PM','Cleveland Browns','Jacksonville Jaguars','27-25','TIAA Bank Field Jacksonville Jaguars'),
('2021-02-25','1:00:00 PM','Minnesota Vikings','Carolina Panthers','28-27','U.S. Bank Stadium Minnesota Vikings'),
('2021-02-26','1:00:00 PM','New England Patriots','Arizona Cardinals','20-17','Gillette Stadium New England Patriots'),
('2021-02-27','1:00:00 PM','Miami Dolphins','New York Jets','20-3','MetLife Stadium New York Jets'),
('2021-02-28','4:05:00 PM','New Orleans Saints','Denver Broncos','31-3','Empower Field at Mile High Denver Broncos'),
('2021-03-01','4:05:00 PM','San Francisco 49rs','Los Angeles Rams','23-20','SoFi Stadium Los Angeles Rams'),
('2021-03-02','4:25:00 PM','Kansas City Chiefs','Tampa Bay Buccaneers','27-24','Raymond James Stadium Tampa Bay Buccaneers'),
('2021-03-03','8:20:00 PM','Green Bay Packers','Chicago Bears','41-25','Lambeau Field Green Bay Packers'),
('2021-03-04','8:15:00 PM','Seattle Seahawks','Philadelphia Eagles','23-17','Lincoln Financial Field Philadelphia Eagles'),
('2021-03-05','3:40:00 PM','Pittsburgh Steelers','Baltimore Ravens','19-14','Heinze Field Pittsburgh Steelers'),
('2021-03-06','1:00:00 PM','New Orleans Saints','Atlanta Falcons','21-16','Mercedes-Benz Stadium Atlanta Falcons'),
('2021-03-07','1:00:00 PM','Detroit Lions','Chicago Bears','34-30','Soldier Field Chicago Bears'),
('2021-03-08','1:00:00 PM','Indianapolis Colts','Houston Texans','26-20',' NRG Stadium Houston Texans'),
('2021-03-09','1:00:00 PM','Miami Dolphins','Cincinnati Bengals','19-7','Hard Rock Stadium Miami Dolphins'),
('2021-03-10','1:00:00 PM','Minnesota Vikings','Jacksonville Jaguars','27-24','U.S. Bank Stadium Minnesota Vikings'),
('2021-03-11','1:00:00 PM','Las Vegas Raiders','New York Jets','31-28','MetLife Stadium New York Jets'),
('2021-03-12','1:00:00 PM','Cleveland Browns','Tennessee Titans','41-35','Nissan Stadium Nashville Tennessee Titans'),
('2021-03-13','4:05:00 PM','Los Angeles Rams','Arizona Cardinals','38-28','State Farm Stadium Arizona Cardinals'),
('2021-03-14','4:05:00 PM','New York Giants','Seattle Seahawks','17-12','Lumen Field Seattle Seahawks'),
('2021-03-15','4:25:00 PM','Green Bay Packers','Philadelphia Eagles','30-16','Lambeau Field Green Bay Packers'),
('2021-03-16','4:25:00 PM','New England Patriots','Los Angeles Chargers','45-0','SoFi Stadium Los Angeles Chargers'),
('2021-03-17','8:20:00 PM','Kansas City Chiefs','Denver Broncos','22-16','Arrowhead Stadium Kansas City Chiefs'),
('2021-03-18','5:00:00 PM','Washington Football Team','Pittsburgh Steelers','23-17','Heinze Field Pittsburgh Steelers'),
('2021-03-19','8:15:00 PM','Buffalo Bills','San Francisco 49rs','34-24','Levis Stadium San Francisco 49rs'),
('2021-03-20','8:05:00 PM','Baltimore Ravens','Dallas Cowboys','34-17','M&T Bank Stadium Baltimore Ravens'),
('2021-03-21','8:20:00 PM','Los Angeles Rams','New England Patriots','24-3','SoFi Stadium Los Angeles Rams'),
('2021-03-22','1:00:00 PM','Denver Broncos','Carolina Panthers','32-27','Bank of America Stadium Carolina Panthers'),
('2021-03-23','1:00:00 PM','Chicago Bears','Houston Texans','36-7','Soldier Field Chicago Bears'),
('2021-03-24','1:00:00 PM','Dallas Cowboys','Cincinnati Bengals','30-7','Paul Brown Stadium Cincinnati Bengals'),
('2021-03-25','1:00:00 PM','Tennessee Titans','Jacksonville Jaguars','31-10','TIAA Bank Field Jacksonville Jaguars'),
('2021-03-26','1:00:00 PM','Kansas City Chiefs','Miami Dolphins','33-27','Hard Rock Stadium Miami Dolphins'),
('2021-03-27','1:00:00 PM','Arizona Cardinals','New York Giants','26-7','MetLife Stadium New York Giants'),
('2021-03-28','1:00:00 PM','Tampa Bay Buccaneers','Minnesota Vikings','26-14','Raymond James Stadium Tampa Bay Buccaneers'),
('2021-03-29','4:05:00 PM','Indianapolis Colts','Las Vegas Raiders','44-27','Allegiant Stadium Las Vegas Raiders'),
('2021-03-30','4:05:00 PM','Seattle Seahawks','New York Jets','40-3','Lumen Field Seattle Seahawks'),
('2021-03-31','4:25:00 PM','Green Bay Packers','Detroit Lions','31-24','Ford Field Detroit Lions'),
('2021-04-01','4:25:00 PM','Los Angeles Chargers','Atlanta Falcons','20-17','SoFi Stadium Los Angeles Chargers'),
('2021-04-02','4:25:00 PM','Philadelphia Eagles','New Orleans Saints','24-21','Lincoln Financial Field Philadelphia Eagles'),
('2021-04-03','4:25:00 PM','Washington Football Team','San Francisco 49rs','23-15','Levis Stadium San Francisco 49rs'),
('2021-04-04','8:20:00 PM','Buffalo Bills','Pittsburgh Steelers','26-15','Bills Stadium Buffalo Bills'),
('2021-04-05','8:15:00 PM','Baltimore Ravens','Cleveland Browns','47-42','FirstEnergy Stadium Cleveland Browns'),
('2021-04-06','8:20:00 PM','Los Angeles Chargers','Las Vegas Raiders','30-27','Allegiant Stadium Las Vegas Raiders'),
('2021-04-07','4:30:00 PM','Buffalo Bills','Denver Broncos','48-19','Empower Field at Mile High Denver Broncos'),
('2021-04-08','8:15:00 PM','Green Bay Packers','Carolina Panthers','24-16','Lambeau Field Green Bay Packers'),
('2021-04-09','1:00:00 PM','Tampa Bay Buccaneers','Atlanta Falcons','31-27','Mercedes-Benz Stadium Atlanta Falcons'),
('2021-04-10','1:00:00 PM','Baltimore Ravens','Jacksonville Jaguars','40-14','M&T Bank Stadium Baltimore Ravens'),
('2021-04-11','1:00:00 PM','Indianapolis Colts','Houston Texans','27-20','Lucas Oil Stadium Indianapolis Colts'),
('2021-04-12','1:00:00 PM','Miami Dolphins','New England Patriots','22-12','Hard Rock Stadium Miami Dolphins'),
('2021-04-13','1:00:00 PM','Chicago Bears','Minnesota Vikings','33-27','U.S. Bank Stadium Minnesota Vikings'),
('2021-04-14','1:00:00 PM','Tennessee Titans','Detroit Lions','46-25','Nissan Stadium Nashville Tennessee Titans'),
('2021-04-15','1:00:00 PM','Seattle Seahawks','Washington Football Team','20-15','FedExField Washington Football Team'),
('2021-04-16','1:00:00 PM','Dallas Cowboys','San Francisco 49rs','41-33','AT&T Stadium Dallas Cowboys'),
('2021-04-17','4:05:00 PM','Arizona Cardinals','Philadelphia Eagles','33-26','State Farm Stadium Arizona Cardinals'),
('2021-04-18','4:05:00 PM','New York Jets','Los Angeles Rams','23-20','SoFi Stadium Los Angeles Rams'),
('2021-04-19','4:25:00 PM','Kansas City Chiefs','New Orleans Saints','32-29','Mercedes-Benz Superdome New Orleans Saints'),
('2021-04-20','8:20:00 PM','Cleveland Browns','New York Giants','20-6','MetLife Stadium New York Giants'),
('2021-04-21','8:15:00 PM','Cincinnati Bengals','Pittsburgh Steelers','27-17','Paul Brown Stadium Cincinnati Bengals'),
('2021-04-22','4:30:00 PM','New Orleans Saints','Minnesota Vikings','52-33','Mercedes-Benz Superdome New Orleans Saints'),
('2021-04-23','1:00:00 PM','Tampa Bay Buccaneers','Detroit Lions','47-7','Ford Field Detroit Lions'),
('2021-04-24','4:30:00 PM','San Francisco 49rs','Arizona Cardinals','20-12','State Farm Stadium Arizona Cardinals'),
('2021-04-25','8:15:00 PM','Miami Dolphins','Las Vegas Raiders','26-25','Allegiant Stadium Las Vegas Raiders'),
('2021-04-26','1:00:00 PM','Baltimore Ravens','New York Giants','27-13','M&T Bank Stadium Baltimore Ravens'),
('2021-04-27','1:00:00 PM','Cincinnati Bengals','Houston Texans','37-31',' NRG Stadium Houston Texans'),
('2021-04-28','1:00:00 PM','Chicago Bears','Jacksonville Jaguars','41-17','TIAA Bank Field Jacksonville Jaguars'),
('2021-04-29','1:00:00 PM','Kansas City Chiefs','Atlanta Falcons','17-14','Arrowhead Stadium Kansas City Chiefs'),
('2021-04-30','1:00:00 PM','New York Jets','Cleveland Browns','23-16','MetLife Stadium New York Jets'),
('2021-05-01','1:00:00 PM','Pittsburgh Steelers','Indianapolis Colts','28-24','Heinze Field Pittsburgh Steelers'),
('2021-05-02','4:05:00 PM','Carolina Panthers','Washington Football Team','20-13','FedExField Washington Football Team'),
('2021-05-03','4:05:00 PM','Los Angeles Chargers','Denver Broncos','19-16','SoFi Stadium Los Angeles Chargers'),
('2021-05-04','4:25:00 PM','Seattle Seahawks','Los Angeles Rams','20-9','Lumen Field Seattle Seahawks'),
('2021-05-05','4:25:00 PM','Dallas Cowboys','Philadelphia Eagles','37-17','AT&T Stadium Dallas Cowboys'),
('2021-05-06','8:20:00 PM','Green Bay Packers','Tennessee Titans','40-14','Lambeau Field Green Bay Packers'),
('2021-05-07','8:15:00 PM','Buffalo Bills','New England Patriots','38-9','Gillette Stadium New England Patriots'),
('2021-05-08','1:00:00 PM','Buffalo Bills','Miami Dolphins','56-26','Bills Stadium Buffalo Bills'),
('2021-05-09','1:00:00 PM','Baltimore Ravens','Cincinnati Bengals','38-3','Paul Brown Stadium Cincinnati Bengals'),
('2021-05-10','1:00:00 PM','Cleveland Browns','Pittsburgh Steelers','24-22','FirstEnergy Stadium Cleveland Browns'),
('2021-05-11','1:00:00 PM','Minnesota Vikings','Detroit Lions','37-35','Ford Field Detroit Lions'),
('2021-05-12','1:00:00 PM','New England Patriots','New York Jets','28-14','Gillette Stadium New England Patriots'),
('2021-05-13','1:00:00 PM','New York Giants','Dallas Cowboys','23-19','MetLife Stadium New York Giants'),
('2021-05-14','1:00:00 PM','Tampa Bay Buccaneers','Atlanta Falcons','44-27','Raymond James Stadium Tampa Bay Buccaneers'),
('2021-05-15','4:25:00 PM','New Orleans Saints','Carolina Panthers','33-7','Bank of America Stadium Carolina Panthers'),
('2021-05-16','4:25:00 PM','Green Bay Packers','Chicago Bears','35-16','Soldier Field Chicago Bears'),
('2021-05-17','4:25:00 PM','Tennessee Titans','Houston Texans','41-38',' NRG Stadium Houston Texans'),
('2021-05-18','4:25:00 PM','Indianapolis Colts','Jacksonville Jaguars','28-14','Lucas Oil Stadium Indianapolis Colts'),
('2021-05-19','4:25:00 PM','Los Angeles Chargers','Kansas City Chiefs','38-21','Arrowhead Stadium Kansas City Chiefs'),
('2021-05-20','4:25:00 PM','Las Vegas Raiders','Denver Broncos','32-31','Empower Field at Mile High Denver Broncos'),
('2021-05-21','4:25:00 PM','Los Angeles Rams','Arizona Cardinals','18-7','SoFi Stadium Los Angeles Rams'),
('2021-05-22','4:25:00 PM','Seattle Seahawks','San Francisco 49rs','26-23','Levis Stadium San Francisco 49rs'),
('2021-05-23','8:20:00 PM','Washington Football Team','Philadelphia Eagles','20-14','Lincoln Financial Field Philadelphia Eagles')

SELECT * FROM Game

--Insert Player data into Player table
INSERT INTO Player (Player_First_Name, Player_Last_Name, Age, Player_Position, Team_ID, Game_ID)
VALUES ('A.J.','Brown','23','WR', (SELECT Team_ID FROM Team Where Team_ID = 31), (SELECT Game_ID FROM Game Where Game_ID = 7)),
('Aaron','Rodgers','37','QB', (SELECT Team_ID FROM Team Where Team_ID = 12), (SELECT Game_ID FROM Game Where Game_ID = 8)),
('Adam','Thielen','30','WR', (SELECT Team_ID FROM Team Where Team_ID = 21), (SELECT Game_ID FROM Game Where Game_ID = 8)),
('Alvin','Kamara','25','RB', (SELECT Team_ID FROM Team Where Team_ID = 23), (SELECT Game_ID FROM Game Where Game_ID = 12)),
('Antonio','Gibson','22','RB', (SELECT Team_ID FROM Team Where Team_ID = 32), (SELECT Game_ID FROM Game Where Game_ID = 10)),
('Ben','Roethlisberger','38','QB', (SELECT Team_ID FROM Team Where Team_ID = 27), (SELECT Game_ID FROM Game Where Game_ID = 15)),
('Cairo','Santos','29','K', (SELECT Team_ID FROM Team Where Team_ID = 6), (SELECT Game_ID FROM Game Where Game_ID = 6)),
('Calvin','Ridley','26','WR', (SELECT Team_ID FROM Team Where Team_ID = 2), (SELECT Game_ID FROM Game Where Game_ID = 34)),
('Cam','Newton','31','QB', (SELECT Team_ID FROM Team Where Team_ID = 22), (SELECT Game_ID FROM Game Where Game_ID = 26)),
('Dalvin','Cook','25','RB', (SELECT Team_ID FROM Team Where Team_ID = 21), (SELECT Game_ID FROM Game Where Game_ID = 37)),
('Daniel','Carlson','26','K', (SELECT Team_ID FROM Team Where Team_ID = 17), (SELECT Game_ID FROM Game Where Game_ID = 60)),
('Darren','Waller','28','TE', (SELECT Team_ID FROM Team Where Team_ID = 17), (SELECT Game_ID FROM Game Where Game_ID = 68)),
('Davante','Adams','28','WR', (SELECT Team_ID FROM Team Where Team_ID = 12), (SELECT Game_ID FROM Game Where Game_ID = 88)),
('Derrick','Henry','27','RB', (SELECT Team_ID FROM Team Where Team_ID = 31), (SELECT Game_ID FROM Game Where Game_ID = 86)),
('Deshaun','Watson','25','QB', (SELECT Team_ID FROM Team Where Team_ID = 13), (SELECT Game_ID FROM Game Where Game_ID = 86)),
('DK','Metcalf','23','WR', (SELECT Team_ID FROM Team Where Team_ID = 29), (SELECT Game_ID FROM Game Where Game_ID = 104)),
('Greg','Zuerlein','33','K', (SELECT Team_ID FROM Team Where Team_ID = 19), (SELECT Game_ID FROM Game Where Game_ID = 105)),
('Hayden','Hurst','27','TE', (SELECT Team_ID FROM Team Where Team_ID = 3), (SELECT Game_ID FROM Game Where Game_ID = 107)),
('Jared','Cook','33','TE', (SELECT Team_ID FROM Team Where Team_ID = 23), (SELECT Game_ID FROM Game Where Game_ID = 145)),
('Jason','Sanders','25','K', (SELECT Team_ID FROM Team Where Team_ID = 20), (SELECT Game_ID FROM Game Where Game_ID = 140)),
('Jimmy','Graham','34','TE', (SELECT Team_ID FROM Team Where Team_ID = 12), (SELECT Game_ID FROM Game Where Game_ID = 158)),
('Jonathan','Taylor','22','RB', (SELECT Team_ID FROM Team Where Team_ID = 14), (SELECT Game_ID FROM Game Where Game_ID = 158)),
('Josh','Allen','24','QB', (SELECT Team_ID FROM Team Where Team_ID = 4), (SELECT Game_ID FROM Game Where Game_ID = 165)),
('Josh','Jacobs','23','RB', (SELECT Team_ID FROM Team Where Team_ID = 17), (SELECT Game_ID FROM Game Where Game_ID = 164)),
('Justin','Herbert','22','QB', (SELECT Team_ID FROM Team Where Team_ID = 18), (SELECT Game_ID FROM Game Where Game_ID = 204)),
('Justin','Tucker','31','K', (SELECT Team_ID FROM Team Where Team_ID = 3), (SELECT Game_ID FROM Game Where Game_ID = 177)),
('Kenyan','Drake','27','RB', (SELECT Team_ID FROM Team Where Team_ID = 1), (SELECT Game_ID FROM Game Where Game_ID = 220)),
('Kirk','Cousins','32','QB', (SELECT Team_ID FROM Team Where Team_ID = 21), (SELECT Game_ID FROM Game Where Game_ID = 225)),
('Kyler','Murray','23','QB', (SELECT Team_ID FROM Team Where Team_ID = 1), (SELECT Game_ID FROM Game Where Game_ID = 227)),
('Logan','Thomas','29','TE', (SELECT Team_ID FROM Team Where Team_ID = 32), (SELECT Game_ID FROM Game Where Game_ID = 235)),
('Mark','Andrews','25','TE', (SELECT Team_ID FROM Team Where Team_ID = 3), (SELECT Game_ID FROM Game Where Game_ID = 229)),
('Mike','Evans','27','WR', (SELECT Team_ID FROM Team Where Team_ID = 30), (SELECT Game_ID FROM Game Where Game_ID = 226)),
('Mike','Gesicki','25','TE', (SELECT Team_ID FROM Team Where Team_ID = 20), (SELECT Game_ID FROM Game Where Game_ID = 228)),
('Nick','Chubb','25','RB', (SELECT Team_ID FROM Team Where Team_ID = 8), (SELECT Game_ID FROM Game Where Game_ID = 223)),
('Patrick','Mahomes','25','QB', (SELECT Team_ID FROM Team Where Team_ID = 16), (SELECT Game_ID FROM Game Where Game_ID = 222)),
('Rob','Gronkowski','31','TE', (SELECT Team_ID FROM Team Where Team_ID = 30), (SELECT Game_ID FROM Game Where Game_ID = 212)),
('Robert','Tonyan','26','TE', (SELECT Team_ID FROM Team Where Team_ID = 12), (SELECT Game_ID FROM Game Where Game_ID = 239)),
('Rodrigo','Blankenship','24','K', (SELECT Team_ID FROM Team Where Team_ID = 14), (SELECT Game_ID FROM Game Where Game_ID = 251)),
('Russell','Wilson','32','QB', (SELECT Team_ID FROM Team Where Team_ID = 29), (SELECT Game_ID FROM Game Where Game_ID = 255)),
('Ryan','Tannehill','32','QB', (SELECT Team_ID FROM Team Where Team_ID = 31), (SELECT Game_ID FROM Game Where Game_ID = 158)),
('Ryan','Succop','34','K', (SELECT Team_ID FROM Team Where Team_ID = 30), (SELECT Game_ID FROM Game Where Game_ID = 212)),
('T.J.','Hockenson','23','TE', (SELECT Team_ID FROM Team Where Team_ID = 11), (SELECT Game_ID FROM Game Where Game_ID = 162)),
('Tom','Brady','43','QB', (SELECT Team_ID FROM Team Where Team_ID = 30), (SELECT Game_ID FROM Game Where Game_ID = 161)),
('Travis','Kelce','31','TE', (SELECT Team_ID FROM Team Where Team_ID = 16), (SELECT Game_ID FROM Game Where Game_ID = 113)),
('Tyler','Lockett','28','WR', (SELECT Team_ID FROM Team Where Team_ID = 29), (SELECT Game_ID FROM Game Where Game_ID = 117)),
('Tyler','Bass','24','K', (SELECT Team_ID FROM Team Where Team_ID = 4), (SELECT Game_ID FROM Game Where Game_ID = 116)),
('Tyreek','Hill','26','WR', (SELECT Team_ID FROM Team Where Team_ID = 16), (SELECT Game_ID FROM Game Where Game_ID = 90)),
('Wil','Lutz','26','K', (SELECT Team_ID FROM Team Where Team_ID = 23), (SELECT Game_ID FROM Game Where Game_ID = 32)),
('Younghoe','Zoo','26','K', (SELECT Team_ID FROM Team Where Team_ID = 2), (SELECT Game_ID FROM Game Where Game_ID = 34))

SELECT * FROM Player

--Insert Stats data into Stat table
INSERT INTO Stat (Stat_Position, Number_of_Yards, Touchdowns, Total_Field_Goal_Points)
VALUES ('WR','1075','11','0'),
('QB','4299','48','0'),
('WR','925','14','0'),
('RB','932','16','0'),
('RB','795','11','0'),
('QB','3803','33','0'),
('K','0','0','126'),
('WR','1374','9','0'),
('RB','592','12','0'),
('RB','1557','16','0'),
('K','0','0','144'),
('WR','1196','9','0'),
('WR','1374','18','0'),
('RB','2027','17','0'),
('QB','4823','33','0'),
('WR','1303','10','0'),
('K','0','0','135'),
('WR','571','6','0'),
('WR','504','7','0'),
('K','0','0','144'),
('WR','456','8','0'),
('RB','1169','11','0'),
('QB','4544','37','0'),
('RB','1065','12','0'),
('QB','4336','31','0'),
('K','0','0','130'),
('RB','955','10','0'),
('QB','4265','35','0'),
('RB','819','11','0'),
('WR','670','6','0'),
('WR','701','7','0'),
('WR','1006','13','0'),
('WR','703','6','0'),
('RB','1067','12','0'),
('QB','4740','38','0'),
('WR','623','7','0'),
('WR','586','11','0'),
('K','0','0','139'),
('QB','4212','40','0'),
('QB','3819','33','0'),
('K','0','0','136'),
('WR','723','6','0'),
('QB','4633','40','0'),
('WR','1416','11','0'),
('WR','1054','10','0'),
('K','0','0','141'),
('WR','1276','15','0'),
('K','0','0','126'),
('K','0','0','144')

SELECT * FROM Stat

--Insert Game_ID and Team_ID data into Team_Game_List table
INSERT INTO Team_Game_List (Game_ID, Team_ID)
VALUES
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Arrowhead Stadium Kansas City Chiefs' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Kansas City Chiefs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Mercedes-Benz Stadium Atlanta Falcons' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Atlanta Falcons')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'M&T Bank Stadium Baltimore Ravens' AND Team_Lost = 'Cleveland Browns'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Baltimore Ravens')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Bills Stadium Buffalo Bills' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Buffalo Bills')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Las Vegas Raiders' AND Stadium = 'Bank of America Stadium Carolina Panthers' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Carolina Panthers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Chicago Bears' AND Stadium = 'Ford Field Detroit Lions' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Detroit Lions')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Jacksonville Jaguars' AND Stadium = 'TIAA Bank Field Jacksonville Jaguars' AND Team_Lost = 'Indianapolis Colts'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Jacksonville Jaguars')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'U.S. Bank Stadium Minnesota Vikings' AND Team_Lost = 'Minnesota Vikings'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Minnesota Vikings')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New England Patriots' AND Stadium = 'Gillette Stadium New England Patriots' AND Team_Lost = 'Miami Dolphins'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New England Patriots')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Washington Football Team' AND Stadium = 'FedExField Washington Football Team' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Washington Football Team')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Chargers' AND Stadium = 'Paul Brown Stadium Cincinnati Bengals' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cincinnati Bengals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Mercedes-Benz Superdome New Orleans Saints' AND Team_Lost = 'Tampa Bay Buccaneers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New Orleans Saints')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Arizona Cardinals' AND Stadium = 'Levis Stadium San Francisco 49rs' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'San Francisco 49rs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'SoFi Stadium Los Angeles Rams' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Rams')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'MetLife Stadium New York Giants' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Giants')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'Empower Field at Mile High Denver Broncos' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Denver Broncos')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'FirstEnergy Stadium Cleveland Browns' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cleveland Browns')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Chicago Bears' AND Stadium = 'Soldier Field Chicago Bears' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Chicago Bears')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Dallas Cowboys' AND Stadium = 'AT&T Stadium Dallas Cowboys' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Dallas Cowboys')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Lambeau Field Green Bay Packers' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Green Bay Packers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Lucas Oil Stadium Indianapolis Colts' AND Team_Lost = 'Minnesota Vikings'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Indianapolis Colts')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Hard Rock Stadium Miami Dolphins' AND Team_Lost = 'Miami Dolphins'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Miami Dolphins')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'San Francisco 49rs' AND Stadium = 'MetLife Stadium New York Jets' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Jets')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'Lincoln Financial Field Philadelphia Eagles' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Philadelphia Eagles')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'Heinze Field Pittsburgh Steelers' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Pittsburgh Steelers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Raymond James Stadium Tampa Bay Buccaneers' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tampa Bay Buccaneers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'Nissan Stadium Nashville Tennessee Titans' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tennessee Titans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Arizona Cardinals' AND Stadium = 'State Farm Stadium Arizona Cardinals' AND Team_Lost = 'Washington Football Team'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Arizona Cardinals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = ' NRG Stadium Houston Texans' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Houston Texans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'SoFi Stadium Los Angeles Chargers' AND Team_Lost = 'Los Angeles Chargers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Chargers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Lumen Field Seattle Seahawks' AND Team_Lost = 'New England Patriots'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Seattle Seahawks')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Las Vegas Raiders' AND Stadium = 'Allegiant Stadium Las Vegas Raiders' AND Team_Lost = 'New Orleans Saints'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Las Vegas Raiders')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'TIAA Bank Field Jacksonville Jaguars' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Jacksonville Jaguars')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Chicago Bears' AND Stadium = 'Mercedes-Benz Stadium Atlanta Falcons' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Atlanta Falcons')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Bills Stadium Buffalo Bills' AND Team_Lost = 'Los Angeles Rams'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Buffalo Bills')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'FirstEnergy Stadium Cleveland Browns' AND Team_Lost = 'Washington Football Team'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cleveland Browns')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'U.S. Bank Stadium Minnesota Vikings' AND Team_Lost = 'Minnesota Vikings'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Minnesota Vikings')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New England Patriots' AND Stadium = 'Gillette Stadium New England Patriots' AND Team_Lost = 'Las Vegas Raiders'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New England Patriots')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'San Francisco 49rs' AND Stadium = 'MetLife Stadium New York Giants' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Giants')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Philadelphia Eagles' AND Stadium = 'Lincoln Financial Field Philadelphia Eagles' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Philadelphia Eagles')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'Heinze Field Pittsburgh Steelers' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Pittsburgh Steelers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Lucas Oil Stadium Indianapolis Colts' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Indianapolis Colts')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Carolina Panthers' AND Stadium = 'SoFi Stadium Los Angeles Chargers' AND Team_Lost = 'Los Angeles Chargers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Chargers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Detroit Lions' AND Stadium = 'State Farm Stadium Arizona Cardinals' AND Team_Lost = 'Arizona Cardinals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Arizona Cardinals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Empower Field at Mile High Denver Broncos' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Denver Broncos')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Lumen Field Seattle Seahawks' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Seattle Seahawks')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Mercedes-Benz Superdome New Orleans Saints' AND Team_Lost = 'New Orleans Saints'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New Orleans Saints')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'M&T Bank Stadium Baltimore Ravens' AND Team_Lost = 'Baltimore Ravens'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Baltimore Ravens')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Denver Broncos' AND Stadium = 'MetLife Stadium New York Jets' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Jets')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Carolina Panthers' AND Stadium = 'Bank of America Stadium Carolina Panthers' AND Team_Lost = 'Arizona Cardinals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Carolina Panthers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cincinnati Bengals' AND Stadium = 'Paul Brown Stadium Cincinnati Bengals' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cincinnati Bengals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'AT&T Stadium Dallas Cowboys' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Dallas Cowboys')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Ford Field Detroit Lions' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Detroit Lions')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Minnesota Vikings' AND Stadium = ' NRG Stadium Houston Texans' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Houston Texans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Hard Rock Stadium Miami Dolphins' AND Team_Lost = 'Miami Dolphins'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Miami Dolphins')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Raymond James Stadium Tampa Bay Buccaneers' AND Team_Lost = 'Los Angeles Chargers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tampa Bay Buccaneers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'FedExField Washington Football Team' AND Team_Lost = 'Washington Football Team'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Washington Football Team')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'SoFi Stadium Los Angeles Rams' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Rams')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Soldier Field Chicago Bears' AND Team_Lost = 'Chicago Bears'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Chicago Bears')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Allegiant Stadium Las Vegas Raiders' AND Team_Lost = 'Las Vegas Raiders'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Las Vegas Raiders')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Philadelphia Eagles' AND Stadium = 'Levis Stadium San Francisco 49rs' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'San Francisco 49rs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Arrowhead Stadium Kansas City Chiefs' AND Team_Lost = 'New England Patriots'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Kansas City Chiefs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Lambeau Field Green Bay Packers' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Green Bay Packers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Chicago Bears' AND Stadium = 'Soldier Field Chicago Bears' AND Team_Lost = 'Tampa Bay Buccaneers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Chicago Bears')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Carolina Panthers' AND Stadium = 'Mercedes-Benz Stadium Atlanta Falcons' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Atlanta Falcons')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'M&T Bank Stadium Baltimore Ravens' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Baltimore Ravens')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Houston Texans' AND Stadium = ' NRG Stadium Houston Texans' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Houston Texans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Las Vegas Raiders' AND Stadium = 'Arrowhead Stadium Kansas City Chiefs' AND Team_Lost = 'Kansas City Chiefs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Kansas City Chiefs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Arizona Cardinals' AND Stadium = 'MetLife Stadium New York Jets' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Jets')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'Heinze Field Pittsburgh Steelers' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Pittsburgh Steelers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'FedExField Washington Football Team' AND Team_Lost = 'Washington Football Team'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Washington Football Team')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'Levis Stadium San Francisco 49rs' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'San Francisco 49rs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'FirstEnergy Stadium Cleveland Browns' AND Team_Lost = 'Indianapolis Colts'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cleveland Browns')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Dallas Cowboys' AND Stadium = 'AT&T Stadium Dallas Cowboys' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Dallas Cowboys')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Lumen Field Seattle Seahawks' AND Team_Lost = 'Minnesota Vikings'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Seattle Seahawks')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Mercedes-Benz Superdome New Orleans Saints' AND Team_Lost = 'Los Angeles Chargers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New Orleans Saints')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'Nissan Stadium Nashville Tennessee Titans' AND Team_Lost = 'Buffalo Bills'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tennessee Titans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Denver Broncos' AND Stadium = 'Gillette Stadium New England Patriots' AND Team_Lost = 'New England Patriots'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New England Patriots')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Chicago Bears' AND Stadium = 'Bank of America Stadium Carolina Panthers' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Carolina Panthers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Lucas Oil Stadium Indianapolis Colts' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Indianapolis Colts')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Detroit Lions' AND Stadium = 'TIAA Bank Field Jacksonville Jaguars' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Jacksonville Jaguars')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Atlanta Falcons' AND Stadium = 'U.S. Bank Stadium Minnesota Vikings' AND Team_Lost = 'Minnesota Vikings'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Minnesota Vikings')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New York Giants' AND Stadium = 'MetLife Stadium New York Giants' AND Team_Lost = 'Washington Football Team'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Giants')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'Lincoln Financial Field Philadelphia Eagles' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Philadelphia Eagles')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'Heinze Field Pittsburgh Steelers' AND Team_Lost = 'Cleveland Browns'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Pittsburgh Steelers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'Nissan Stadium Nashville Tennessee Titans' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tennessee Titans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'Hard Rock Stadium Miami Dolphins' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Miami Dolphins')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Raymond James Stadium Tampa Bay Buccaneers' AND Team_Lost = 'Green Bay Packers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tampa Bay Buccaneers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'San Francisco 49rs' AND Stadium = 'Levis Stadium San Francisco 49rs' AND Team_Lost = 'Los Angeles Rams'), (SELECT Team_ID FROM Team WHERE Team_Name = 'San Francisco 49rs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Bills Stadium Buffalo Bills' AND Team_Lost = 'Buffalo Bills'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Buffalo Bills')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Arizona Cardinals' AND Stadium = 'AT&T Stadium Dallas Cowboys' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Dallas Cowboys')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Philadelphia Eagles' AND Stadium = 'Lincoln Financial Field Philadelphia Eagles' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Philadelphia Eagles')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'Nissan Stadium Nashville Tennessee Titans' AND Team_Lost = 'Tennessee Titans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tennessee Titans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Detroit Lions' AND Stadium = 'Mercedes-Benz Stadium Atlanta Falcons' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Atlanta Falcons')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'Paul Brown Stadium Cincinnati Bengals' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cincinnati Bengals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = ' NRG Stadium Houston Texans' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Houston Texans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Mercedes-Benz Superdome New Orleans Saints' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New Orleans Saints')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'MetLife Stadium New York Jets' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Jets')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Washington Football Team' AND Stadium = 'FedExField Washington Football Team' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Washington Football Team')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Allegiant Stadium Las Vegas Raiders' AND Team_Lost = 'Las Vegas Raiders'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Las Vegas Raiders')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Empower Field at Mile High Denver Broncos' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Denver Broncos')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'San Francisco 49rs' AND Stadium = 'Gillette Stadium New England Patriots' AND Team_Lost = 'New England Patriots'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New England Patriots')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Chargers' AND Stadium = 'SoFi Stadium Los Angeles Chargers' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Chargers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Arizona Cardinals' AND Stadium = 'State Farm Stadium Arizona Cardinals' AND Team_Lost = 'Seattle Seahawks'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Arizona Cardinals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'SoFi Stadium Los Angeles Rams' AND Team_Lost = 'Chicago Bears'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Rams')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Atlanta Falcons' AND Stadium = 'Bank of America Stadium Carolina Panthers' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Carolina Panthers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'M&T Bank Stadium Baltimore Ravens' AND Team_Lost = 'Baltimore Ravens'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Baltimore Ravens')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Bills Stadium Buffalo Bills' AND Team_Lost = 'New England Patriots'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Buffalo Bills')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cincinnati Bengals' AND Stadium = 'Paul Brown Stadium Cincinnati Bengals' AND Team_Lost = 'Tennessee Titans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cincinnati Bengals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Las Vegas Raiders' AND Stadium = 'FirstEnergy Stadium Cleveland Browns' AND Team_Lost = 'Cleveland Browns'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cleveland Browns')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Ford Field Detroit Lions' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Detroit Lions')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Minnesota Vikings' AND Stadium = 'Lambeau Field Green Bay Packers' AND Team_Lost = 'Green Bay Packers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Green Bay Packers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Arrowhead Stadium Kansas City Chiefs' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Kansas City Chiefs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'Hard Rock Stadium Miami Dolphins' AND Team_Lost = 'Los Angeles Rams'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Miami Dolphins')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Denver Broncos' AND Stadium = 'Empower Field at Mile High Denver Broncos' AND Team_Lost = 'Los Angeles Chargers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Denver Broncos')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Soldier Field Chicago Bears' AND Team_Lost = 'Chicago Bears'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Chicago Bears')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Lumen Field Seattle Seahawks' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Seattle Seahawks')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Philadelphia Eagles' AND Stadium = 'Lincoln Financial Field Philadelphia Eagles' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Philadelphia Eagles')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'MetLife Stadium New York Giants' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Giants')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Levis Stadium San Francisco 49rs' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'San Francisco 49rs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Atlanta Falcons' AND Stadium = 'Mercedes-Benz Stadium Atlanta Falcons' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Atlanta Falcons')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Bills Stadium Buffalo Bills' AND Team_Lost = 'Seattle Seahawks'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Buffalo Bills')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'Lucas Oil Stadium Indianapolis Colts' AND Team_Lost = 'Indianapolis Colts'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Indianapolis Colts')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Houston Texans' AND Stadium = 'TIAA Bank Field Jacksonville Jaguars' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Jacksonville Jaguars')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Arrowhead Stadium Kansas City Chiefs' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Kansas City Chiefs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Minnesota Vikings' AND Stadium = 'U.S. Bank Stadium Minnesota Vikings' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Minnesota Vikings')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'Nissan Stadium Nashville Tennessee Titans' AND Team_Lost = 'Chicago Bears'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tennessee Titans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New York Giants' AND Stadium = 'FedExField Washington Football Team' AND Team_Lost = 'Washington Football Team'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Washington Football Team')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Las Vegas Raiders' AND Stadium = 'SoFi Stadium Los Angeles Chargers' AND Team_Lost = 'Los Angeles Chargers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Chargers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'State Farm Stadium Arizona Cardinals' AND Team_Lost = 'Arizona Cardinals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Arizona Cardinals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'AT&T Stadium Dallas Cowboys' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Dallas Cowboys')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Raymond James Stadium Tampa Bay Buccaneers' AND Team_Lost = 'Tampa Bay Buccaneers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tampa Bay Buccaneers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New England Patriots' AND Stadium = 'MetLife Stadium New York Jets' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Jets')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Nissan Stadium Nashville Tennessee Titans' AND Team_Lost = 'Tennessee Titans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tennessee Titans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Bank of America Stadium Carolina Panthers' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Carolina Panthers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'FirstEnergy Stadium Cleveland Browns' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cleveland Browns')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Detroit Lions' AND Stadium = 'Ford Field Detroit Lions' AND Team_Lost = 'Washington Football Team'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Detroit Lions')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Lambeau Field Green Bay Packers' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Green Bay Packers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New York Giants' AND Stadium = 'MetLife Stadium New York Giants' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Giants')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'Hard Rock Stadium Miami Dolphins' AND Team_Lost = 'Los Angeles Chargers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Miami Dolphins')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Arizona Cardinals' AND Stadium = 'State Farm Stadium Arizona Cardinals' AND Team_Lost = 'Buffalo Bills'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Arizona Cardinals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Las Vegas Raiders' AND Stadium = 'Allegiant Stadium Las Vegas Raiders' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Las Vegas Raiders')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'Heinze Field Pittsburgh Steelers' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Pittsburgh Steelers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'SoFi Stadium Los Angeles Rams' AND Team_Lost = 'Seattle Seahawks'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Rams')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Mercedes-Benz Superdome New Orleans Saints' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New Orleans Saints')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New England Patriots' AND Stadium = 'Gillette Stadium New England Patriots' AND Team_Lost = 'Baltimore Ravens'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New England Patriots')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Minnesota Vikings' AND Stadium = 'Soldier Field Chicago Bears' AND Team_Lost = 'Chicago Bears'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Chicago Bears')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Lumen Field Seattle Seahawks' AND Team_Lost = 'Arizona Cardinals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Seattle Seahawks')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'M&T Bank Stadium Baltimore Ravens' AND Team_Lost = 'Baltimore Ravens'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Baltimore Ravens')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Carolina Panthers' AND Stadium = 'Bank of America Stadium Carolina Panthers' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Carolina Panthers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'FirstEnergy Stadium Cleveland Browns' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cleveland Browns')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Houston Texans' AND Stadium = ' NRG Stadium Houston Texans' AND Team_Lost = 'New England Patriots'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Houston Texans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'TIAA Bank Field Jacksonville Jaguars' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Jacksonville Jaguars')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Mercedes-Benz Superdome New Orleans Saints' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New Orleans Saints')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Washington Football Team' AND Stadium = 'FedExField Washington Football Team' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Washington Football Team')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Denver Broncos' AND Stadium = 'Empower Field at Mile High Denver Broncos' AND Team_Lost = 'Miami Dolphins'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Denver Broncos')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Chargers' AND Stadium = 'SoFi Stadium Los Angeles Chargers' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Chargers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Lucas Oil Stadium Indianapolis Colts' AND Team_Lost = 'Green Bay Packers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Indianapolis Colts')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Dallas Cowboys' AND Stadium = 'U.S. Bank Stadium Minnesota Vikings' AND Team_Lost = 'Minnesota Vikings'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Minnesota Vikings')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Allegiant Stadium Las Vegas Raiders' AND Team_Lost = 'Las Vegas Raiders'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Las Vegas Raiders')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'Raymond James Stadium Tampa Bay Buccaneers' AND Team_Lost = 'Tampa Bay Buccaneers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tampa Bay Buccaneers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Houston Texans' AND Stadium = 'Ford Field Detroit Lions' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Detroit Lions')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Washington Football Team' AND Stadium = 'AT&T Stadium Dallas Cowboys' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Dallas Cowboys')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Atlanta Falcons' AND Stadium = 'Mercedes-Benz Stadium Atlanta Falcons' AND Team_Lost = 'Las Vegas Raiders'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Atlanta Falcons')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Bills Stadium Buffalo Bills' AND Team_Lost = 'Los Angeles Chargers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Buffalo Bills')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New York Giants' AND Stadium = 'Paul Brown Stadium Cincinnati Bengals' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cincinnati Bengals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'Lucas Oil Stadium Indianapolis Colts' AND Team_Lost = 'Indianapolis Colts'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Indianapolis Colts')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'TIAA Bank Field Jacksonville Jaguars' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Jacksonville Jaguars')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Minnesota Vikings' AND Stadium = 'U.S. Bank Stadium Minnesota Vikings' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Minnesota Vikings')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New England Patriots' AND Stadium = 'Gillette Stadium New England Patriots' AND Team_Lost = 'Arizona Cardinals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New England Patriots')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'MetLife Stadium New York Jets' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Jets')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Empower Field at Mile High Denver Broncos' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Denver Broncos')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'San Francisco 49rs' AND Stadium = 'SoFi Stadium Los Angeles Rams' AND Team_Lost = 'Los Angeles Rams'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Rams')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Raymond James Stadium Tampa Bay Buccaneers' AND Team_Lost = 'Tampa Bay Buccaneers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tampa Bay Buccaneers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Lambeau Field Green Bay Packers' AND Team_Lost = 'Chicago Bears'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Green Bay Packers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Lincoln Financial Field Philadelphia Eagles' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Philadelphia Eagles')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'Heinze Field Pittsburgh Steelers' AND Team_Lost = 'Baltimore Ravens'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Pittsburgh Steelers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Mercedes-Benz Stadium Atlanta Falcons' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Atlanta Falcons')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Detroit Lions' AND Stadium = 'Soldier Field Chicago Bears' AND Team_Lost = 'Chicago Bears'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Chicago Bears')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = ' NRG Stadium Houston Texans' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Houston Texans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'Hard Rock Stadium Miami Dolphins' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Miami Dolphins')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Minnesota Vikings' AND Stadium = 'U.S. Bank Stadium Minnesota Vikings' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Minnesota Vikings')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Las Vegas Raiders' AND Stadium = 'MetLife Stadium New York Jets' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Jets')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'Nissan Stadium Nashville Tennessee Titans' AND Team_Lost = 'Tennessee Titans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tennessee Titans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'State Farm Stadium Arizona Cardinals' AND Team_Lost = 'Arizona Cardinals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Arizona Cardinals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New York Giants' AND Stadium = 'Lumen Field Seattle Seahawks' AND Team_Lost = 'Seattle Seahawks'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Seattle Seahawks')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Lambeau Field Green Bay Packers' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Green Bay Packers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New England Patriots' AND Stadium = 'SoFi Stadium Los Angeles Chargers' AND Team_Lost = 'Los Angeles Chargers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Chargers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Arrowhead Stadium Kansas City Chiefs' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Kansas City Chiefs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Washington Football Team' AND Stadium = 'Heinze Field Pittsburgh Steelers' AND Team_Lost = 'Pittsburgh Steelers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Pittsburgh Steelers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Levis Stadium San Francisco 49rs' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'San Francisco 49rs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'M&T Bank Stadium Baltimore Ravens' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Baltimore Ravens')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'SoFi Stadium Los Angeles Rams' AND Team_Lost = 'New England Patriots'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Rams')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Denver Broncos' AND Stadium = 'Bank of America Stadium Carolina Panthers' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Carolina Panthers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Chicago Bears' AND Stadium = 'Soldier Field Chicago Bears' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Chicago Bears')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Dallas Cowboys' AND Stadium = 'Paul Brown Stadium Cincinnati Bengals' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cincinnati Bengals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'TIAA Bank Field Jacksonville Jaguars' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Jacksonville Jaguars')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Hard Rock Stadium Miami Dolphins' AND Team_Lost = 'Miami Dolphins'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Miami Dolphins')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Arizona Cardinals' AND Stadium = 'MetLife Stadium New York Giants' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Giants')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Raymond James Stadium Tampa Bay Buccaneers' AND Team_Lost = 'Minnesota Vikings'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tampa Bay Buccaneers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Allegiant Stadium Las Vegas Raiders' AND Team_Lost = 'Las Vegas Raiders'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Las Vegas Raiders')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Lumen Field Seattle Seahawks' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Seattle Seahawks')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Ford Field Detroit Lions' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Detroit Lions')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Chargers' AND Stadium = 'SoFi Stadium Los Angeles Chargers' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Chargers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Philadelphia Eagles' AND Stadium = 'Lincoln Financial Field Philadelphia Eagles' AND Team_Lost = 'New Orleans Saints'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Philadelphia Eagles')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Washington Football Team' AND Stadium = 'Levis Stadium San Francisco 49rs' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'San Francisco 49rs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Bills Stadium Buffalo Bills' AND Team_Lost = 'Pittsburgh Steelers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Buffalo Bills')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'FirstEnergy Stadium Cleveland Browns' AND Team_Lost = 'Cleveland Browns'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cleveland Browns')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Chargers' AND Stadium = 'Allegiant Stadium Las Vegas Raiders' AND Team_Lost = 'Las Vegas Raiders'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Las Vegas Raiders')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Empower Field at Mile High Denver Broncos' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Denver Broncos')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Lambeau Field Green Bay Packers' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Green Bay Packers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Mercedes-Benz Stadium Atlanta Falcons' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Atlanta Falcons')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'M&T Bank Stadium Baltimore Ravens' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Baltimore Ravens')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Lucas Oil Stadium Indianapolis Colts' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Indianapolis Colts')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'Hard Rock Stadium Miami Dolphins' AND Team_Lost = 'New England Patriots'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Miami Dolphins')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Chicago Bears' AND Stadium = 'U.S. Bank Stadium Minnesota Vikings' AND Team_Lost = 'Minnesota Vikings'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Minnesota Vikings')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = 'Nissan Stadium Nashville Tennessee Titans' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tennessee Titans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'FedExField Washington Football Team' AND Team_Lost = 'Washington Football Team'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Washington Football Team')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Dallas Cowboys' AND Stadium = 'AT&T Stadium Dallas Cowboys' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Dallas Cowboys')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Arizona Cardinals' AND Stadium = 'State Farm Stadium Arizona Cardinals' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Arizona Cardinals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New York Jets' AND Stadium = 'SoFi Stadium Los Angeles Rams' AND Team_Lost = 'Los Angeles Rams'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Rams')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Mercedes-Benz Superdome New Orleans Saints' AND Team_Lost = 'New Orleans Saints'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New Orleans Saints')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'MetLife Stadium New York Giants' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Giants')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cincinnati Bengals' AND Stadium = 'Paul Brown Stadium Cincinnati Bengals' AND Team_Lost = 'Pittsburgh Steelers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cincinnati Bengals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Mercedes-Benz Superdome New Orleans Saints' AND Team_Lost = 'Minnesota Vikings'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New Orleans Saints')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Ford Field Detroit Lions' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Detroit Lions')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'San Francisco 49rs' AND Stadium = 'State Farm Stadium Arizona Cardinals' AND Team_Lost = 'Arizona Cardinals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Arizona Cardinals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Miami Dolphins' AND Stadium = 'Allegiant Stadium Las Vegas Raiders' AND Team_Lost = 'Las Vegas Raiders'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Las Vegas Raiders')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'M&T Bank Stadium Baltimore Ravens' AND Team_Lost = 'New York Giants'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Baltimore Ravens')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cincinnati Bengals' AND Stadium = ' NRG Stadium Houston Texans' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Houston Texans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Chicago Bears' AND Stadium = 'TIAA Bank Field Jacksonville Jaguars' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Jacksonville Jaguars')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Kansas City Chiefs' AND Stadium = 'Arrowhead Stadium Kansas City Chiefs' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Kansas City Chiefs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New York Jets' AND Stadium = 'MetLife Stadium New York Jets' AND Team_Lost = 'Cleveland Browns'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Jets')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Pittsburgh Steelers' AND Stadium = 'Heinze Field Pittsburgh Steelers' AND Team_Lost = 'Indianapolis Colts'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Pittsburgh Steelers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Carolina Panthers' AND Stadium = 'FedExField Washington Football Team' AND Team_Lost = 'Washington Football Team'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Washington Football Team')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Chargers' AND Stadium = 'SoFi Stadium Los Angeles Chargers' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Chargers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Lumen Field Seattle Seahawks' AND Team_Lost = 'Los Angeles Rams'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Seattle Seahawks')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Dallas Cowboys' AND Stadium = 'AT&T Stadium Dallas Cowboys' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Dallas Cowboys')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Lambeau Field Green Bay Packers' AND Team_Lost = 'Tennessee Titans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Green Bay Packers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Gillette Stadium New England Patriots' AND Team_Lost = 'New England Patriots'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New England Patriots')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Buffalo Bills' AND Stadium = 'Bills Stadium Buffalo Bills' AND Team_Lost = 'Miami Dolphins'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Buffalo Bills')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Baltimore Ravens' AND Stadium = 'Paul Brown Stadium Cincinnati Bengals' AND Team_Lost = 'Cincinnati Bengals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cincinnati Bengals')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Cleveland Browns' AND Stadium = 'FirstEnergy Stadium Cleveland Browns' AND Team_Lost = 'Pittsburgh Steelers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Cleveland Browns')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Minnesota Vikings' AND Stadium = 'Ford Field Detroit Lions' AND Team_Lost = 'Detroit Lions'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Detroit Lions')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New England Patriots' AND Stadium = 'Gillette Stadium New England Patriots' AND Team_Lost = 'New York Jets'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New England Patriots')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New York Giants' AND Stadium = 'MetLife Stadium New York Giants' AND Team_Lost = 'Dallas Cowboys'), (SELECT Team_ID FROM Team WHERE Team_Name = 'New York Giants')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tampa Bay Buccaneers' AND Stadium = 'Raymond James Stadium Tampa Bay Buccaneers' AND Team_Lost = 'Atlanta Falcons'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Tampa Bay Buccaneers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'New Orleans Saints' AND Stadium = 'Bank of America Stadium Carolina Panthers' AND Team_Lost = 'Carolina Panthers'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Carolina Panthers')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Green Bay Packers' AND Stadium = 'Soldier Field Chicago Bears' AND Team_Lost = 'Chicago Bears'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Chicago Bears')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Tennessee Titans' AND Stadium = ' NRG Stadium Houston Texans' AND Team_Lost = 'Houston Texans'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Houston Texans')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Indianapolis Colts' AND Stadium = 'Lucas Oil Stadium Indianapolis Colts' AND Team_Lost = 'Jacksonville Jaguars'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Indianapolis Colts')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Chargers' AND Stadium = 'Arrowhead Stadium Kansas City Chiefs' AND Team_Lost = 'Kansas City Chiefs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Kansas City Chiefs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Las Vegas Raiders' AND Stadium = 'Empower Field at Mile High Denver Broncos' AND Team_Lost = 'Denver Broncos'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Denver Broncos')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Los Angeles Rams' AND Stadium = 'SoFi Stadium Los Angeles Rams' AND Team_Lost = 'Arizona Cardinals'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Los Angeles Rams')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Seattle Seahawks' AND Stadium = 'Levis Stadium San Francisco 49rs' AND Team_Lost = 'San Francisco 49rs'), (SELECT Team_ID FROM Team WHERE Team_Name = 'San Francisco 49rs')),
((SELECT Game_ID FROM Game WHERE Team_Won = 'Washington Football Team' AND Stadium = 'Lincoln Financial Field Philadelphia Eagles' AND Team_Lost = 'Philadelphia Eagles'), (SELECT Team_ID FROM Team WHERE Team_Name = 'Philadelphia Eagles'))

SELECT * FROM Team_Game_List

--Insert into Player_Stat_list table--

--declare counters to be incremented
DECLARE @counterplayer AS int
DECLARE @counterstat AS int

--set counters equal to 1
SET @counterplayer = 1
SET @counterstat = 1

--while loop to insert Player_ID and Stat_ID into PLayer Stat list table (49 values)
WHILE (@counterplayer <= 49)
BEGIN

	--Insert Player_ID and Stat_ID data into Player_Stat_List table
	INSERT INTO Player_Stat_List (Player_ID, Stat_ID)
	VALUES ((SELECT Player_ID FROM Player WHERE Player_ID = @counterplayer), (SELECT Stat_ID FROM Stat WHERE Stat_ID = @counterstat))
	SET @counterplayer = @counterplayer + 1 --increment player counter
	SET @counterstat = @counterstat + 1  --increment stat counter
END

SELECT * FROM Player_Stat_List

-----------UPDATE Statement--------------------------------------------------------------------------------------------------------
--Looks like one of the players names was misspelled. need to update it
-- Younghoe Zoo needs to be changed to Younghoe Koo

--Before
SELECT * FROM Player WHERE Player_First_Name = 'Younghoe'

UPDATE Player
SET Player_Last_Name = 'Koo'
WHERE Player_First_Name = 'Younghoe'

--After
SELECT * FROM Player WHERE Player_First_Name = 'Younghoe'

-----------------------------------CREATE STORED PROCEDURES-------------------------------------------------------------------------
          /**Now we want to create some stored prodecures to add players to our database**/

GO
--Create a Stored Procedure to add a player to the Player table
CREATE PROCEDURE AddPlayer (@playerFirstName varchar(50), @playerLastName varchar(50), @NewAge int, @PlayerPosition char(5), @TeamID int, @GameID int)
AS
BEGIN
	--Insert command to add values inputted to Player table
	INSERT INTO Player (Player_First_Name, Player_Last_Name, Age, Player_Position, Team_ID, Game_ID)
	VALUES (@playerFirstName, @playerLastName, @NewAge, @PlayerPosition, @TeamID, @GameID)
END
GO

--Create a Stored Procedure to add a stat to the Stat table
CREATE PROCEDURE AddStat (@StatPosition char(2), @NumberofYards int, @Touchdowns int, @TotalFieldGoalPoints int)
AS
BEGIN
	--Insert command to add values inputted to Stat table
	INSERT INTO Stat (Stat_Position, Number_of_Yards, Touchdowns, Total_Field_Goal_Points)
	VALUES (@StatPosition, @NumberofYards, @Touchdowns, @TotalFieldGoalPoints)
END
GO

--Execute the AddPlayer stored proc with values
EXEC AddPlayer 'Chris', 'Godwin', 24, 'WR', 30, 12

--Check last Player_ID created for Player_Stat_List table later
SELECT Distinct @@IDENTITY FROM Player

--Test to see if player was added to bottom
SELECT * FROM Player

--Execute the AddStat stored proc with values
EXEC AddStat 'WR', 840, 7, 0

--Check last Stat_ID created for Player_Stat_List table later
SELECT Distinct @@IDENTITY FROM Stat

--Test to see if Stat was added to bottom
Select * FROM Stat

--write an insert statement to add the Player_ID and Stat_ID to the Player_Stat_List 
INSERT INTO Player_Stat_List (Player_ID, Stat_ID)
VALUES ((SELECT DIstinct @@IDENTITY FROM Player), (SELECT DIstinct @@IDENTITY FROM Stat))

--Test to see if the new ID was added to bottom
SELECT * FROM Player_Stat_List


/**Lets now Delete our new Players data and Stats**/-----------------------------------------------------------

GO
--Create a Stored Procedure to delete a player from the Player table
CREATE PROCEDURE DeletePlayer (@playerFirstName varchar(50), @playerLastName varchar(50))
AS
BEGIN

	--Delete player from player table with parameters in where condition
	DELETE FROM Player
	WHERE Player_First_Name = @playerFirstName and Player_Last_Name = @playerLastName 

END
GO

--Since we are deleting the player and stat, we need to delete it from the Player_Stat_List FIRST
DELETE FROM Player_Stat_List WHERE Player_Stat_List_ID = 50

--Test to see if Player_Stat_List ID was deleted
SELECT * FROM Player_Stat_List

--Execute the DeletePlayer stored proc with values to delete player
EXEC DeletePlayer 'Chris', 'Godwin'

--Test to see if player was deleted
SELECT * FROM Player

--Since we are deleting the player, we need to delete the stat as well
DELETE FROM Stat
WHERE Stat_Position = 'WR' AND Number_of_Yards = 840 AND Touchdowns = 7

--Test to see if stat was deleted
SELECT * FROM Stat

-------------------------------------CREATE FUNCTION-------------------------
GO
--Create function to look up the Player_ID of a player
CREATE FUNCTION PlayerLookup (@PlayerFirstName varchar(50), @PlayerLastName varchar(50))
RETURNS int AS --Player_ID is an int, so we'll match that
BEGIN
	DECLARE @returnValue int

	/*
		Get the Player_ID of the Player record whose Player_First_Name and Player_Last_Name
		matches the parameters and assign that value to returnValue
	*/
	SELECT @returnValue = Player_ID FROM Player
	WHERE Player_First_Name = @PlayerFirstName AND Player_Last_Name = @PlayerLastName

	RETURN @returnValue
END
GO

--Find Player ID of Tom Brady
SELECT dbo.PlayerLookup('Tom', 'Brady')

--Check to see if it was correct
SELECT * FROM Player WHERE Player_First_Name = 'Tom' AND Player_Last_Name = 'Brady'


/**ANSWER TO DATA QUESTIONS**/--------------------------------------------------------------------------------------------------

--------------QUESTION 1-------------------------------------------------
GO
--Create view of top 5 players by player type for this season - Helps Question 1
CREATE VIEW topPlayers
AS
	--Select top 5 quarterbacks
	SELECT TOP 5 a.*, c.*
	FROM Stat a
	JOIN Player_Stat_List b
	ON a.Stat_ID = b.Stat_ID
	JOIN Player c
	ON b.Player_ID = c.Player_ID
	WHERE c.Player_Position = 'QB' AND a.Stat_Position = 'QB'
	ORDER BY a.Touchdowns DESC, Number_of_Yards DESC
	
	UNION

	--Select top 5 wide recievers
	SELECT TOP 5 a.*, c.*
	FROM Stat a
	JOIN Player_Stat_List b
	ON a.Stat_ID = b.Stat_ID
	JOIN Player c
	ON b.Player_ID = c.Player_ID
	WHERE c.Player_Position = 'WR' AND a.Stat_Position = 'WR'
	ORDER BY a.Touchdowns DESC, Number_of_Yards DESC

	UNION

	--Select top 5 Tight Ends
	SELECT TOP 5 a.*, c.*
	FROM Stat a
	JOIN Player_Stat_List b
	ON a.Stat_ID = b.Stat_ID
	JOIN Player c
	ON b.Player_ID = c.Player_ID
	WHERE c.Player_Position = 'TE'
	ORDER BY a.Touchdowns DESC, Number_of_Yards DESC

	UNION

	--Select top 5 running backs
	SELECT TOP 5 a.*, c.*
	FROM Stat a
	JOIN Player_Stat_List b
	ON a.Stat_ID = b.Stat_ID
	JOIN Player c
	ON b.Player_ID = c.Player_ID
	WHERE c.Player_Position = 'RB' AND a.Stat_Position = 'RB'
	ORDER BY a.Touchdowns DESC, Number_of_Yards DESC

		UNION

	--Select top 5 kickers
	SELECT TOP 5 a.*, c.*
	FROM Stat a
	JOIN Player_Stat_List b
	ON a.Stat_ID = b.Stat_ID
	JOIN Player c
	ON b.Player_ID = c.Player_ID
	WHERE c.Player_Position = 'K' AND a.Stat_Position = 'K'
	ORDER BY a.Touchdowns DESC, Total_Field_Goal_Points DESC

GO

--We can now view all top 5 players by position 
SELECT * FROM topPlayers

--DATA QUESTION 1 ANSWER: Who are the top 5 WR/RB/QB/TE/K's this season?
SELECT  a.Stat_ID, c.Player_First_Name, c.Player_Last_Name, c.Player_Position, d.Team_Name, a.Number_of_Yards, a.Touchdowns, a.Total_Field_Goal_Points
FROM topPlayers a
JOIN Player_Stat_List b
ON a.Stat_ID = b.Stat_ID
JOIN Player c
ON b.Player_ID = c.Player_ID
JOIN Team d
ON c.Team_ID = d.Team_ID
ORDER BY Player_Position ASC, Touchdowns DESC, Number_of_Yards DESC, Total_Field_Goal_Points DESC

--------------QUESTION 2-------------------------------------------------
--DATA QUESTION 2 ANSWER: Which team is likely to have the most wins next season?
SELECT TOP 1 Team_ID, Team_Name, City, State, Number_of_Wins
FROM Team
ORDER BY Number_of_Wins DESC

--------------QUESTION 3-------------------------------------------------
GO
--Create a view of number of Home games won by team - Helps Question 3
CREATE VIEW HomeStadiumTeam
AS 
	--COUNT number of wins where stadium was from the team won
	SELECT COUNT(*) AS Num_Home_Games_Won, Team_Won 
	FROM Game
	WHERE Stadium LIKE '%' + Team_Won
	GROUP BY Team_Won

GO

--We now have a view with the number of home games won per team
SELECT * FROM HomeStadiumTeam

--DATA QUESTION 3 ANSWER: Which NFL team won the most games at home? (If tie, who had the better season record?)
SELECT a.Team_Won, a.Num_Home_Games_Won, d.Number_of_Wins 
FROM HomeStadiumTeam a
JOIN Game b
ON a.Team_Won = b.Team_Won
JOIN Team_Game_List c
ON b.Game_ID = c.Game_ID
JOIN Team d
ON c.Team_ID = d.Team_ID
WHERE b.Stadium LIKE '%' + a.Team_Won
GROUP BY a.Team_Won, d.Number_of_Wins, a.Num_Home_Games_Won
ORDER BY Num_Home_Games_Won DESC, d.Number_of_Wins DESC

--------------QUESTION 4-------------------------------------------------
--Created a view that combines Team, Player, and Stat data into one SELECT for analysis - Helps Question 4
Go
CREATE VIEW FullPlayerInfo
AS

SELECT a.Player_First_Name, a.Player_Last_Name, b.Team_Name, d.Touchdowns
FROM Player a
JOIN Team b
ON a.Team_ID = b.Team_ID
JOIN Player_Stat_List c
ON a.Player_ID = c.Player_ID
JOIN Stat d
ON c.Stat_ID = d.Stat_ID
GROUP BY Touchdowns, Team_Name, Player_First_Name, Player_Last_Name

GO

--We now have a view of all players with their team name and number of touchdowns scored
SELECT * FROM FullPlayerInfo

--DATA QUESTION 4 ANSWER: Which NFL team had the most touchdowns this season?
SELECT Team_Name, SUM(Touchdowns) AS SumofTouchdowns
	FROM FullPlayerInfo
	GROUP BY Team_Name
	ORDER BY SumofTouchdowns DESC

--------------QUESTION 5-------------------------------------------------
--DATA QUESTION 5 ANSWER: What NFL teams will most likely have 12 or more wins next season?
SELECT Team_Name, Number_of_Wins FROM Team
WHERE Number_of_Wins >= 12
ORDER BY Number_of_Wins DESC

--------------QUESTION 6-------------------------------------------------
--DATA QUESTION 6 ANSWER: Which Quarterback threw the most yards this season?
SELECT TOP 1 c.Player_First_Name, c.Player_Last_Name, a.Stat_Position, d.Team_Name, MAX(Number_of_Yards) AS Number_of_Yards
FROM Stat a
JOIN Player_Stat_List b
ON a.Stat_ID = b.Stat_ID
JOIN Player c
ON b.Player_ID = c.Player_ID
JOIN Team d
ON c.Team_ID = d.Team_ID
WHERE Stat_Position = 'QB'
GROUP BY Stat_Position, Number_of_Yards, Player_First_Name, Player_Last_Name, Team_Name
ORDER BY Number_of_Yards DESC