#!/usr/bin/env -S jq -Rnf

def firstd: . | capture("[a-z]*(?<a>[0-9]).*") | .a | tonumber;
def lastd: . | capture(".*(?<a>[0-9])[a-z]*") | .a | tonumber;

[inputs] | map(10 * firstd + lastd) | add
