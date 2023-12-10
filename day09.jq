#!/usr/bin/env -S jq -Rnf

def delta: [.[:-1], .[1:]] | transpose | map(.[1] - .[0]);

def extend:
  if all(. == 0) then [0, 0] else 
    ( delta | extend ) as $d | [.[-1] + $d[0], .[0] - $d[1]]
  end;

[ inputs | split(" ") | map(tonumber) | extend ] | transpose | map(add)
