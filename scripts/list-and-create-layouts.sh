#!/usr/bin/env bash
set -euo pipefail
ZJ_LAYOUT_DIR=$(zellij setup --check \
    | grep "LAYOUT DIR" - \
    | grep -o '".*"' - | tr -d '"')

if [[ -d "${ZJ_LAYOUT_DIR}" ]];then
        ZJ_LAYOUT="$(fd --type file . "${ZJ_LAYOUT_DIR}" \
        | sed 's|.*/||' \
        | sk \
        || exit)"
    zellij --layout "${ZJ_LAYOUT}"
fi
