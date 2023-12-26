#!/usr/bin/env -S jq -Rnf

def grad: .[1][1][0] * .[0][1][1] - .[0][1][0] * .[1][1][1];

def calcx($g): ( 
  .[0][1][0] * .[1][1][0] * (.[1][0][1] - .[0][0][1]) + 
  .[1][1][0] * .[0][1][1] * .[0][0][0] -
  .[0][1][0] * .[1][1][1] * .[1][0][0]
) / $g;

def calcy($x; $t): .[0][1][1] * $t + .[0][0][1];

def calct($x; $i): ($x - .[$i][0][0]) / .[$i][1][0];

def intersects:
  if .[0] == .[1] then false else
    grad as $g | if $g == 0 then false else
      calcx($g) as $x | if $x < 200000000000000 or $x > 400000000000000 then false else
        calct($x; 0) as $t | if $t < 0 then false else
          if calct($x; 1) < 0 then false else
            calcy($x; $t) as $y | if $y < 200000000000000 or $y > 400000000000000 then false else true end
          end
        end
      end
    end
  end;

[[inputs | split(" @ ") | map(split(", ") | map(tonumber))] | [., .] | combinations | if intersects then 1 else 0 end] | add | . / 2
