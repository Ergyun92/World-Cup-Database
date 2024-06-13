#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games, teams");
cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
  if [[ $opponent != opponent ]]
  then
    name=$($PSQL" SELECT name FROM teams WHERE name='opponent'")
    if [[ -z $name ]]
    then
      INSERT_NAME=$($PSQL" INSERT INTO teams(name) VALUES ('$opponent')")
      if [[ $INSERT_NAME == "INSERT 0 1" ]]
      then
        echo "Inserted into teams, $opponent"
      fi
    fi
  fi
  if [[ $winner != winner ]]
  then
    name=$($PSQL "SELECT name FROM teams WHERE name='$winner'")
    if [[ -z $name ]]
    then
      INSERT_WINNER=$($PSQL "INSERT INTO teams(name) VALUES('$winner')")
        if [[ $INSERT_WINNER == "INSERT 0 1" ]]
        then
          echo "Inserted into teams, $winner"
        fi
    fi
  fi
done  

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
 if [[ $winner != winner ]] 
  then
    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
    echo "$winner_id"
    if [[ -z $winner ]]
    then
      winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
    fi
  fi
  if [[ $opponent != opponent ]] 
  then
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
    echo "$opponent_id"
    if [[ -z $opponent ]]
    then
      opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
    fi
  INSERT_ALL_DATA=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$year', '$round','$winner_id','$opponent_id',$winner_goals,$opponent_goals)")
    if [[ $INSERT_ALL_DATA == "INSERT 0 1" ]]
    then
      echo "Inserted into games, $year, $round,$winner,$opponent,$winner_goals,$opponent_goals"
    fi
  fi

done
