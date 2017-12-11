#!/bin/bash -ex

echo Begin: user-data

echo Begin: update and install packages
#####################################################
sudo yum install -y erlang

sudo rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc

sudo wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.5.6/rabbitmq-server-3.5.6-1.noarch.rpm

sudo rpm -Uvh rabbitmq-server-3.5.6-1.noarch.rpm

sudo chkconfig rabbitmq-server on

sudo service rabbitmq-server start
# Enable managament plugin
sudo rabbitmq-plugins enable rabbitmq_management

#Enable remote access
sudo echo '[{rabbit, [{loopback_users, []}]}].' > /etc/rabbitmq/rabbitmq.config
#.................................

sudo service rabbitmq-server restart

#################################################
echo End: update and install packages

echo End: user-data

