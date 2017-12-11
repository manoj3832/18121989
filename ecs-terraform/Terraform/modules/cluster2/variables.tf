variable "CONNECTOR_CLUSTER_NAME_ZONEB" {
  description = "Name of ECS cluster"
}
variable "SERVICE_CLUSTER_NAME_ZONEB" {
  description = "Name of ECS cluster"
}

variable "ECS_SERVICE_ROLE" {
  description = "ECS service role arn"
}
variable "TARGET_GROUP_PORT" {
  description = "service load balancer port"
}

variable "SERVICE_TARGET_GROUP_PORT" {
  description = "service load balancer port"
}

variable "ECS_DESIRED_COUNT" {
  description = "ecs service desired task count"
}
variable "ECS_MINIMUM_HEALTH_PERCENTAGE" {
  description = "ecs service deployment minimum health percentage"
}

variable "STACK" {
  description = "stack name"
}

#==============================================
variable "AUTHENTICATION-FRONTEND-TG" {
  description = "Target Group Name"
}
variable "SYSTEM-MANAGER-FRONTEND-TG" {
  description = "Target Group Name"
}
variable "CLIENT-MANAGEMENT-FRONTEND-TG" {
  description = "Target Group Name"
}
#..........................................
variable "AUTHENTICATION-SERVICE-TG" {
  description = "Target Group Name"
}

variable "AUTHORIZATION-SERVICE-TG" {
  description = "Target Group Name"
}

variable "BUSINESS-ENTITY-SERVICE-TG" {
  description = "Target Group Name"
}

variable "IDENTITY-SERVICE-TG" {
  description = "Target Group Name"
}

variable "NOTIFICATION-SERVICE-TG" {
  description = "Target Group Name"
}

variable "SYSTEM-SERVICE-TG" {
  description = "Target Group Name"
}
#....................................
variable "AUTHENTICATION-CONNECTOR-TG" {
  description = "Target Group Name"
}
variable "CLIENT-MANAGEMENT-CONNECTOR-TG" {
  description = "Target Group Name"
}
variable "SYSTEM-SERVICES-CONNECTOR-TG" {
  description = "Target Group Name"
}
variable "CONFIGURATION-SERVICES-CONNECTOR-TG" {
  description = "Target Group Name"
}
variable "ADMINISTRATION-CONNECTOR-TG" {
  description = "Target Group Name"
}
#===================================================