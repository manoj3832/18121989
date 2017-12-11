data "aws_ami" "amzn_linux" {
  most_recent = true
  filter {
    name = "name"
    values = [
      "amzn-ami-hvm-2017.03.1.20170623-x86_64-gp2*"]
  }
  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }
}

resource "aws_launch_configuration" "lc" {
  name_prefix = "${var.STACK} message queue"
  image_id = "${data.aws_ami.amzn_linux.id}"
  instance_type = "${var.MQ_INSTANCE_TYPE}"
  user_data = "${file("${path.module}/install.tpl")}"
  key_name = "${var.KEYPAIR_NAME}"
  security_groups = ["${var.MQ_SG}"]
  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type = "${var.MQ_VOLUME_TYPE}"
    volume_size = "${var.MQ_VOLUME_SIZE}"
  }
}
#.............................................................................................................................

resource "aws_autoscaling_group" "ag1" {
  vpc_zone_identifier = ["${split(",", var.MQ_PRIVATE_SUBNET_ZONEA)}"]
  name = "${var.STACK} rabbit ${var.MQ_PRIVATE_SUBNET_ZONEA}"
  max_size = "${var.MQ_MAX_SIZE}"
  min_size = "${var.MQ_MIN_SIZE}"
  health_check_grace_period = "${var.HEALTH_CHECK_GRACE_PERIOD}"
  health_check_type = "${var.HEALTH_CHECK_TYPE}"
  desired_capacity = "${var.MQ_DESIRED_CAPACITY}"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.lc.name}"

  tag {
    key = "Name"
    value = "${var.STACK} Message Queue Master"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "ag2" {
  vpc_zone_identifier = ["${split(",", var.MQ_PRIVATE_SUBNET_ZONEB)}"]
  name = "${var.STACK}  rabbit ${var.MQ_PRIVATE_SUBNET_ZONEB}"
  max_size = "${var.MQ_MAX_SIZE}"
  min_size = "${var.MQ_MIN_SIZE}"
  health_check_grace_period = "${var.HEALTH_CHECK_GRACE_PERIOD}"
  health_check_type = "${var.HEALTH_CHECK_TYPE}"
  desired_capacity = "${var.MQ_DESIRED_CAPACITY}"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.lc.name}"

  tag {
    key = "Name"
    value = "${var.STACK} Message Queue Mirror1"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_group" "ag3" {
  vpc_zone_identifier = ["${split(",", var.MQ_PRIVATE_SUBNET_ZONEB)}"]
  name = "${var.STACK} rabbit ${var.MQ_PRIVATE_SUBNET_ZONEB}"
  max_size = "${var.MQ_MAX_SIZE}"
  min_size = "${var.MQ_MIN_SIZE}"
  health_check_grace_period = "${var.HEALTH_CHECK_GRACE_PERIOD}"
  health_check_type = "${var.HEALTH_CHECK_TYPE}"
  desired_capacity = "${var.MQ_DESIRED_CAPACITY}"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.lc.name}"

  tag {
    key = "Name"
    value = "${var.STACK} Message Queue Mirror2"
    propagate_at_launch = true
  }
}
