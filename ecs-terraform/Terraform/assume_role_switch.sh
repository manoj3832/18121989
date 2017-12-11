#!/usr/bin/env bash

yum install -y jq

CMD="$@"
DEV_ACCOUNT_ID=860384218481

ASSUME_ROLE="arn:aws:iam::045420858749:role/ToolsCrossAccountRole"
ROLE_SESSION_NAME="tools_switch"
TMP_FILE=".temp_credentials"


aws sts assume-role --output json --role-arn ${ASSUME_ROLE} --role-session-name ${ROLE_SESSION_NAME} > ${TMP_FILE}

ACCESS_KEY=$(cat ${TMP_FILE} | jq -r ".Credentials.AccessKeyId")
SECRET_KEY=$(cat ${TMP_FILE} | jq -r ".Credentials.SecretAccessKey")
SESSION_TOKEN=$(cat ${TMP_FILE} | jq -r ".Credentials.SessionToken")
EXPIRATION=$(cat ${TMP_FILE} | jq -r ".Credentials.Expiration")

echo "Retrieved temp access key ${ACCESS_KEY} for role ${ASSUME_ROLE}. Key will expire at ${EXPIRATION}"

AWS_ACCESS_KEY_ID=${ACCESS_KEY} AWS_SECRET_ACCESS_KEY=${SECRET_KEY} AWS_SESSION_TOKEN=${SESSION_TOKEN} ${CMD}
