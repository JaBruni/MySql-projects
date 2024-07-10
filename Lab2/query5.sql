SELECT DISTINCT e.officeID AS theOfficeID, officeName AS theOfficeName, e.city AS theOfficeCity
FROM ElectedOffices e, OfficeHolders o, Persons P1, Persons P2
WHERE e.state LIKE 'CA%' AND ((P1.personID = o.candidateID AND o.officeID = e.OfficeID)
		= (P2.personID = o.candidateID AND o.officeID = e.officeID)) 
		AND P1.personID <> P2.personID;