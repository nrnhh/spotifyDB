

USE Proj_A10
GO
-- Create Tables / Populating Tables
CREATE TABLE tblUser (
	UserID int IDENTITY(1,1) primary key,
	-- foreign key countryid
	Username varchar(255) NOT NULL,
	UserFname varchar(255) NOT NULL,
	UserLname varchar(255) NOT NULL,
	Birthdate Date NOT NULL,
	[Address] varchar(255) NOT NULL,
	City varchar(255) NOT NULL,
	[State] varchar(255) NOT NULL,
	ZipCode int NOT NULL
)
GO
 
CREATE TABLE tblCountry (
	CountryID int IDENTITY(1,1) primary key,
	CountryName varchar(255) NOT NULL
)
GO
 
CREATE TABLE tblUserType (
	UserTypeID int IDENTITY(1,1) primary key,
	-- foreign key UserID
	-- foreign key SubscriptionTypeID
	StartDate Date DEFAULT GetDate() NOT NULL,
	EndDate Date DEFAULT NULL
)
GO
 
CREATE TABLE tblSubscriptionType (
	SubscriptionTypeID int IDENTITY(1,1) primary key,
	SubscriptionTypeName varchar(255) NOT NULL,
	SubscriptionTypeDescr varchar(255) NULL
)
GO
 
CREATE TABLE tblFollower (
	FollowerID int IDENTITY(1,1) primary key,
	--fk UserTypeID_A
	--fk UserTypeID_B
	BeginDate Date DEFAULT GetDate() NOT NULL
)
GO
 
CREATE TABLE tblCollaborator (
	CollaboratorID int IDENTITY(1,1) primary key,
	-- fk CollaboratorTypeID
	-- fk UserTypeID
	-- fk playlistid 
)
GO
 
CREATE TABLE tblCollaboratorType (
	CollaboratorTypeID int IDENTITY(1,1) primary key,
	CollaboratorTypeName varchar(255) NOT NULL,
	DateAdded Date DEFAULT GetDate() NOT NULL
)
GO
 
CREATE TABLE tblPlaylist (
	PlaylistID int IDENTITY(1,1) primary key,
	-- fk playlisttypeid
	PlaylistName varchar(255) DEFAULT 'untitled' NOT NULL,
	PlaylistDescr varchar(255) NULL,
	PlaylistPicture varbinary(max) NULL,
 	CreationDate Date DEFAULT GetDate() NOT NULL
)
GO
 
CREATE TABLE tblPlaylistType (
	PlaylistTypeID int IDENTITY(1, 1) primary key,
	PlaylistTypeName varchar(255) NOT NULL,
)
GO
 
CREATE TABLE tblAccess (
	AccessID int IDENTITY(1, 1) primary key,
	-- fk usertypeid 
	-- fk playrecordingid
	AccessDate Date DEFAULT GetDate() NOT NULL
)
GO
 
CREATE TABLE tblPlaylistRecording (
	PlaylistRecordingID int IDENTITY(1, 1) primary key,
	-- fk PlaylistID
	-- fk RecordingID
)
GO
 
CREATE TABLE tblGenre (
	GenreID int IDENTITY(1, 1) primary key,
	GenreName varchar(255) NOT NULL,
	GenreDescr varchar(255) NULL
)
GO
 
CREATE TABLE tblRecording (
	RecordingID  int IDENTITY(1, 1) primary key,
	RecordingName varchar(255) NOT NULL,
	Duration INTEGER NOT NULL,
	--fk GenreID
	--fk SongID
)
GO
 
CREATE TABLE tblAlbumRecording (
	AlbumRecordingID int IDENTITY(1, 1) primary key,
	--fk AlbumId
	-- fk RecordingId
	TrackNumber int NOT NULL
)
GO
 
CREATE TABLE tblAlbum (
	AlbumID int IDENTITY(1, 1) primary key,
	AlbumName varchar(255) NOT NULL,
	ReleaseDate Date DEFAULT GetDate() NOT NULL,
	-- fk LabelID
)
GO
 
