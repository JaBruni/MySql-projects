CREATE OR REPLACE FUNCTION
improveSomeRatingsFunction( IN theParty VARCHAR(20), IN maxRatingImprovements INTEGER)
RETURNS INTEGER AS $$

	DECLARE 
		numImproved 	INTEGER; /* Number Improved, the value returned */
		theCandidateID 	INTEGER; /* The candidate to be improved */
		theOfficeID     INTEGER;
		theElectionDate DATE;
		theRating		CHAR(1);
		
	DECLARE improveCursor CURSOR FOR
		SELECT o.rating, o.candidateID, o.electionDate, o.officeID
		FROM CandidatesForOffice c, OfficeHolders o
		WHERE c.candidateID = o.candidateID 
			AND c.officeID = o.officeID
			AND c.electionDate = o.electionDate
			AND c.party = theParty
			AND o.rating IN ('B', 'C', 'D', 'F')
		ORDER BY o.electionDate DESC;

	BEGIN
		-- Input Validation
		IF maxRatingImprovements <= 0 THEN
			RETURN -1;
			END IF;
			
		numImproved := 0;
	
		OPEN improveCursor;
	
		LOOP
			FETCH improveCursor INTO theRating, theCandidateID, theElectionDate, theOfficeID;
			
			EXIT WHEN NOT FOUND OR numImproved >= maxRatingImprovements;
		
			IF theRating = 'B' THEN
				UPDATE OfficeHolders
				SET rating = 'A'
				WHERE candidateID = theCandidateID AND electionDate = theElectionDate AND officeID = theOfficeID;
				numImproved := numImproved + 1;
				END IF;
			
			IF theRating = 'C' THEN
				UPDATE OfficeHolders
				SET rating = 'B'
				WHERE candidateID = theCandidateID AND electionDate = theElectionDate AND officeID = theOfficeID;
				numImproved := numImproved + 1;
				END IF;
				
			IF theRating = 'D' THEN
				UPDATE OfficeHolders
				SET rating = 'C'
				WHERE candidateID = theCandidateID AND electionDate = theElectionDate AND officeID = theOfficeID;
				numImproved := numImproved + 1;
				END IF;
				
			IF theRating = 'F' THEN
				UPDATE OfficeHolders
				SET rating = 'D'
				WHERE candidateID = theCandidateID AND electionDate = theElectionDate AND officeID = theOfficeID;
				numImproved := numImproved + 1;
				END IF;
						
		END LOOP;
		CLOSE improveCursor;
			
		RETURN numImproved;
	END;
$$ LANGUAGE plpgsql;	