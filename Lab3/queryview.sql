SELECT DISTINCT w.candidateID, personName, w.officeID, w.electionDate
FROM WronglyDeclaredWinnerView w, Persons, OfficeHolders o
WHERE w.candidateID = personID AND w.candidateID = o.candidateID AND w.officeID = o.officeID
		AND w.electionDate = o.electionDate;
		
/* jabruni=> \i queryview.sql
 candidateid |    personname    | officeid | electiondate
-------------+------------------+----------+--------------
           3 | Alexander Hilton |      101 | 2018-01-31
           9 | Penny Taylor     |      106 | 2005-05-15
(2 rows) */

UPDATE CandidatesForOffice
SET wonElection = FALSE
WHERE candidateID = 9 AND officeID = 106 AND electionDate = '2005-05-15';

SELECT DISTINCT w.candidateID, personName, w.officeID, w.electionDate
FROM WronglyDeclaredWinnerView w, Persons, OfficeHolders o
WHERE w.candidateID = personID AND w.candidateID = o.candidateID AND w.officeID = o.officeID
		AND w.electionDate = o.electionDate;
		
/* UPDATE 1
 candidateid |    personname    | officeid | electiondate
-------------+------------------+----------+--------------
           3 | Alexander Hilton |      101 | 2018-01-31
(1 row) */