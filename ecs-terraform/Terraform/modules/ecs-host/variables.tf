variable "CONNECTOR_CLUSTER_NAME_ZONEA" {
  description = "cluster name"
}
variable "CONNECTOR_CLUSTER_NAME_ZONEB" {
  description = "cluster name"
}
variable "SERVICE_CLUSTER_NAME_ZONEA" {
  description = "cluster name"
}
variable "SERVICE_CLUSTER_NAME_ZONEB" {
  description = "cluster name"
}
variable "SERVICE_ECS_INSTANCE_TYPE" {
  description = "ecs instance type"
}
variable "SERVICE_ECS_INSTANCE_PROFILE" {
  description = "ecs instance profile"
}
variable "SERVICE-SG" {
  description = "security group ID"
}

variable "KEY_PAIR_NAME" {
  description = "instance key pair name"
}
variable "ECS_INSTANCE_IMAGE_ID" {
  description = "isntance ami id"
}
variable "SERVICE_INSTANCE_PUBLICIP_ASSOCIATION" {
  description = "associate public IP or not"
}
variable "SERVICE_ECS_INSTANCE_VOLUME_SIZE" {
  description = "instance disk space"
}

variable "SERVICE_ECS_INSTANCE_MIN_SIZE" {
  description = "autoscaling group min size"
}
variable "SERVICE_ECS_INSTANCE_MAX_SIZE" {
  description = "autoscaling group max size"
}
variable "SERVICE_ECS_INSTANCE_DESIRED_CAPACITY" {
  description = "autoscaling group desired capacity"
}
variable "SERVICE_ECS_INSTANCE_SUBNET_ZONEA" {
  description = "subnet id"
}
variable "SERVICE_ECS_INSTANCE_SUBNET_ZONEB" {
  description = "subnet id"
}
variable "ECS_INSTANCE_HEALTH_CHECK_TYPE" {
  description = "instance health check type for auto scaling group"
}
variable "STACK" {
  description = "stack name"
}
variable "STACKID" {
  description = "stack name"
}
variable "STACKTYPE" {
description = "stack name"
}