ALTER TABLE Contributions
ADD CONSTRAINT ContributorIdFK FOREIGN KEY(contributorID) REFERENCES Persons(personID)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE Contributions
ADD CONSTRAINT CONTFK FOREIGN KEY(candidateID, officeID, electionDate)
	REFERENCES CandidatesForOffice(candidateID, officeID, electionDate)
ON UPDATE RESTRICT
ON DELETE RESTRICT;
	
ALTER TABLE OfficeHolders 
ADD CONSTRAINT OfficeFK FOREIGN KEY(candidateID, officeID, electionDate)
	REFERENCES CandidatesForOffice(candidateID, officeID, electionDate)
ON UPDATE RESTRICT
ON DELETE RESTRICT;