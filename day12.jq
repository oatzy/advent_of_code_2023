#!/usr/bin/env -S jq -Rnf

def pattern: [splits("\\.+") | select(. != "") | length];

def matches($pttn):
  def r:
    if (contains("?") | not) then
      if pattern == $pttn then 1 else 0 end
    else 
      (sub("\\?"; ".") | r) + (sub("\\?"; "#") | r)
    end;
  r;
  
[inputs | split(" ") | 
  (.[1] | split(",") | map(tonumber)) as $pattern | 
  .[0] | matches($pattern)
] | add
