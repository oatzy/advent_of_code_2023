#!/usr/bin/env -S jq -Rnf

def accumulate:
  if isempty(.[]) then 0 else 
    .[0] as $f | 
    $f[1] + ( .[1: 1 + $f[0]] |= map([.[0], .[1] + $f[1]]) | .[1:] | accumulate ) 
  end;

[
  inputs | split(": ")[1] | [
    split(" ") | map(tonumber?) | group_by(.)[] | select( length | . > 1 )
  ] | length
] |
  ( map( . - 1 | exp2 | floor ) | add ),
  ( map([., 1]) | accumulate )
