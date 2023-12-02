#!/usr/bin/env -S jq -Rnf

def possible: .red <= 12 and .green <= 13 and .blue <= 14;
def power: ([.[].red] | max) * ([.[].green] | max) * ([.[].blue] | max);

[ inputs |
capture("Game (?<n>\\d+): (?<r>.+)") | [
  ( .n | tonumber ), 
  ( .r | split("; ") | map( 
    split(", ") | map( split(" ") | {key: .[1], value: .[0] | tonumber} ) | from_entries
  ))
] | [
  ( .[0] * ( if ( .[1] | map(possible) | all ) then 1 else 0 end ) ), 
  ( .[1] | power )
] ] | transpose | map(add)
