# Terraform Generic Modules which are interconnected and
# can be deployed independently.

#==================================================
#
# Configure the AWS Provider
#

provider "aws" {
  region = "AWSREGION"

}

terraform {

  backend "s3" {
    bucket = "BUCKET_NAME"
    key    = "terraform.tfstate"
    region = "AWSREGION"
  }
}


#=====================================================
#
# vpc configuration module
#
module "vpc" {
  source = "./modules/vpc"

  VPC_CIDR = "${var.VPC_CIDR}"
  AVAILABLITY_ZONE_A = "${var.AVAILABLITY_ZONE_A}"
  AVAILABLITY_ZONE_B = "${var.AVAILABLITY_ZONE_B}"
  PUBLIC_SUBNET_ZONEA_CIDR = "${var.PUBLIC_SUBNET_ZONEA_CIDR}"
  PUBLIC_SUBNET_ZONEB_CIDR = "${var.PUBLIC_SUBNET_ZONEB_CIDR}"
  PRIVATE_SUBNET_ZONEA_CIDR = "${var.PRIVATE_SUBNET_ZONEA_CIDR}"
  PRIVATE_SUBNET_ZONEB_CIDR = "${var.PRIVATE_SUBNET_ZONEB_CIDR}"
  STACK = "${var.STACK}"
  STACKID = "${var.STACKID}"
  STACKTYPE = "${var.STACKTYPE}"
  STACKVERSION = "${var.STACKVERSION}"
}
#======================================================

#
# Security Groups configuration module
#
module "firewall" {
  source = "./modules/firewall"

  VPC_ID = "${module.vpc.vpc_id}"
  STACK = "${var.STACK}"
  STACKID = "${var.STACKID}"
  STACKTYPE = "${var.STACKTYPE}"
  STACKVERSION = "${var.STACKVERSION}"
}
#=======================================================
#
# Application Load Balancer configuration module
#

module "alb" {
  source = "./modules/alb"

  VPC_ID = "${module.vpc.vpc_id}"

  ALB_CERTIFICATE_ARN = "${var.ALB_CERTIFICATE_ARN}"
  ALB_LISTNER_SSL_POLICY_NAME = "${var.ALB_LISTNER_SSL_POLICY_NAME}"
  ALB_LISTNER_PORT = "${var.ALB_LISTNER_PORT}"
  ALB_LISTNER_PROTOCOL = "${var.ALB_LISTNER_PROTOCOL}"
  ALB_SG = "${module.firewall.ssl_sg_id}"
  ALB_SUBNETS = "${module.vpc.public_subnet_ids}"

  TARGET_GROUP_PORT = "${var.TARGET_GROUP_PORT}"
  TARGET_GROUP_PROTOCOL = "${var.TARGET_GROUP_PROTOCOL}"
  SERVICE_TARGET_GROUP_PORT = "${var.SERVICE_TARGET_GROUP_PORT}"
  TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
  TARGET_GROUP_HEALTH_CHECK_INTERVAL = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
  TARGET_GROUP_HEALTH_CHECK_TIMEOUT = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
  TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
  HEALTHCHECK_PATH = "${var.HEALTHCHECK_PATH}"

  STACK = "${var.STACK}"
  STACKID = "${var.STACKID}"
  STACKTYPE = "${var.STACKTYPE}"
  STACKVERSION = "${var.STACKVERSION}"
}

module "db" {
  source = "./modules/db"

  DB_ENGINE = "${var.DB_ENGINE}"
  DB_ENGINE_VERSION = "${var.DB_ENGINE_VERSION}"
  DB_IDENTIFIER = "${var.DB_IDENTIFIER}"
  DB_NAME = "${var.DB_NAME}"
  DB_USERNAME = "${var.DB_USERNAME}"
  DB_PASSWORD = "${var.DB_PASSWORD}"
  DB_ALLOCATED_STORAGE = "${var.DB_ALLOCATED_STORAGE}"
  DB_STORAGE_TYPE = "${var.DB_STORAGE_TYPE}"
  DB_INSTANCE_CLASS = "${var.DB_INSTANCE_CLASS}"
  DB_SG = "${module.firewall.postgresql_sg_id}"
  DB_PUBLIC_ACCESS = "${var.DB_PUBLIC_ACCESS}"
  DB_ALLOW_MINOR_VERSION_UPGRADE = "${var.DB_ALLOW_MINOR_VERSION_UPGRADE}"
  DB_ALLOW_MAJOR_VERSION_UPGRADE = "${var.DB_ALLOW_MAJOR_VERSION_UPGRADE}"
  RDS_SUBNET_ID = "${module.vpc.private_subnet_ids}"
  RDS_MULTI_AZ = "${var.RDS_MULTI_AZ}"
  RDS_BACKUP_RETENTION_PERIOD = "${var.RDS_BACKUP_RETENTION_PERIOD}"
  RDS_BACKUP_WINDOW = "${var.RDS_BACKUP_WINDOW}"

