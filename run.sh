#!/bin/bash
set -x
echo "Starting reports run"

echo "Copying sources from $SCRIPT_SOURCES"
mkdir sources
aws s3 cp --recursive $SCRIPT_SOURCES ./sources

if [[ ${AWS_EXECUTION_ENV} == "AWS_ECS_FARGATE" ]]
then
    echo "Fetching Container Credentials"
    declare -x CRED=$(curl http://169.254.170.2${AWS_CONTAINER_CREDENTIALS_RELATIVE_URI})
    declare -x AWS_ACCESS_KEY_ID=$(echo $CRED | sed -n 's|.*"AccessKeyId":"\([^"]*\)".*|\1|p')
    declare -x AWS_SECRET_ACCESS_KEY=$(echo $CRED | sed -n 's|.*"SecretAccessKey":"\([^"]*\)".*|\1|p')
    declare -x AWS_SESSION_TOKEN=$(echo $CRED | sed -n 's|.*"Token":"\([^"]*\)".*|\1|p')
fi

echo "Running R script $R_SCRIPT_FILE_NAME"
Rscript ./sources/$R_SCRIPT_FILE_NAME
echo "Completed R script, $R_SCRIPT_FILE_NAME"

if [[ ${POST_COPY_TO_DESTINATION} == "YES" ]]
then
    echo "Copying output matching \"${OUTPUT_PREFIX}*\" to $REPORT_DESTINATION"
    aws s3 cp --recursive ./ $REPORT_ARCHIVE_DESTINATION --exclude "*" --include "${OUTPUT_PREFIX}*" 
    aws s3 cp --recursive ./ $REPORT_DESTINATION --exclude "*" --include "${OUTPUT_PREFIX}*" 
else
    echo "R script $R_SCRIPT_FILE_NAME is responsible for copying output"
fi
echo "Completed reports run"
