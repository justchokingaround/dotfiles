#!/bin/sh

#encoding characters
enc_char="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"

#creating table
table=$(printf "$enc_char" | sed 's/\(.\)/\1\n/g' | nl -v0 | tr '\t' ':' | tr -d ' ')

res=0 #setting result value to zero
id=$* #ID taken from arguments

#looping at every character
for key in $(printf "$id" | sed -e 's/\(.\)/\1\n/g');do 
    #finding that character value in table
    value=$(printf "$table" | sed -nE "s/([^:]*):$key/\1/p")
    #adding that value in result
    res=$((res*64+value))
done

printf "$res"