CREATE TABLE tblLabel (
	LabelID int IDENTITY(1, 1) primary key,
	LabelName varchar(255) NOT NULL
)
GO
 
CREATE TABLE tblActAlbum (
	ActAlbumID int IDENTITY(1, 1) primary key,
	-- fk actid
	-- fk albumid
)
GO
 
CREATE TABLE tblSong (
	SongID int IDENTITY(1, 1) primary key,
	SongName varchar(255) NOT NULL,
	SongDate Date DEFAULT GetDate() NOT NULL
)
GO
 
CREATE TABLE tblWriter (
	WriterID int IDENTITY(1, 1) primary key,
	-- fk artistid
	-- fk songid
)
GO
 
CREATE TABLE tblArtist (
	ArtistID int IDENTITY(1, 1) primary key,
	ArtistFname varchar(255) NOT NULL,
	ArtistLname varchar(255) NOT NULL,
	ArtistDescr varchar(255) NULL,
	ArtistBirthDate Date NOT NULL
)
GO
 
CREATE TABLE tblArtistAct (
	ArtistActID int IDENTITY(1, 1) primary key,
	-- fk artistid
	-- fk actid
	BeginDate Date DEFAULT GetDate() NOT NULL,
	EndDate Date DEFAULT NULL
)
GO
 
CREATE TABLE tblAct (
	ActID int IDENTITY(1, 1) primary key,
	ActName varchar(255) NOT NULL,
	ActDescr varchar(255) NULL,
	ActImage varbinary(max) NULL
)
GO
 
CREATE TABLE  tblActRecording (
	ActRecordingID int IDENTITY(1, 1) primary key,
	-- fk RecordingID
	-- fk actID
)
GO

-- Add Check Foreign Keys after the fact
ALTER TABLE tblUser
ADD CountryID int,
CONSTRAINT FK_tblUser_CountryID
		FOREIGN KEY (CountryID) REFERENCES tblCountry(CountryID)
GO
 
ALTER TABLE tblUserType
ADD UserID int, SubscriptionTypeID int,
CONSTRAINT FK_tblUserType_UserID 
		FOREIGN KEY (UserID) REFERENCES tblUser(UserID),
	CONSTRAINT FK_tblUserType_SubscriptionTypeID
		FOREIGN KEY(SubscriptionTypeID) REFERENCES tblSubscriptionType(SubscriptionTypeID)
GO
 
ALTER TABLE tblFollower
ADD UserTypeID_A int, UserTypeID_B int,
	CONSTRAINT FK_tblFollower_UserTypeID_A
		FOREIGN KEY (UserTypeID_A) REFERENCES tblUserType(UserTypeID),
	CONSTRAINT FK_tblFollower_UserTypeID_B
		FOREIGN KEY (UserTypeID_B) REFERENCES tblUserType(UserTypeID)
 
GO
 
ALTER TABLE tblCollaborator
ADD CollaboratorTypeID int, UserTypeID int, PlaylistID int,
	CONSTRAINT FK_tblCollaborator_CollaboratorTypeID
		FOREIGN KEY (CollaboratorTypeID) REFERENCES tblCollaboratorType(CollaboratorTypeID),
	CONSTRAINT FK_tblCollaborator_UserTypeID
		FOREIGN KEY (UserTypeID) REFERENCES tblUserType(UserTypeID),
	CONSTRAINT FK_tblCollaborator_PlaylistID
		FOREIGN KEY (PlaylistID) REFERENCES tblPlaylist(PlaylistID)
GO
 
ALTER TABLE tblPlaylist
ADD PlaylistTypeID int,
	CONSTRAINT FK_tblPlaylist_PlaylistTypeID
		FOREIGN KEY (PlaylistTypeID) REFERENCES tblPlaylistType(PlaylistTypeID)
GO
 
