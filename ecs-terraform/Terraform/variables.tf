#
# COMMON VARIABLES
#

variable "AWS_REGION" {
  description = "aws region"
}
variable "STACK" {
  description = "name of your STACK"
}

variable "STACKID" {
  description = "STACK id"
}

variable "STACKTYPE" {
  description = "STACK type"
}

variable "STACKVERSION" {
  description = "STACKID"
}
##
## VPC VARIABLES CONFIGURATIIONS
##
variable "VPC_CIDR" {
  description = "vpc cidr range"
}

variable "PUBLIC_SUBNET_ZONEA_CIDR" {
  description = "public subnet cidr range"
}
variable "PUBLIC_SUBNET_ZONEB_CIDR" {
  description = "public subnet cidr range"
}

variable "AVAILABLITY_ZONE_A" {
  description = "availablity zone for public region"
}
variable "AVAILABLITY_ZONE_B" {
  description = "availablity zone for public region"
}

variable "PRIVATE_SUBNET_ZONEA_CIDR" {
  description = "private subnet cidr range"
}
variable "PRIVATE_SUBNET_ZONEB_CIDR" {
  description = "private subnet cidr range"
}



##################################################################
##
## ALB VARIABLES CONFIGURATIONS
##
variable "TARGET_GROUP_PROTOCOL" {
  description = "protocol for target group"
}

variable "TARGET_GROUP_PORT" {
  description = "target group listner port from alb"
}
variable "TARGET_GROUP_HEALTH_CHECK_INTERVAL" {
  description = "interval between two consecutive healtcheck"
}
variable "TARGET_GROUP_HEALTH_CHECK_TIMEOUT" {
  description = "healtcheck time out"
}
variable "TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD" {
  description = "healthy threshold percentage"
}
variable "TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD" {
  description = "unhealthy threshold"
}
variable "HEALTHCHECK_PATH" {
  description = "target group instance healthcheck path"
}
variable "SERVICE_TARGET_GROUP_PORT" {
  description = "Target Group Port for services "
}
variable "ALB_LISTNER_PORT" {
  description = "listner port for alb"
}
variable "ALB_LISTNER_PROTOCOL" {
  description = "listner protocol for alb"
}
variable "ALB_LISTNER_SSL_POLICY_NAME" {
  description = "AWS SSL policy name"
}
variable "ALB_CERTIFICATE_ARN" {
  description = "aws certificate manager arn"
}
##########################################################
##
## RDS VARIABLE CONFIGURATIONS
##

variable "DB_ALLOCATED_STORAGE" {
  description = "Storage size in GB"
}

variable "DB_STORAGE_TYPE" {
  description = "type of diskstorage"
}

variable "DB_ENGINE" {
  description = "Engine type, example values mysql, postgres"
}

variable "DB_ENGINE_VERSION" {
  description = "Engine version"
}

variable "DB_INSTANCE_CLASS" {
  description = "Instance class"
}

variable "DB_USERNAME" {
  description = "User name"
}

variable "DB_PASSWORD" {
  description = "password shoud be secure and should not be visible"
}

variable "DB_NAME" {
  description = "password shoud be secure and should not be visible"

}

variable "DB_PUBLIC_ACCESS" {
  description = "publicly accessibity for DB"
}

variable "DB_IDENTIFIER" {
  description = "db identifier"
}

variable "DB_ALLOW_MINOR_VERSION_UPGRADE" {
  description = "allows minor upgrade or not"
}

variable "DB_ALLOW_MAJOR_VERSION_UPGRADE" {
  default = "allow major upgrade or not"
}

variable "RDS_BACKUP_RETENTION_PERIOD" {
  description = "rds backup retention period"
}
variable "RDS_BACKUP_WINDOW" {
  description = "rds backup wondow"
}
variable "RDS_MULTI_AZ" {
  description = "allow RDS in multiple AZ or not"
}

##
## MQ variables
##

variable "MQ_INSTANCE_TYPE" {
  description = "Ec2 Instance Type"
}

variable "KEYPAIR_NAME" {
  description = "instance key pair name"
}
variable "MQ_VOLUME_TYPE" {
  description = "disk volume type"
}

variable "MQ_VOLUME_SIZE" {
  description = "disk volume size"
}

variable "MQ_MAX_SIZE" {
  description = "instance max count"
}
variable "MQ_MIN_SIZE" {
  description = "instance min count"
}
variable "MQ_DESIRED_CAPACITY" {
  description = "instance desired capacity"
}
variable "HEALTH_CHECK_GRACE_PERIOD" {
  description = "HEALTH CHECK GRACE PERIOD"
}
variable "HEALTH_CHECK_TYPE" {
  description = "HEALTH CHECK TYPE"
}
##
## ECS VARIABLE CONFIGURATION
##

variable "CONNECTOR_CLUSTER_NAME_ZONEA" {
  description = "Name of ECS cluster"
}
variable "SERVICE_CLUSTER_NAME_ZONEA" {
  description = "Name of ECS cluster"
}

variable "CONNECTOR_CLUSTER_NAME_ZONEB" {
  description = "Name of ECS cluster"
}
variable "SERVICE_CLUSTER_NAME_ZONEB" {
  description = "Name of ECS cluster"
}

variable "ECS_DESIRED_COUNT" {
  description = "ecs service desired task count"
}
variable "ECS_MINIMUM_HEALTH_PERCENTAGE" {
  description = "ecs service deployment minimum health percentage"
}

##
## ECS Host
##

variable "SERVICE_ECS_INSTANCE_TYPE" {
  description = "ecs instance type"
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
variable "ECS_INSTANCE_HEALTH_CHECK_TYPE" {
  description = "instance health check type for auto scaling group"
}
