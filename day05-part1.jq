#!/usr/bin/env -S jq -Rsnf

def apply_map: 
    def r:
        .[0] as $seed |
        if isempty(.[1][]) then $seed else (
            .[1][0] as $next | ($seed - $next[1]) as $diff |
            if $diff >= 0 and $diff < $next[2] 
                then $next[0] + $diff 
                else ([$seed, .[1][1:]] | r)
            end
        ) end;
    r;

def find_location($seed): reduce .[] as $m ($seed; [., $m] | apply_map);


def parse_map: . | rtrimstr("\n") | split("\n")[1:] | map(split(" ") | map(tonumber));
def parse_seeds: . | split(": ")[1] | split(" ") |  map(tonumber); 

input | split("\n\n") | [(.[0] | parse_seeds), [(.[1:][] | parse_map)]]
| .[1] as $maps | [.[0][] | (. as $seed | $maps | find_location($seed))] | min
