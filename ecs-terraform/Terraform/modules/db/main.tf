###
#RDS postgresql configurations
####

resource "aws_db_instance" "db" {
  allocated_storage    = "${var.DB_ALLOCATED_STORAGE}"
  storage_type         = "${var.DB_STORAGE_TYPE}"
  engine               = "${var.DB_ENGINE}"
  engine_version       = "${var.DB_ENGINE_VERSION}"
  instance_class       = "${var.DB_INSTANCE_CLASS}"
  name                 = "${var.DB_NAME}"
  identifier           = "${var.DB_IDENTIFIER}"
  username             = "${var.DB_USERNAME}"
  password             = "${var.DB_PASSWORD}"
  db_subnet_group_name = "${aws_db_subnet_group.dbsubnet.id}"
  vpc_security_group_ids = ["${var.DB_SG}"]
  publicly_accessible = "${var.DB_PUBLIC_ACCESS}"
  auto_minor_version_upgrade = "${var.DB_ALLOW_MINOR_VERSION_UPGRADE}"
  allow_major_version_upgrade = "${var.DB_ALLOW_MAJOR_VERSION_UPGRADE}"
  backup_retention_period = "${var.RDS_BACKUP_RETENTION_PERIOD}"
  backup_window = "${var.RDS_BACKUP_WINDOW}"
  multi_az = "${var.RDS_MULTI_AZ}"
  publicly_accessible = "${var.DB_PUBLIC_ACCESS}"
  tags {
    Name = "${var.STACK} DB"
    Description = "${var.STACK} ${var.STACKID} ${var.DB_ENGINE} RDS INSTANCE"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.DB_ENGINE_VERSION}"
  }


}
resource "aws_db_subnet_group" "dbsubnet" {
  name        = "${var.STACK} db subnet group"
  description = "VPC subnet group for databse"
  subnet_ids  = ["${split(",", var.RDS_SUBNET_ID)}"]
}
