DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;

--Create Tables

CREATE TABLE Persons (
	personID INT,
	personName VARCHAR(40),
	city VARCHAR(40),
	state CHAR(2),
	occupation VARCHAR(20),
	isFelon BOOL,
	PRIMARY KEY (personID)
);

CREATE TABLE ElectedOffices (
	officeID INT,
	officeName VARCHAR(20),
	city VARCHAR(40),
	state CHAR(2),
	salary NUMERIC(8,2),
	PRIMARY KEY (officeID)
);

CREATE TABLE Elections (
	officeID INT,
	electionDate DATE,
	officeStartDate DATE,
	officeEndDate DATE,
	PRIMARY KEY (officeID, electionDate),
	FOREIGN KEY (officeID) REFERENCES ElectedOffices
);

CREATE TABLE CandidatesForOffice (
	candidateID INT,
	officeID INT,
	electionDate DATE,
	party VARCHAR(20),
	votes INT, 
	totalContributions NUMERIC(9,2),
	wonElection BOOL,
	PRIMARY KEY(candidateID, officeID, electionDate),
	FOREIGN KEY (candidateID) REFERENCES Persons,
	FOREIGN KEY (officeID, electionDate) References Elections
);

CREATE TABLE Contributions (
	contributorID INT,
	candidateID INT,
	officeID INT,
	electionDate DATE,
	contribution NUMERIC(8,2),
	PRIMARY KEY(contributorID, candidateID, officeID, electionDate),
	FOREIGN KEY (contributorID) REFERENCES Persons,
	FOREIGN KEY (candidateID, officeID, electionDate)  REFERENCES CandidatesForOffice
);

CREATE TABLE OfficeHolders (
	candidateID INT,
	officeID INT,
	electionDate DATE,
	rating CHAR(1),
	PRIMARY KEY (candidateID, officeID, electionDate),
	FOREIGN KEY (candidateID, officeID, electionDate) REFERENCES CandidatesForOffice
);