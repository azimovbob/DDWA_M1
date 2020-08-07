DROP DATABASE IF EXISTS Hotel;
CREATE DATABASE Hotel;

USE Hotel;

CREATE TABLE RoomType(
	RoomTypeId INT PRIMARY KEY AUTO_INCREMENT,
	Type VARCHAR(6) NOT NULL,
	StandartOcc SMALLINT NOT NULL,
	MaxOcc SMALLINT NOT NULL,
	BasePrice DECIMAL(5,2) NOT NULL,
	ExtraPersonFee INTEGER DEFAULT 0
);

CREATE TABLE Amenities(
	AmenityId INTEGER PRIMARY KEY AUTO_INCREMENT,
	AmenityType VARCHAR(15)
);

CREATE TABLE Room(
	RoomNumber INTEGER PRIMARY KEY,
	ADA_Accessible BOOLEAN NOT NULL,
	RoomTypeId INTEGER NOT NULL,
	FOREIGN KEY fk_Room_RoomType(RoomTypeId)
		REFERENCES RoomType(RoomTypeId)
);

CREATE TABLE RoomAmenities(
	RoomNumber INTEGER NOT NULL,
	AmenityId INTEGER NOT NULL,
	PRIMARY KEY (RoomNumber, AmenityId),
	FOREIGN KEY fk_RoomAmenities_Room(RoomNumber)
		REFERENCES Room(RoomNumber),
	FOREIGN KEY fk_RoomAmenities_Amenities(AmenityId)
		REFERENCES Amenities(AmenityId)	
);

CREATE TABLE Address(
	AddressId INTEGER PRIMARY KEY AUTO_INCREMENT,
	Address VARCHAR(100),
	City VARCHAR(25),
	StateAbb CHAR(2),
	Zipcode CHAR(5)
);

CREATE TABLE Guest(
	GuestId INTEGER PRIMARY KEY AUTO_INCREMENT,
	FirstName VARCHAR(20),
	LastName VARCHAR(20),
	AddressId INTEGER NOT NULL,
	FOREIGN KEY fk_Guest_Address(AddressId)
		REFERENCES Address(AddressId),
	Phone CHAR(10) NOT NULL
);

CREATE TABLE Reservation(
	ReservationId INTEGER PRIMARY KEY AUTO_INCREMENT,
	GuestId INTEGER NOT NULL,
	FOREIGN KEY fk_Reservation_Guest(GuestId)
		REFERENCES Guest(GuestId),
	Adults SMALLINT DEFAULT 1,
	Children SMALLINT DEFAULT 0,
	RoomNumber INTEGER NOT NULL,
	FOREIGN KEY fk_Reservation_Room(RoomNumber)
		REFERENCES Room(RoomNumber),
	Check_in DATE NOT NULL,
	Check_out DATE NOT NULL,
	TotalPrice DECIMAL (7,2) 
);