variable "STACK" {
  description = "stack name"
}

variable "MQ_INSTANCE_TYPE" {
  description = "Ec2 Instance Type"
}

variable "MQ_SG" {
  description = "security group"
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

variable "MQ_PRIVATE_SUBNET_ZONEA" {
  description = "subnet id"
}

variable "MQ_PRIVATE_SUBNET_ZONEB" {
  description = "subnet id"
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