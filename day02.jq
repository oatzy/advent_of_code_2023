#!/usr/bin/env -S jq -Rnf

def possible: .red <= 12 and .green <= 13 and .blue <= 14;

[ inputs |
capture("Game (?<n>\\d+): (?<r>.+)") | {
  (.n): .r | split("; ") | map( 
    split(", ") | map( split(" ") | {key: .[1], value: .[0] | tonumber} ) | from_entries | possible
  ) | select( . | all )
} | keys ] | flatten | map(tonumber) | add
