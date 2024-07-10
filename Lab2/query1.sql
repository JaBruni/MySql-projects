SELECT DISTINCT e.officeID AS theOfficeID, e.electionDate AS theElectionDate, 
				officeStartDate AS theOfficeStartDate, officeEndDate AS theOfficeEndDate
FROM Elections e, CandidatesForOffice c, Persons
WHERE e.electionDate = c.electionDate AND candidateID IN (SELECT personID
										FROM Persons
										WHERE isFelon = TRUE);
	
							