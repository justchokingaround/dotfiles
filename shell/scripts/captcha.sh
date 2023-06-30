#!/bin/sh

key=$(curl -s "https://readcomiconline.li/Special/AreYouHuman"|sed -nE "s@.*'sitekey': '([^']*)'.*@\1@p")
co=$(printf "https://readcomiconline.li:443"|base64)

captcha_token=$(curl -s "https://www.google.com/recaptcha/api2/anchor?k=${key}&co=${co}"|
	sed -nE 's@.*id="recaptcha-token" value="([^"]*)".*@\1@p')
