BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE ElectedOffices e
SET officeName = me.officeName, city = me.city, state = me.state, salary = NULL
FROM ModifyElectedOffices me
WHERE e.officeID = me.officeID;
INSERT INTO ElectedOffices
SELECT me.officeID, me.officeName, me.city, me.state, 12346.67
FROM ModifyElectedOffices me
WHERE NOT EXISTS ( SELECT * 
	FROM ElectedOffices e
	WHERE e.officeID = me.officeID);
COMMIT TRANSACTION;
