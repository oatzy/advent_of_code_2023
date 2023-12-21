#!/usr/bin/env -S jq -Rnsf

def prefix_eq: transpose | map(.[0] == null or .[1] == null or .[0] == .[1]) | all;

def is_reflection($i): [(.[:$i] | reverse), .[$i:]] | prefix_eq;

def find_reflection:
  def r($i):
    if $i == (.[0] | length) then 0 else
      if (map(is_reflection($i)) | all) then $i else r($i + 1) end
    end;
  r(1);

input | rtrimstr("\n") | split("\n\n") | map(split("\n") | map(split("")) | (find_reflection) + 100 * (transpose | find_reflection)) | add
