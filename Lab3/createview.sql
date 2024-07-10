CREATE VIEW WronglyDeclaredWinnerView(candidateID, officeID, electionDate, numCandidatesWithMoreVotes) AS
SELECT DISTINCT C1.candidateID, C1.officeID, C1.electionDate, COUNT(C1.candidateID)
FROM CandidatesForOffice C1, CandidatesForOffice C2
WHERE C1.wonElection = TRUE AND C1.votes <> (SELECT MAX(votes) 
										FROM CandidatesForOffice C3
										WHERE C1.electionDate = C3.electionDate) 
										AND C1.electionDate = C2.electionDate 
										AND C1.officeID = C2.officeID AND C1.votes < C2.votes
GROUP BY C1.candidateID, C1.officeID, C1.electionDate
HAVING COUNT(C1.candidateID) >= 2;