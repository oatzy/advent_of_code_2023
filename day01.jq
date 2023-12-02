#!/usr/bin/env -S jq -Rnf

def sub_numbers: ( . | 
    gsub("one"; "one1one") | 
    gsub("two"; "two2two") | 
    gsub("three"; "three3three") | 
    gsub("four"; "four4four") | 
    gsub("five"; "five5five") | 
    gsub("six"; "six6six") | 
    gsub("seven"; "seven7seven") | 
    gsub("eight"; "eight8eight") | 
    gsub("nine"; "nine9nine")
);

def firstd: . | capture("[a-z]*(?<a>[0-9]).*") | .a | tonumber;
def lastd: . | capture(".*(?<a>[0-9])[a-z]*") | .a | tonumber;

[inputs | [., sub_numbers]] | transpose | map( map(10 * firstd + lastd) | add )
