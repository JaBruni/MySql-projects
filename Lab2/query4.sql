SELECT DISTINCT personName, rating, salary, occupation, officeName
FROM Persons, OfficeHolders o, ElectedOffices Eo, Elections E
WHERE (rating LIKE 'A%' OR rating LIKE '%B') AND personID = o.candidateID 
		AND o.officeID = Eo.officeID AND o.officeID = E.officeID 
		AND e.electionDate = o.ElectionDate AND salary > 125000 
		AND occupation IS NOT NULL AND officeName LIKE '%or';

