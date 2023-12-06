#!/usr/bin/env -S jq -Rnf

def wins: 
    ( .[0] * .[0] - 4 * .[1] | sqrt ) as $d | 
    ( .[0]/2 + $d/2 | floor ) - ( .[0]/2 - $d/2 | ceil ) + 1;

[inputs | [scan("\\d+")] | [
  map(tonumber)[], 
  ( add | tonumber )
]] | transpose | 
  map(wins) |
    (reduce .[:-1][] as $i (1; .*$i)), 
    last
