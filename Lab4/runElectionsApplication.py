#! /usr/bin/env python

#  runElectionsApplication Solution

import psycopg2, sys, datetime

# usage()
# Print error messages to stderr
def usage():
    print("Usage:  python3 runElectionsApplication.py userid pwd", file=sys.stderr)
    sys.exit(-1)
# end usage

# The three Python functions that for Lab4 should appear below.
# Write those functions, as described in Lab4 Section 4 (and Section 5,
# which describes the Stored Function used by the third Python function).
#
# Write the tests of those function in main, as described in Section 6
# of Lab4.


 # printNumPartyCandidatesAndOfficeHolders (myConn, theParty):
 # party is an attribute in the CandidatesForOffice table, indicating the candidate for office’s
 # party in an election.  A candidate for office in an election runs in a particular party.
 # Every office holder must be a candidate for office (referential integrity), but some
 # candidates for office are office holders and some are not.  Any office holder was in a
 # particular party in the election in which they were candidates for office.
 #
 # The arguments for the printNumPartyCandidatesAndOfficeHolders Python function are the database
 # connection and a string argument, theParty, which is a party.  This Python function prints
 # out the number of candidates for office and the number of offfice holders who were in myParty
 # when they ran as candidates for office in an election.
 #
 # For more details, including error handling and return codes, see the Lab4 pdf.

def printNumPartyCandidatesAndOfficeHolders (myConn, theParty):
   
    # Python function to be supplied by students
    if theParty is None:
        return (-1)
    else:
        try:
            myCursor = myConn.cursor()
            sql = "SELECT COUNT(candidateID) FROM CandidatesForOffice WHERE party = (%s)"
            sql2 = "SELECT Count(o.candidateID) FROM OfficeHolders o, CandidatesForOffice c WHERE party = (%s) AND c.candidateID = o.candidateID AND c.electionDate = o.electionDate AND c.officeID = o.officeID"
            #Execute first sql statement
            myCursor.execute(sql, (theParty,))
            row = myCursor.fetchone()
            print("Number of candidates from party", theParty, "is", row[0])
            
            #Execute second sql statement
            myCursor.execute(sql2, (theParty,))
            row = myCursor.fetchone()
            print("Number of office holders from party", theParty, "is", row[0])
            print()
        except:
            print ("Statement", sql, "is bad", file = sys.stderr)
            myCursor.close()
            myConn.close()
            sys.exit(-1)
        myCursor.close()
    return(0)
# end printNumPartyCandidatesAndOfficeHolders


# increaseLowSalaries (myConn, theSalaryIncrease, theLimitValue):
# salary is an attribute of the ElectedOffices table.  We’re going to increase the salary by a
# certain amount (theSalaryIncrease) for all the elected offices who salary value is less than
# or equal some salary limit (theLimitValue).'
#
# Besides the database connection, the increaseLowSalaries Python function has two arguments,
# a float argument theSalaryIncrease and another float argument, theLimitValue.  For every
# elected office in the ElectedOffices table (if any) whose salary is less than or equal to
# theLimitValue, increaseLowSalaries should increase that salary value by theSalaryIncrease.
#
# For more details, including error handling, see the Lab4 pdf.
def increaseLowSalaries (myConn, theSalaryIncrease, theLimitValue):

    # Python function to be supplied by students
    # You'll need to figure out value to return.

    if theSalaryIncrease <= 0:
        return (-1)
    if theLimitValue <= 0:
        return (-2)
    else:
        try:
            myCursor = myConn.cursor()
            sql = "UPDATE ElectedOffices SET salary = salary + (%s) WHERE salary <= (%s)"
            myCursor.execute(sql, (theSalaryIncrease, theLimitValue))
        except:
            print ("Statement", sql, "is bad", file = sys.stderr)
            myCursor.close()
            myConn.close()
            sys.exit(-1)
        #Count rows affected by sql statement
        k = myCursor.rowcount
        myCursor.close()
        return k
        
# end increaseLowSalaries


# improveSomeRatings (myConn, theParty, maxRatingImprovements):
# Besides the database connection, this Python function has two other parameters, theParty which
# is a string, and maxRatingImprovements which is an integer.
#
# improveSomeRatings invokes a Stored Function, improveSomeRatingsFunction, that you will need to
# implement and store in the database according to the description in Section 5.  The Stored
# Function improveSomeRatingsFunction has all the same parameters as improveSomeRatings (except
# for the database connection, which is not a parameter for the Stored Function), and it returns
# an integer.
#
# Section 5 of the Lab4 tells you which ratings to improve and how to improve them, and explains
# the integer value that improveSomeRatingsFunction returns.  The improveSomeRatings Python
# function returns the same integer value that the improveSomeRatingsFunction Stored Function
# returns.
#
# improveSomeRatingsFunction doesn’t print anything.  The improveSomeRatings function must only
# invoke the Stored Function improveSomeRatingsFunction, which does all of the work for this part
# of the assignment; improveSomeRatings should not do any of the work itself.
#
# For more details, see the Lab4 pdf.

