#!/usr/bin/env bash

## to use in the current session, simply define a function:
#rando() { shuf -en $1 {{a..z},{0..9},{A..Z}} | tr -d '\n' ; }

## if adding to an rc file, such as ~/.bash_aliases, don't forget to export the function:
#export -f rando

## otherwise, just use this script as is.
#      $1 :   number (of characters)
# returns :   string of random characters
shuf -en $1 {{a..z},{0..9},{A..Z}} | tr -d '\n'
