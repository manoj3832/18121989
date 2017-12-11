#!/usr/bin/env bash


### Installing rabbitMQ-Server latest


# Modify /etc/yum.repos.d/epel.repo. Under the section marked [epel], change enabled=0 to enabled=1.
sudo yum install -y erlang

sudo rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc

sudo wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.5.6/rabbitmq-server-3.5.6-1.noarch.rpm

sudo rpm -Uvh rabbitmq-server-3.5.6-1.noarch.rpm

sudo chkconfig rabbitmq-server on

sudo service rabbitmq-server start
# Enable managament plugin
sudo rabbitmq-plugins enable rabbitmq_management

sudo service rabbitmq-server restart



