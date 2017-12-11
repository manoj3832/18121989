variable "DB_SG" {
  description = "Id of security group allowing internal traffic"
}

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

variable "RDS_SUBNET_ID" {
  description = "subnet ID "
}
variable "STACK" {
  description = "name of your stack"
}

variable "STACKID" {
  description = "stack id"
}

variable "STACKTYPE" {
  description = "stack type"
}

variable "STACKVERSION" {
  description = "stack version"
}


