#!/usr/bin/env -S jq -Rnf

def hash: explode | reduce .[] as $i (0; 17 * (. + $i) % 256);

input | rtrimstr("\n") | split(",") | map(hash) | add
