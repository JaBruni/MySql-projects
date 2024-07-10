SELECT DISTINCT personID, occupation
FROM Persons, CandidatesForOffice c, OfficeHolders o
WHERE personID NOT IN (SELECT candidateID
					FROM OfficeHolders) AND personID = c.candidateID;