  STACK = "${var.STACK}"
  STACKID = "${var.STACKID}"
  STACKTYPE = "${var.STACKTYPE}"
  STACKVERSION = "${var.STACKVERSION}"
}

module "rabbit" {
  source = "./modules/rabbit"

  KEYPAIR_NAME = "${var.KEYPAIR_NAME}"
  MQ_DESIRED_CAPACITY = "${var.MQ_DESIRED_CAPACITY}"
  MQ_MIN_SIZE = "${var.MQ_MIN_SIZE}"
  MQ_MAX_SIZE = "${var.MQ_MAX_SIZE}"
  MQ_PRIVATE_SUBNET_ZONEA = "${module.vpc.private_subnet_zonea}"
  MQ_PRIVATE_SUBNET_ZONEB = "${module.vpc.private_subnet_zoneb}"
  MQ_SG = "${module.firewall.mq_sg_id}"
  MQ_INSTANCE_TYPE = "${var.MQ_INSTANCE_TYPE}"
  MQ_VOLUME_SIZE = "${var.MQ_VOLUME_SIZE}"
  MQ_VOLUME_TYPE = "${var.MQ_VOLUME_TYPE}"
  HEALTH_CHECK_GRACE_PERIOD = "${var.HEALTH_CHECK_GRACE_PERIOD}"
  HEALTH_CHECK_TYPE = "${var.HEALTH_CHECK_TYPE}"

  STACK = "${var.STACK}"
}

module "policy" {
  source = "./modules/policy"

  STACK = "${var.STACK}"
}

module "cluster1" {
  source = "./modules/cluster1"

  CONNECTOR_CLUSTER_NAME_ZONEA = "${var.CONNECTOR_CLUSTER_NAME_ZONEA}"
  SERVICE_CLUSTER_NAME_ZONEA = "${var.SERVICE_CLUSTER_NAME_ZONEA}"

  AUTHENTICATION-FRONTEND-TG = "${module.alb.authentication-frontend}"
  SYSTEM-MANAGER-FRONTEND-TG = "${module.alb.system-manager-frontend}"
  CLIENT-MANAGEMENT-FRONTEND-TG = "${module.alb.client-management-frontend}"

  ADMINISTRATION-CONNECTOR-TG = "${module.alb.administration-connector}"
  AUTHENTICATION-CONNECTOR-TG = "${module.alb.authentication-connector}"
  CLIENT-MANAGEMENT-CONNECTOR-TG = "${module.alb.client-management-connector}"
  SYSTEM-SERVICES-CONNECTOR-TG = "${module.alb.system-services-connector}"
  CONFIGURATION-SERVICES-CONNECTOR-TG = "${module.alb.configuration-services-connector}"

  AUTHENTICATION-SERVICE-TG = "${module.alb.authentication-service}"
  IDENTITY-SERVICE-TG = "${module.alb.identity-service}"
  SYSTEM-SERVICE-TG = "${module.alb.system-service}"
  BUSINESS-ENTITY-SERVICE-TG = "${module.alb.business-entity-service}"
  NOTIFICATION-SERVICE-TG = "${module.alb.notification-service}"
  AUTHORIZATION-SERVICE-TG = "${module.alb.authorization-service}"

  ECS_SERVICE_ROLE = "${module.policy.ecs_service_role_arn}"
  TARGET_GROUP_PORT = "${var.TARGET_GROUP_PORT}"
  SERVICE_TARGET_GROUP_PORT = "${var.SERVICE_TARGET_GROUP_PORT}"
  ECS_DESIRED_COUNT = "${var.ECS_DESIRED_COUNT}"
  ECS_MINIMUM_HEALTH_PERCENTAGE = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  STACK = "${var.STACK}"
}

module "cluster2" {
  source = "./modules/cluster2"

  CONNECTOR_CLUSTER_NAME_ZONEB = "${var.CONNECTOR_CLUSTER_NAME_ZONEB}"
  SERVICE_CLUSTER_NAME_ZONEB = "${var.SERVICE_CLUSTER_NAME_ZONEB}"

