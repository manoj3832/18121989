variable "VPC_ID" {
  description = "vpc is in which alb lives"
}
variable "ALB_SG" {
  description = "alb security group id"
}
variable "ALB_SUBNETS" {
  description = "ab subnets ids "
}
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

variable "STACK" {
  description = "STACK NAME"
}
variable "STACKID" {
  description = "STACK ID"
}
variable "STACKTYPE" {
  description = "STACK TYPE"
}
variable "STACKVERSION" {
  description = "STACK VERSION"
}