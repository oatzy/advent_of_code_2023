#!/usr/bin/env -S jq -Rnf

[inputs | [scan("\\d+") | tonumber]] | transpose | map((.[0]*.[0] - 4*.[1] | sqrt) as $d | (.[0]/2+$d/2|floor) - (.[0]/2-$d/2|ceil) + 1) | reduce .[] as $i (1; . * $i)