ALTER TABLE tblAccess
ADD UserTypeID int, PlaylistRecordingID int,
	CONSTRAINT FK_tblAccess_UserTypeID
		FOREIGN KEY (UserTypeID) REFERENCES tblUserType(UserTypeID),
	CONSTRAINT FK_tblAccess_PlaylistRecordingID
		FOREIGN KEY (PlaylistRecordingID) REFERENCES tblPlaylistRecording(PlaylistRecordingID)
GO
 
ALTER TABLE tblPlaylistRecording
ADD PlaylistID int, RecordingID int,
CONSTRAINT FK_tblPlaylistRecording_PlaylistID
		FOREIGN KEY (PlaylistID) REFERENCES tblPlaylist(PlaylistID),
	CONSTRAINT FK_tblPlaylistRecording_RecordingID
		FOREIGN KEY (RecordingID) REFERENCES tblRecording(RecordingID)
GO
 
ALTER TABLE tblRecording
ADD GenreID int, SongID int,
CONSTRAINT FK_tblRecording_GenreID
		FOREIGN KEY (GenreID) REFERENCES tblGenre(GenreID),
	CONSTRAINT FK_tblRecording_SongID
		FOREIGN KEY (SongID) REFERENCES tblSong(SongID)
GO
 
ALTER TABLE tblAlbumRecording
ADD AlbumID int, RecordingID int,
CONSTRAINT FK_tblAlbumRecording_AlbumID
		FOREIGN KEY (AlbumID) REFERENCES tblAlbum(AlbumID),
	CONSTRAINT FK_tblAlbumRecording_RecordingID
		FOREIGN KEY (RecordingID) REFERENCES tblRecording(RecordingID)
GO
 
ALTER TABLE tblAlbum
ADD LabelID int,
CONSTRAINT FK_tblAlbum_LabelID
		FOREIGN KEY (LabelID) REFERENCES tblLabel(LabelID)
GO
 
ALTER TABLE tblActAlbum
ADD ActID int, AlbumID int,
CONSTRAINT FK_tblActAlbum_ActID
		FOREIGN KEY (ActID) REFERENCES tblAct(ActID),
	CONSTRAINT FK_tblActAlbum_AlbumID
		FOREIGN KEY (AlbumID) REFERENCES tblAlbum(AlbumID)
GO
 
ALTER TABLE tblWriter
ADD ArtistID int, SongID int,
	CONSTRAINT FK_tblWriter_ArtistID
		FOREIGN KEY (ArtistID) REFERENCES tblArtist(ArtistID),
	CONSTRAINT FK_tblWriter_SongID
		FOREIGN KEY (SongID) REFERENCES tblSong(SongID)
GO
 
ALTER TABLE tblArtistAct
ADD ArtistID int, ActID int,
CONSTRAINT FK_tblArtistAct_ArtistID
		FOREIGN KEY (ArtistID) REFERENCES tblArtist(ArtistID),
	CONSTRAINT FK_tblArtistAct_ActID
		FOREIGN KEY (ActID) REFERENCES tblAct(ActID)
GO
 
ALTER TABLE tblActRecording
ADD ActID int, RecordingID int, 
CONSTRAINT FK_tblActRecording_ActID
		FOREIGN KEY (ActID) REFERENCES tblAct(ActID),
	CONSTRAINT FK_tblActRecording_RecordingID
		FOREIGN KEY (RecordingID) REFERENCES tblRecording(RecordingID)
GO

-- Insert Statements for basic look up tables
INSERT INTO tblGenre (GenreName)
VALUES
    ('Rock'),
    ('Pop'),
    ('Hip Hop'),
    ('Country'),
    ('Jazz')
INSERT INTO tblSubscriptionType(SubscriptionTypeName, SubscriptionTypeDescr)
VALUES ('Guest', 'No login information, free plan'),
        ('Free', 'Login information, free plan'),
        ('Premium Trial', 'Login information, limited premium plan'),
        ('Premium', 'Login information, premium plan'),
        ('Premium Student', 'Login information, premium plan')
 
