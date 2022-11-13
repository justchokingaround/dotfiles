#!/bin/sh

nth() {
  stdin=$(cat)
  line=$(echo "$stdin" | awk '{ print NR, $1 }' | tofi | cut -d\  -f1)
  echo "$stdin"| sed "${line}q;d"
}

curl -s "https://en.wikipedia.org/wiki/C"|sed -nE "s@.*img alt=\"([^\"]+)\" src=\"([^\"]*)\".*@\1\t\2@p" | nth | cut -f2
