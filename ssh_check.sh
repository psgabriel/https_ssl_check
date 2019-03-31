#!/bin/bash
SERVER=$1
PORT=$2

if [ -z "$PORT" ]; then
    PORT=443;
else
    PORT=$PORT;
fi


ORIGINAL_DATE=$(openssl s_client -connect ${SERVER}:${PORT} 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep notAfter | cut -d'=' -f2)
EXPIRE_IN_SECS=$(date -d "${ORIGINAL_DATE}" +%s)
EXPIRE_TIME=$(( ${EXPIRE_IN_SECS} - `date +%s` ))

if test $EXPIRE_TIME -lt 0; then
    RETVAL=0
else
    RETVAL=$(( ${EXPIRE_TIME} / 24 / 3600 ))
fi

echo ${RETVAL}