def improveSomeRatings (myConn, theParty, maxRatingImprovements):
# We're giving you the code for improveSomeRatings, but you'll have to write the
# Stored Function improveSomeRatingsFunction yourselves in a PL/pgSQL file named
# improveSomeRatingsFunction.pgsql
    
    try:
        myCursor = myConn.cursor()
        sql = "SELECT improveSomeRatingsFunction(%s, %s)"
        myCursor.execute(sql, (theParty, maxRatingImprovements))
    except:
        print("Call of improveSomeRatingsFunction with arguments", theParty, maxRatingImprovements, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    row = myCursor.fetchone()
    myCursor.close()
    return(row[0])

#end improveSomeRatings


def main():

    if len(sys.argv)!=3:
       usage()

    hostname = "cse182-db.lt.ucsc.edu"
    userID = sys.argv[1]
    pwd = sys.argv[2]

    # Try to make a connection to the database
    try:
        myConn = psycopg2.connect(host=hostname, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)
        
    # We're making every SQL statement a transaction that commits.
    # Don't need to explicitly begin a transaction.
    # Could have multiple statement in a transaction, using myConn.commit when we want to commit.
    
    myConn.autocommit = True
    
    # There are other correct ways of writing all of these calls correctly in Python.
        
    # Perform tests of printNumPartyCandidatesAndOfficeHolders, as described in Section 6 of
    # Lab4.  That Python function handles printing when there is no error.
    # Print error outputs here. You may use a Python method to help you do the printing.
    
    #Test 1
    test = printNumPartyCandidatesAndOfficeHolders(myConn, 'Silver')
    if test < 0:
        print( "Error: theParty Silver is NULL")
        print()
    
    #Test 2
    test2 = printNumPartyCandidatesAndOfficeHolders(myConn, 'Copper')
    if test2 < 0:
        print( "Error: theParty Copper is NULL")
        print()
        
    # Perform tests of increaseLowSalaries, as described in Section 6 of Lab4.
    # Print their outputs (including error outputs) here, not in increaseLowSalaries.
    # You may use a Python method to help you do the printing.
    
    #Test 1
    num = increaseLowSalaries(myConn, 6000, 125000)
    if num < 0:
        print("Error: salaryIncrease 6000 is <=0 or theLimitValue 125000 <= 0")
        print()
    elif num >= 0:
        print("Number of elected offices whose salaries under 125000 were updated by 6000 is", num)
        print()
        
    #Test 2   
    num2 = increaseLowSalaries(myConn, 4000, 131000)
    if num2 < 0:
        print("Error: salaryIncrease 4000 is <=0 or theLimitValue 131000 <= 0")
        print()
    elif num2 >= 0:
        print("Number of elected offices whose salaries under 131000 were updated by 4000 is", num)
        print()
    
    # Perform tests of improveSomeRatings, as described in Section 6 of Lab4,
    # Print their outputs (including error outputs) here, not in improveSomeRatings.
    # You may use a Python method to help you do the printing.
    
    #Test 1
    num = improveSomeRatings(myConn, 'Copper', 6)
    if num >= 0:
        print("Number of ratings which improved for party Copper for maxRatingImprovements value 6 is", num)
        print()
    else:
        print("Error: theParty Copper is NULL or maxRatingImprovements value 6 is <= 0")
        print()
     
    #Test 2 
    num2 = improveSomeRatings(myConn, 'Gold', 1)
    if num2 >= 0:
        print("Number of ratings which improved for party Gold for maxRatingImprovements value 1 is", num2)
        print()
    else:
        print("Error: theParty Gold is NULL or maxRatingImprovements value 1 is <= 0")
        print()
        
    #Test 3   
    num3 = improveSomeRatings(myConn, 'Silver', 1)
    if num3 >= 0:
        print("Number of ratings which improved for party Silver for maxRatingImprovements value 1 is", num3)
        print()
    else:
        print("Error: theParty Silver is NULL or maxRatingImprovements value 1 is <= 0")
        print()
    
    #Test 4
    num4 = improveSomeRatings(myConn, 'Platinum', 0)
    if num4 >= 0:
        print("Number of ratings which improved for party Platinum for maxRatingImprovements value 0 is", num4)
        print()
    else:
        print("Error: theParty Platinum is NULL or maxRatingImprovements value 0 is <= 0")
        print()
    
    #Test 5
    num5 = improveSomeRatings(myConn, 'Copper', 6)
    if num5 >= 0:
        print("Number of ratings which improved for party Copper for maxRatingImprovements value 6 is", num5)
        print()
    else:
        print("Error: theParty Copper is NULL or maxRatingImprovements value 6 is <= 0")
        print()
      
    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end
