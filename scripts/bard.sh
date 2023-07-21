#!/bin/sh

. "$HOME/dox/credentials/secret_envs"
query=$(printf "%s" "$*" | tr ' ' '+')

SNlM0e=$(curl -sL "https://bard.google.com/" -H "cookie: __Secure-3PSID=${bard_cookie}" | sed -nE "s@.*SNlM0e\":\"([^\"]*)\".*@\1@p")

response=$(curl -s -X POST "https://bard.google.com/_/BardChatUi/data/assistant.lamda.BardFrontendService/StreamGenerate?_reqid=182761&bl=boq_assistant-bard-web-server_20230510.09_p1&rt=c" \
    -H "cookie: __Secure-3PSID=$bard_cookie" \
    -d "f.req=[null,\"[[\\\"${query}\\\"],null,[\\\"\\\",\\\"\\\",\\\"\\\"]]\"]&at=${SNlM0e}" |
    tail -n+4 | tr '[]' '\n' | sed -n '/rc_/{n;p;}' | head -1 | sed -e 's/\\"/"/g' -e 's/^"//' -e 's/"$//')

echo "$response"