INSERT INTO tblCountry (CountryName)
VALUES
    ('United States'),
    ('Canada'),
    ('Mexico'),
    ('Untied Kingdom'),
    ('Korea'),
   ('Germany'),
   ('China'),
   ('France'),
   ('Italy'),
   ('Slovakia')
 
INSERT INTO tblLabel (LabelName)
VALUES
('Sony Music Entertainment'),
('Universal Music Publishing Group'),
('Warner Music Group'),
('Island Records'),
('XL Recordings Ltd.'),
('4AD Ltd.'),
('Virgin Records'),
('Red Hill Records'),
('Apple Corps Ltd.'),
('Sub Pop Records')


-- Stored Procedures
-- Stored Procedure #1 | New Insert Into tblRECORDING
CREATE PROCEDURE NewInsert_tblRecording
@RecordingName VARCHAR(50),
@SongName VARCHAR(50),
@GenreName VARCHAR(50),
@Duration INT
AS
DECLARE @S_ID INT, @G_ID INT

SET @S_ID = (SELECT SongID FROM tblSONG WHERE SongName = @SongName)
IF @S_ID IS NULL
	BEGIN
	PRINT 'Eror present in @S_ID';
	THROW 51007, '@U_ID cannot be NULL, process is terminating', 1;
	END

SET @G_ID = (SELECT GenreID FROM tblGenre WHERE GenreName = @GenreName)
IF @G_ID IS NULL
	BEGIN
	PRINT 'Eror present in @G_ID';
	THROW 51007, '@U_ID cannot be NULL, process is terminating', 1;
	END

BEGIN TRAN G1
INSERT INTO tblRecording (RecordingName, Duration, SongID, GenreID)
VALUES (@RecordingName, @Duration, @S_ID, @G_ID)
IF @@ERROR <> 0
	BEGIN
		PRINT 'Something went wrong, rolling back'
		ROLLBACK
	END
ELSE 
COMMIT TRAN G1
GO

-- Store Procedure #2 | New Insert Into tblPlaylist
CREATE PROCEDURE NewInsert_tblPlaylist
@PlaylistName VARCHAR(50),
@PlaylistDescr VARCHAR(500),
@PlaylistTypeName VARCHAR(50),
@PlaylistPicture IMAGE,
@CreationDate DATE
AS

DECLARE @PT_ID INT

SET @PT_ID = (SELECT PlaylistTypeID FROM tblPlaylistType WHERE PlaylistTypeName = @PlaylistTypeName)
IF @PT_ID IS NULL
	BEGIN
	PRINT 'Eror present in @PT_ID';
	THROW 51007, '@U_ID cannot be NULL, process is terminating', 1;
	END

BEGIN TRAN G1
INSERT INTO tblPlaylist (PlaylistTypeID, PlaylistName, PlaylistDescr, PlaylistPicture, CreationDate)
VALUES (@PT_ID, @PlaylistName, @PlaylistDescr, @PlaylistPicture, @CreationDate)
IF @@ERROR <> 0
	BEGIN
		PRINT 'Something went wrong, rolling back'
		ROLLBACK
	END
ELSE 
COMMIT TRAN G1
GO




-- Business Rules
-- Bussiness Rule #1 | If you're from North Korea, you can't listen to Justin Beiber
CREATE FUNCTION dbo.fn_NK_No_Beiber()
RETURNS INTEGER
AS
BEGIN
DECLARE @RET INTEGER = 0

