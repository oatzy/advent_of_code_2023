#!/usr/bin/env -S jq -Rnsf

def rotate: .[1:] + [.[0]];

def path_length:
  def r:
    if .cur == "ZZZ" then 0 else
      .tree[.cur][.lr[0]] as $next |
      1 + ({cur: $next, lr: (.lr | rotate), tree: .tree} | r)
    end;
  r;

def parse_lr: gsub("L"; "0") | gsub("R"; "1") | split("") | map(tonumber);

def parse_tree: split("\n") | map( split(" = ") | {key: .[0], value: (.[1][1:-1] | split(", "))} ) | from_entries;

input | split("\n\n") | {lr: (.[0] | parse_lr), tree: (.[1] | rtrimstr("\n") | parse_tree), cur: "AAA" } | path_length
