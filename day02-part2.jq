#!/usr/bin/env -S jq -Rnf

def power: ([.[].red] | max) * ([.[].green] | max) * ([.[].blue] | max);

[inputs |
capture("Game \\d+: (?<r>.+)") | 
  .r | split("; ") | map( 
    split(", ") | map( split(" ") | {key: .[1], value: .[0] | tonumber} ) | from_entries
  ) | power] | add