IF EXISTS(SELECT *
    FROM tblUser U
        JOIN tblCountry C ON C.CountryID = U.CountryID
        JOIN tblUserType UT ON UT.UserID = U.UserID
        JOIN tbLAccess A ON A.tblUserTypeID = UT.tblUserTypeID
        JOIN tblPlaylistRecording PR ON PR.PlaylistRecordingID = A.PlaylistRecordingID
        JOIN tblRecording R ON R.RecordingID = PR.RecordingID
        JOIN tblSong S ON S.SongID = R.SongID
        JOIN tblWriter W ON W.SongID = S.SongID
        JOIN tblArtist AR ON AR.ArtistID = W.ArtistID
    WHERE C.CountryName = 'North Korea'
        AND AR.ArtistFName = 'Justin'
        AND AR.ArtistLName = 'Beiber'
    )
	BEGIN
	SET @RET = 1
	END
RETURN @RET
END
GO

-- Business Rule #2 | You must be 20 years old to listen to Hip-Hop
CREATE FUNCTION dbo.fn_20_No_HipHop()
RETURNS INTEGER
AS
BEGIN
DECLARE @RET INTEGER = 0

IF EXISTS(SELECT *
    FROM tblUser U
        JOIN tblCountry C ON C.CountryID = U.CountryID
        JOIN tblUserType UT ON UT.UserID = U.UserID
        JOIN tbLAccess A ON A.tblUserTypeID = UT.tblUserTypeID
        JOIN tblPlaylistRecording PR ON PR.PlaylistRecordingID = A.PlaylistRecordingID
        JOIN tblRecording R ON R.RecordingID = PR.RecordingID
        JOIN tblGenre G ON G.GenreID = R.GenreID
    WHERE DATEDIFF(YY, U.Birthdate, GetDate()) < 20
        AND G.GenreName = 'Hip-Hop'
    )
	BEGIN
	SET @RET = 1
	END
RETURN @RET
END
GO





-- #1 | View the Top 5 albums by Lauv after 2010 that have the most amount of songs greater than 5 from greatest to least.
CREATE VIEW view_Lauv_Most_Song_Album AS 
SELECT TOP 5 AL.AlbumName, A.ArtistFName, COUNT(S.SongName) AS NUM_SONGS
FROM tblArtist A
    JOIN tblWriter W ON W.AristID = A.ArtistID
    JOIN tblSong S ON S.SongID = W.SongID
    JOIN tblRecording R ON R.SongID = S.SongID
    JOIN tblAlbumRecording AR ON AR.RecordingID = R.RecordingID
    JOIN tblAlbum AL ON AL.AlbumID = AR.AlbumID
WHERE AL.ReleaseDate > 2010
    AND A.ArtistFName = 'Lauv'
GROUP BY AL.AlbumName, A.ArtistFName
HAVING COUNT(S.SongName) > 5
ORDER BY NUM_SONGS DESC
GO

-- #2 | View the top 5 users that have the most number of Playlists greater than 2 that are older than the age of 20.
CREATE VIEW view_User_Most_Playlist AS 
SELECT TOP 5 U.FName, U.LName, U.Birthdate, COUNT(P.PlaylistID) AS NUM_PLAYLISTS
FROM tblUser U
    JOIN tblCountry C ON C.CountryID = U.CountryID
    JOIN tblUserType UT ON UT.UserID = U.UserID
    JOIN tbLAccess A ON A.tblUserTypeID = UT.tblUserTypeID
    JOIN tblPlaylistRecording PR ON PR.PlaylistRecordingID = A.PlaylistRecordingID
    JOIN tblPlaylist P ON P.PlaylistID = PR.PlaylistID
WHERE DATEDIFF(YY, U.Birthdate, GetDate()) > 20
GROUP BY U.FName, U.LName, U.Birthdate
HAVING COUNT(P.PlaylistID) > 2
ORDER BY NUM_PLAYLISTS DESC
GO


--1) Musics-name-, totalSecond-, artist nama, album name showen view 


CREATE VIEW music_totalSecond_ AS
SELECT albumname,totalsecond,musicname
FROM tblSong S
WHERE Country = 'Brazil'
GO


--2
CREATE VIEW albumname_songcount AS
SELECT albumname,songCount
FROM album
WHERE Country = 'Brazil'
GO
