#!/usr/bin/env bash

cd /usr/src/app/
CLIENT_EMAIL=`python3 -c "import sys, json; f = open('/usr/src/app/service-account.json', 'r'); print(json.load(f)['client_email'])"`
INSTANCE_NAME=`echo ${_SQL_INSTANCE_NAME##*:}`
PROJECT_ID=`echo ${_SQL_INSTANCE_NAME} | cut -d ":" -f1`

gcloud auth activate-service-account $CLIENT_EMAIL --key-file=/usr/src/app/service-account.json
gcloud config set project ${PROJECT_ID}

echo "Using" `gcloud sql instances describe $INSTANCE_NAME | grep "serviceAccountEmailAddress"`

export INSTANCE_NAME=$INSTANCE_NAME
export PROJECT_ID=$PROJECT_ID

exec "$@"