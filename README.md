[README.md](https://github.com/user-attachments/files/29916106/README.md)
# Relational Database Projects — PostgreSQL

A series of database engineering projects implementing and querying a **campaign-finance / elections database** in PostgreSQL. The work progresses from schema design through advanced querying, constraints, views, transactions, stored procedures, and a Python database application.

Originally built as coursework at UC Santa Cruz.

**Tech:** PostgreSQL · SQL · PL/pgSQL · Python (`psycopg2`)

---

## Data Model

Six related tables model elected offices, elections, candidates, campaign contributions, and office-holder performance ratings:

| Table | Description |
| --- | --- |
| `Persons` | People — contributors, candidates, and office holders |
| `ElectedOffices` | Offices that can be run for, with salary and location |
| `Elections` | Election events tied to an office and date |
| `CandidatesForOffice` | Candidates running in a given election, votes, and contributions |
| `Contributions` | Individual campaign contributions from a person to a candidate |
| `OfficeHolders` | Candidates who won and hold office, with a performance rating |

The schema uses composite primary keys and foreign-key relationships to enforce referential integrity across all six tables.

---

## Projects

### Lab 1 — Schema Design & DDL
Designed a normalized six-table relational schema from scratch, defining primary keys, composite keys, and foreign-key relationships between offices, elections, candidates, and contributions.

### Lab 2 — Constraints & Querying
Extended the schema with integrity constraints (`NOT NULL`, `UNIQUE`) and wrote a set of analytical queries using:
- Multi-table joins
- `IN` / `NOT IN` subqueries
- Self-joins
- `LIKE` pattern matching
- Multi-column sorting (`ORDER BY ... ASC/DESC`)

### Lab 3 — Views, Constraints, Indexing & Transactions
The most feature-rich lab:
- **`CHECK` constraints** enforcing business rules (e.g., positive contributions, valid date ranges)
- An **index** to support a common lookup
- A **view** built on `COUNT`, `GROUP BY`, `HAVING`, and a **correlated subquery** to flag a data-integrity problem — candidates recorded as winning an election without having the highest vote count
- **Foreign keys with referential actions** (`ON UPDATE` / `ON DELETE` `CASCADE` and `RESTRICT`)
- A **serializable transaction** performing an upsert (`UPDATE` followed by a conditional `INSERT ... WHERE NOT EXISTS`)
- **Constraint unit tests** verifying that foreign-key and `CHECK` rules fire correctly

### Lab 4 — Stored Functions & Python Application
- A **PL/pgSQL stored function** that improves office-holder ratings for a given party, using a **cursor**, a loop, input validation, and conditional update logic, returning the number of rows changed
- A **Python (`psycopg2`) command-line application** that connects to the database, runs **parameterized (SQL-injection-safe) queries**, handles errors and connection cleanup, and calls the stored function

---

## Concepts Demonstrated

- Schema design & normalization
- Primary, foreign, and composite keys; referential-integrity actions
- Constraints: `NOT NULL`, `UNIQUE`, `CHECK`
- Joins, subqueries, self-joins, pattern matching, and sorting
- Aggregation: `GROUP BY`, `HAVING`, `COUNT`, `MAX`
- Views
- Indexing
- Transactions and isolation levels (`SERIALIZABLE`); upsert pattern
- PL/pgSQL stored functions (cursors, loops, control flow)
- Python ↔ database integration with `psycopg2` and parameterized queries

---

## Repository Structure

```
Lab1/   Schema design (DDL)
Lab2/   Schema + constraints and five analytical queries
Lab3/   Views, CHECK constraints, indexing, transactions, FK actions, tests
Lab4/   PL/pgSQL stored function + Python application
```

---

## Getting Started

Requires PostgreSQL and (for Lab 4) Python 3 with `psycopg2`.

```bash
# Load a schema into your database
psql -U <user> -d <database> -f Lab1/create_lab1.sql

# Run a query
psql -U <user> -d <database> -f Lab2/query1.sql

# Run the Python application (Lab 4)
python3 Lab4/runElectionsApplication.py <userid> <password>
```
