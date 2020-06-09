#!/usr/bin/env bash

TIMESTAMP=`date +"%Y%m%d"`

for db in ${_SQL_DATABASES}
do
    echo "gcloud sql export sql ${INSTANCE_NAME} gs://${_GS_BUCKET_NAME}${_GS_GZ_PATH}/${db}.${TIMESTAMP}.gz --database=${db}"
    gcloud sql export sql ${INSTANCE_NAME} gs://${_GS_BUCKET_NAME}${_GS_GZ_PATH}/${db}.${TIMESTAMP}.gz --database=${db}
done