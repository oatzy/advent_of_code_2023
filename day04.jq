#!/usr/bin/env -S jq -Rnf

[inputs | split(": ")[1] | [split(" ") | map(try tonumber) | group_by(.)[] | select(length|.>1)] | length - 1 | exp2 | floor] | add
