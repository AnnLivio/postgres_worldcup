#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

GET_TEAM_ID(){
  local team_name=$1

  # get team_id
  team_id=$($PSQL "SELECT team_id FROM teams WHERE name='$team_name'")

  # if not found
  if [[ -z $team_id ]]
  then
    # insert team
    local insert_team=$($PSQL "INSERT INTO teams(name) VALUES('$team_name')")

    # get new team_id
    team_id=$($PSQL "SELECT team_id FROM teams WHERE name='$team_name'")

  fi
  echo $team_id
  return $team_id 
}

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WGOALS OGOALS
do
  if [[ $YEAR != "year" ]]
  then
    # get winner team_id
    GET_TEAM_ID "$WINNER"
    # winner ID
    WID=$team_id

    # get opponent team_id
    GET_TEAM_ID "$OPPONENT"
    # opponent ID
    OID=$team_id

    # insert game into games table
    INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WID, $OID, $WGOALS, $OGOALS)")
    if [[ $INSERT_GAME == 'INSERT 0 1' ]]
    then
      echo "Insert game  $YEAR, $ROUND, $WINNER id $WID, $OPPONENT id $OID, goals: $WGOALS, $OGOALS"
    
    fi    
  fi
done
