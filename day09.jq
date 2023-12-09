#!/usr/bin/env -S jq -Rnf

def delta: [.[:-1], .[1:]] | transpose | map(.[1] - .[0]);

def next:
  def r:
    if all(. == 0) then 0 else .[-1] + (delta | r) end;
  r;

def prev:
  def r:
    if all(. == 0) then 0 else .[0] - (delta | r) end;
  r;

[ inputs | split(" ") | map(tonumber) | [next, prev] ] | transpose | map(add)
