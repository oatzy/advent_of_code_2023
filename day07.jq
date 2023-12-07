#!/usr/bin/env -S jq -Rnf

def pad($len; $fill): [., [foreach range($len) as $i ($fill; .)]] | transpose | map(max); 

def canonise: explode | group_by(.) | map(length | tostring) | pad(5; "0") | sort | reverse | add;

def jcanonise: 
  ( [scan("J")] | length ) as $js | gsub("J"; "") | 
  explode | group_by(.) | map(length) | pad(5; 0) | sort | reverse | .[0] += $js | map(tostring) | add;

def hexify($j): gsub("A"; "E") | gsub("K"; "D") | gsub("Q"; "C") | gsub("J"; $j) | gsub("T"; "A");

def power: reduce .[] as $i ([1, 0]; [.[0] + 1, .[1] + .[0] * $i]) | last;

[inputs | split(" ")] | [
  sort_by(.[0] | canonise + hexify("B")),
  sort_by(.[0] | jcanonise + hexify("1"))
] | map( 
  map( .[1] | tonumber ) | power
)
