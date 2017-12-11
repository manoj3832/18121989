#Security groups configurations allowing incoming traffic

#security group to allow ssl connections

resource "aws_security_group" "ssl" {
  vpc_id = "${var.VPC_ID}"
  name = "${var.STACK}-HTTPS-SG"
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.STACK}-HTTPS-SG"
    Description = "${var.STACK} HTTPS  traffic firewall rules"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}


resource "aws_security_group" "postgresql" {
  vpc_id = "${var.VPC_ID}"
  name = "${var.STACK}-POSTGRESQL-SG"
  ingress {
    from_port = "5432"
    to_port = "5432"
    protocol = "tcp"
    security_groups = ["${aws_security_group.docker.id}"]
  }
  ingress {
    from_port = "5432"
    to_port = "5432"
    protocol = "tcp"
    security_groups = ["${aws_security_group.admin.id}"]
  }
  ingress {
    from_port = "5432"
    to_port = "5432"
    protocol = "tcp"
    cidr_blocks = ["194.161.216.0/22"]
  }

  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "${var.STACK}-POSTGRESQL-SG"
    Description = "${var.STACK} RDS ACCESS FIREWALL RULES"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_security_group" "docker" {
  vpc_id = "${var.VPC_ID}"
  name = "${var.STACK}-CONTAINER-SG"
  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    security_groups = ["${aws_security_group.ssl.id}"]
  }
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    security_groups = ["${aws_security_group.admin.id}"]
  }

  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "${var.STACK}-CONTAINER-SG"
    Description = "${var.STACK} services and connectors access firewall rules"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
resource "aws_security_group" "rabbit" {
  vpc_id = "${var.VPC_ID}"
  name = "${var.STACK}-MESSAGE-QUEUE-SG"
  ingress {
    from_port = "5672"
    to_port = "5672"
    protocol = "tcp"
    security_groups = ["${aws_security_group.docker.id}"]
  }
  ingress {
    from_port = "15672"
    to_port = "15672"
    protocol = "tcp"
    security_groups = ["${aws_security_group.docker.id}"]
  }
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    security_groups = ["${aws_security_group.admin.id}"]
  }
  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "${var.STACK}-MESSAGE-QUEUE-SG"
    Description = "${var.STACK} message queue access firewall rules"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_security_group" "admin" {
  vpc_id = "${var.VPC_ID}"
  name = "${var.STACK}-ADMIN-SG"


  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["194.161.216.0/22"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "${var.STACK}-ADMIN-SG"
    Description = "${var.STACK} adminserver access  firewall rules"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
