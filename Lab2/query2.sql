SELECT P1.personName AS contributorName, P2.personName AS candidateName, contribution
FROM Persons P1, Persons P2, Contributions Co, CandidatesForOffice Ca
WHERE party LIKE '%Gold%' AND Ca.candidateID = Co.candidateID 
		AND Ca.electionDate = Co.electionDate AND P1.personID = contributorID 
		AND P2.personID = Co.candidateID
ORDER BY contribution DESC, P1.personName ASC;