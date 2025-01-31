# Bash + PostgreSQL
A worldcup project using bash scripting and postgreSQL db

## The data
games.csv: It contains a comma-separated list of all games of the final three rounds of the World Cup tournament since 2014; the titles are at the top. It includes the year of each game, the round of the game, the winner, their opponent, and the number of goals each team scored. 

## Part 1: Create the database
+ Log into the psql interactive terminal with psql --username=user --dbname=postgres.
+ Ccreate a database named `worldcup`.
+ Connect to the database after we create it.
+ Create tables:`teams` and `games`

*teams table* | should have a team_id column that is a type of SERIAL and is the primary key, and a name column that has to be UNIQUE

*games table* | should have a game_id column that is a type of SERIAL and is the primary key, a year column of type INT, and a round column of type VARCHAR, winner_id and opponent_id foreign key columns that each reference team_id from the teams table, winner_goals and opponent_goals columns that are type INT.

All of columns should have the NOT NULL constraint.
  
## Part 2: Insert the data
*insert_data.sh:* script to correctly insert all the data from games.csv into the database. When we run this file, it should add each unique team to the teams table and each game in games table.

## Part 3: Query the database
*queries.sh* file to produce output that matches the expected_output.txt file.

## Dump:
We make a dump of the db by entering pg_dump -cC --inserts -U user worldcup > worldcup.sql in bash terminal. It will save the commands to rebuild our database in worldcup.sql. We can rebuild the database by entering psql -U postgres < worldcup.sql in a terminal where the .sql file is.