  AUTHENTICATION-FRONTEND-TG = "${module.alb.authentication-frontend}"
  SYSTEM-MANAGER-FRONTEND-TG = "${module.alb.system-manager-frontend}"
  CLIENT-MANAGEMENT-FRONTEND-TG = "${module.alb.client-management-frontend}"

  ADMINISTRATION-CONNECTOR-TG = "${module.alb.administration-connector}"
  AUTHENTICATION-CONNECTOR-TG = "${module.alb.authentication-connector}"
  CLIENT-MANAGEMENT-CONNECTOR-TG = "${module.alb.client-management-connector}"
  SYSTEM-SERVICES-CONNECTOR-TG = "${module.alb.system-services-connector}"
  CONFIGURATION-SERVICES-CONNECTOR-TG = "${module.alb.configuration-services-connector}"

  AUTHENTICATION-SERVICE-TG = "${module.alb.authentication-service}"
  IDENTITY-SERVICE-TG = "${module.alb.identity-service}"
  SYSTEM-SERVICE-TG = "${module.alb.system-service}"
  BUSINESS-ENTITY-SERVICE-TG = "${module.alb.business-entity-service}"
  NOTIFICATION-SERVICE-TG = "${module.alb.notification-service}"
  AUTHORIZATION-SERVICE-TG = "${module.alb.authorization-service}"

  ECS_SERVICE_ROLE = "${module.policy.ecs_service_role_arn}"
  TARGET_GROUP_PORT = "${var.TARGET_GROUP_PORT}"
  SERVICE_TARGET_GROUP_PORT = "${var.SERVICE_TARGET_GROUP_PORT}"
  ECS_DESIRED_COUNT = "${var.ECS_DESIRED_COUNT}"
  ECS_MINIMUM_HEALTH_PERCENTAGE = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  STACK = "${var.STACK}"
}

module "ecs-host" {
  source = "./modules/ecs-host"

  SERVICE_CLUSTER_NAME_ZONEA = "${var.SERVICE_CLUSTER_NAME_ZONEA}"
  SERVICE_CLUSTER_NAME_ZONEB = "${var.SERVICE_CLUSTER_NAME_ZONEB}"
  CONNECTOR_CLUSTER_NAME_ZONEA = "${var.CONNECTOR_CLUSTER_NAME_ZONEA}"
  CONNECTOR_CLUSTER_NAME_ZONEB = "${var.CONNECTOR_CLUSTER_NAME_ZONEB}"
  SERVICE-SG = "${module.firewall.docker_sg_id}"
  SERVICE_ECS_INSTANCE_SUBNET_ZONEA = "${module.vpc.private_subnet_zonea}"
  SERVICE_ECS_INSTANCE_SUBNET_ZONEB = "${module.vpc.private_subnet_zoneb}"
  SERVICE_ECS_INSTANCE_DESIRED_CAPACITY = "${var.SERVICE_ECS_INSTANCE_DESIRED_CAPACITY}"
  SERVICE_ECS_INSTANCE_MIN_SIZE = "${var.SERVICE_ECS_INSTANCE_MIN_SIZE}"
  SERVICE_ECS_INSTANCE_MAX_SIZE = "${var.SERVICE_ECS_INSTANCE_MAX_SIZE}"
  SERVICE_ECS_INSTANCE_PROFILE = "${module.policy.ecs_instance_profile_name}"
  SERVICE_ECS_INSTANCE_TYPE = "${var.SERVICE_ECS_INSTANCE_TYPE}"
  SERVICE_ECS_INSTANCE_VOLUME_SIZE = "${var.SERVICE_ECS_INSTANCE_VOLUME_SIZE}"
  SERVICE_INSTANCE_PUBLICIP_ASSOCIATION = "${var.SERVICE_INSTANCE_PUBLICIP_ASSOCIATION}"
  ECS_INSTANCE_HEALTH_CHECK_TYPE = "${var.ECS_INSTANCE_HEALTH_CHECK_TYPE}"
  ECS_INSTANCE_IMAGE_ID = "${var.ECS_INSTANCE_IMAGE_ID}"
  KEY_PAIR_NAME = "${var.KEYPAIR_NAME}"
  STACK = "${var.STACK}"
  STACKID = "${var.STACKID}"
  STACKTYPE = "${var.STACKTYPE}"

}