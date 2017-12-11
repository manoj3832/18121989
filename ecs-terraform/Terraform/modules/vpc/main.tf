#main file for vpc infrastructrue automation
#a vpc with public-private subnets and NAT gateway with elastic IP

resource "aws_vpc" "vpc" {
  cidr_block = "${var.VPC_CIDR}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.STACK} VPC"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

# creating internet gateway for public subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.STACK} IG"
    Description ="${var.STACK} internet gateway for ${var.STACK} vpc public subnet"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

#elastic IP for NAT gateway
resource "aws_eip" "zonea" {
  vpc = true
}
resource "aws_eip" "zoneb" {
  vpc = true
}

#===========================================
#Public subnet configurations
resource "aws_subnet" "public_zonea" {
  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block = "${var.PUBLIC_SUBNET_ZONEA_CIDR}"
  availability_zone = "${var.AVAILABLITY_ZONE_A}"

  tags {
    Name = "${var.STACK} public subnet ${var.AVAILABLITY_ZONE_A}"
    Decription = "${var.STACK} vpc public subnet with direct access to internet gateway"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
resource "aws_subnet" "public_zoneb" {
  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block = "${var.PUBLIC_SUBNET_ZONEB_CIDR}"
  availability_zone = "${var.AVAILABLITY_ZONE_B}"

  tags {
    Name = "${var.STACK} public subnet ${var.AVAILABLITY_ZONE_B}"
    Decription = "${var.STACK} vpc public subnet with direct access to internet gateway"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

#===========================================
#route table for public subnet
resource "aws_route_table" "zonea" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_internet_gateway.ig.id}"
  }

  tags {
    Name = "${var.STACK} ${var.AVAILABLITY_ZONE_B} route table public"
    Description = "${var.STACK} vpc route table attached to internet gateway for public subnets"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_route_table" "zoneb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_internet_gateway.ig.id}"
  }

  tags {
    Name = "${var.STACK} ${var.AVAILABLITY_ZONE_B} route table public"
    Description = "${var.STACK} vpc route table attached to internet gateway for public subnets"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

#=============================================
# public route table association with public subnet
resource "aws_route_table_association" "zonea" {
  subnet_id = "${aws_subnet.public_zonea.id}"
  route_table_id = "${aws_route_table.zonea.id}"
}

resource "aws_route_table_association" "zoneb" {
  subnet_id = "${aws_subnet.public_zoneb.id}"
  route_table_id = "${aws_route_table.zoneb.id}"
}

#=============================================
# NAT gateway configurations
resource "aws_nat_gateway" "zonea" {
  allocation_id = "${aws_eip.zonea.id}"
  subnet_id = "${aws_subnet.public_zonea.id}"
  depends_on = ["aws_internet_gateway.ig"]
}
resource "aws_nat_gateway" "zoneb" {
  allocation_id = "${aws_eip.zoneb.id}"
  subnet_id = "${aws_subnet.public_zoneb.id}"
  depends_on = ["aws_internet_gateway.ig"]
}
#=============================================
#Private Subnets configurations
#
resource "aws_subnet" "private_zonea" {
  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block = "${var.PRIVATE_SUBNET_ZONEA_CIDR}"
  availability_zone = "${var.AVAILABLITY_ZONE_A}"

  tags {
    Name = "${var.STACK} private subnet ${var.AVAILABLITY_ZONE_A}"
    Decription = "${var.STACK} vpc public subnet with direct access to internet gateway"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_subnet" "private_zoneb" {
  vpc_id = "${aws_vpc.vpc.id}"

  cidr_block = "${var.PRIVATE_SUBNET_ZONEB_CIDR}"
  availability_zone = "${var.AVAILABLITY_ZONE_B}"

  tags {
    Name = "${var.STACK} private subnet ${var.AVAILABLITY_ZONE_B}"
    Decription = "${var.STACK} vpc public subnet with direct access to internet gateway"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
#================================================
resource "aws_route_table" "private_zonea" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${EIP_ZONEA}"
  }

  tags {
    Name = "${var.STACK} ${var.AVAILABLITY_ZONE_A} route table private"
    Description = "${var.STACK} private route table for private subnets"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_route_table" "private_zoneb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${EIP_ZONEB}"
  }

  tags {
    Name = "${var.STACK} ${var.AVAILABLITY_ZONE_B} route table private"
    Description = "${var.STACK} private route table for private subnets"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
#================================================
#priavte route tabe association
resource "aws_route_table_association" "private_zona" {
  subnet_id = "${aws_subnet.private_zonea.id}"
  route_table_id = "${aws_route_table.private_zonea.id}"
}

resource "aws_route_table_association" "private_rta2" {
  subnet_id = "${aws_subnet.private_zoneb.id}"
  route_table_id = "${aws_route_table.private_zoneb.id}"
}
#================================================


