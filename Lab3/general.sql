ALTER TABLE Contributions ADD CONSTRAINT contributionPositive 
	CHECK (contribution > 0);

ALTER TABLE Elections ADD CONSTRAINT electionStartBeforeEnd
	CHECK (officeStartDate < officeEndDate);
	
ALTER TABLE CandidatesForOffice ADD CONSTRAINT votesNullWonNull 
	CHECK (votes != NULL OR wonElection = NULL);
	