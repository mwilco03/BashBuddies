#!/usr/bin/env bash

#      $1 :   number (of characters)
# returns :   string of random characters

rando() { shuf -en $1 {{a..z},{0..9},{A..Z}} | tr -d $'\n' ; }
export -f rando
# shuf -en $1 {{a..z},{0..9},{A..Z}} | tr -d $'\n'
