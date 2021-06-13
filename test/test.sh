#!/bin/bash

set -e -u

THIS_DIR=$(cd -P "$(dirname "$(readlink "${BASH_SOURCE[0]}" || echo "${BASH_SOURCE[0]}")")" && pwd)

RET=-1
NJK_OUT=$(${THIS_DIR}/../build/njk-* ${THIS_DIR}/test.njk)
RET=$?

if [[ $RET -ne 0 ]]; then
    exit $RET
fi

RET=-1
NODE_OUT=$(node ${THIS_DIR}/node/index.js ${THIS_DIR}/test.njk)
RET=$?

if [[ $RET -ne 0 ]]; then
    exit $RET
fi

if [[ "$NJK_OUT" == "$NODE_OUT" ]]; then
    echo "OK"
else
    echo "ERROR"
    diff -u <(echo "$NJK_OUT") <(echo "$NODE_OUT")
    exit 1
fi
