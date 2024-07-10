--Foreign Key Constraint Tests
INSERT INTO Contributions
VALUES (16, 1, 101, '2000-05-14', 50000);

INSERT INTO Contributions
VALUES (11, 16, 108, '2020-02-03');

INSERT INTO OfficeHolders(candidateID, officeID, electionDate)
VALUES (16, 108, '2020-02-03');

-- First General Constraint
UPDATE Contributions
SET contribution = 300
WHERE contributorID = 11;

--Test Output
--SELECT *
--FROM Contributions;

UPDATE Contributions
SET contribution = 0
WHERE contributorID = 12;

--Second General Constraint
UPDATE Elections
SET officeStartDate = '2019-02-02'
WHERE officeID = 101 AND electionDate ='2018-01-31';

--Test Output
--SELECT *
--FROM Elections;

UPDATE Elections 
SET officeStartDate = '2020-04-25'
WHERE officeID = 102 AND electionDate = '2015-04-21';

--Third General Constraint
UPDATE CandidatesForOffice
SET wonElection = NULL
WHERE candidateID = 9 AND officeID = 101;

--Test Output
--SELECT *
--FROM CandidatesForOffice;

UPDATE CandidatesForOffice
SET wonElection = FALSE
WHERE candidateID = 9 AND officeID = 104; 
