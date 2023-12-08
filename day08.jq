#!/usr/bin/env -S jq -Rnsf

def rotate: .[1:] + [.[0]];

def gcd: sort | reverse | until(.[1] == 0; [.[1], .[0] % .[1]]) | first;
def lcm: .[0] * .[1] / gcd;
def lcm_all: reduce .[] as $i ( 1; [., $i] | lcm );

def path_length(target):
  def r:
    if target then 0 else
      .tree[.cur][.lr[0]] as $next |
      1 + ( {cur: $next, lr: ( .lr | rotate ), tree: .tree} | r )
    end;
  r;

def parse_lr: gsub("L"; "0") | gsub("R"; "1") | split("") | map(tonumber);

def parse_tree: split("\n") | map( split(" = ") | {key: .[0], value: ( .[1][1:-1] | split(", ") )} ) | from_entries;

input | split("\n\n") | 
  (.[1] | rtrimstr("\n") | parse_tree) as $tree | 
  (.[0] | parse_lr) as $lr |
  [ 
    $tree | keys[] | select(endswith("A")) | {lr: $lr, tree: $tree, cur: . } | 
    {key: .cur, value: path_length(.cur | endswith("Z"))}
  ] | from_entries | 
  .AAA, lcm_all
