#!/usr/bin/env bash

echo ECS_CLUSTER=integration >> /etc/ecs/ecs.config

yum install -y docker

docker_config=/etc/sysconfig/docker
path=/etc/profile.d/docker_vars.sh

#enabling dockerd @ sock
sudo chmod 766 $docker_config
echo "OPTIONS='--selinux-enabled -H unix:///var/run/docker.sock -H tcp://0.0.0.0:4243'" >> "$docker_config"
sudo service docker restart

#enabling DOCKER_HOST
sudo touch $path && sudo chmod 766 $path
echo 'export DOCKER_HOST=tcp://localhost:4243' >> "$path"
echo 'export PATH=$PATH:$DOCKER_HOST/bin' >> "$path"

## docker logs path
sudo mkdir /dockerlogs && sudo chmod 755 /dockerlogs

