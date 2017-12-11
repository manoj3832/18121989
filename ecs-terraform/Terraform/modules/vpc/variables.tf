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