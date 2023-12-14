# Task 4

## How to execute

1. Clone this git repository
1. Change to the newly created directory `cd IV1351_Tasks/Seminar4/task4`
1. Make sure there is a database which can be reached with the url on line 38 in `SchoolDAO.java`.
1. Create the tables described by `IV1351_Tasks/Seminar4/SQL-schema.sql` (postgres).
1. Build the project with the command `mvn install`
1. Run the program with the command `mvn exec:java`

## Commands for the bank program

- `help` displays all commands.
- `list` Lists instruments. Options: all, <instrument type>.
- `rent` Rents an instrument. Options: <instrument id> <student id>.
- `terminate` Terminates the rental of an instrument. Options: <rental id>.
- `quit` quits the application.
