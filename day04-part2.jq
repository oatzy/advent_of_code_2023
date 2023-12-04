#!/usr/bin/env -S jq -Rnf

def fold:
  def _r:
    if isempty(.[]) then 0 else .[0] as $f | $f[1] + (.[1:1+$f[0]] |= map([.[0],.[1]+$f[1]]) | .[1:] | _r) end;
  _r;
 
[inputs | split(": ")[1] | [split(" ") | map(try tonumber) | group_by(.)[] | select(length|.>1)] | length | [., 1]] | fold
