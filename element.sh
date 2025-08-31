#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# if parameter is null
if [[ -z $1 ]] 
then
  echo "Please provide an element as an argument."
else
  #  query element
  QUERY_ELEMENT=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, t.type as type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types t USING(type_id) WHERE symbol='$1' OR name='$1' OR atomic_number::TEXT='$1'")

  # if cannot query element
  if [[ -z $QUERY_ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    # format result of query element
    IFS="|" read NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE <<< "$QUERY_ELEMENT"
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi