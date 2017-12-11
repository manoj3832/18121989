#!/bin/bash -ex

echo Begin: user-data

echo Begin: update and install packages
yum update -y
yum install -y aws-cli jq
echo End: update and install packages


echo Begin: start ECS
cluster="${cluster_name}"
auth_type="dockercfg"
auth_data='{"https://dtr.aa.st":{"auth":"Y2ktc3lzdGVtc2VydmljZXM6U3lzdGVtTWFuYWdlckBMMGdpOQ==","email":"#ASSAABLOYAB-ST-MSFServices@assaabloy.com"}}'
echo ECS_CLUSTER=$cluster >> /etc/ecs/ecs.config
echo ECS_ENGINE_AUTH_TYPE=$auth_type >> /etc/ecs/ecs.config
echo ECS_ENGINE_AUTH_DATA=$auth_data >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS='["json-file","syslog","awslogs","gelf"]' >> /etc/ecs/ecs.config
start ecs
until $(curl --output /dev/null --silent --head --fail http://localhost:51678/v1/metadata); do
  printf '.'
  sleep 1
done
echo End: start ECS

echo End: user-data

