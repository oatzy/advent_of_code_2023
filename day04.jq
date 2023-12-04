#!/usr/bin/env -S jq -Rnf

def fold:
  def r:
    if isempty(.[]) then 0 else 
        .[0] as $f | $f[1] + ( .[1: 1 + $f[0]] |= map([.[0], .[1] + $f[1]]) | .[1:] | r ) 
    end;
  r;

[
  inputs | split(": ")[1] | [
    split(" ") | map(try tonumber) | group_by(.)[] | select(length | . > 1)
  ] | length
] | [
  ( map(. - 1 | exp2 | floor) | add ),
  ( map([., 1]) | fold )
]
