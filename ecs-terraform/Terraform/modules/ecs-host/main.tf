#.................................................................
# User data template that specifies how to bootstrap each instance
#..................................................................
data "template_file" "connector_zonea" {
  template = "${file("${path.module}/user-data.tpl")}"

  vars {
    cluster_name = "${var.CONNECTOR_CLUSTER_NAME_ZONEA}"

  }
}
data "template_file" "connector_zoneb" {
  template = "${file("${path.module}/user-data.tpl")}"

  vars {
    cluster_name = "${var.CONNECTOR_CLUSTER_NAME_ZONEB}"

  }
}
data "template_file" "service_zonea" {
  template = "${file("${path.module}/user-data.tpl")}"

  vars {
    cluster_name = "${var.SERVICE_CLUSTER_NAME_ZONEA}"

  }
}
data "template_file" "service_zoneb" {
  template = "${file("${path.module}/user-data.tpl")}"

  vars {
    cluster_name = "${var.SERVICE_CLUSTER_NAME_ZONEB}"

  }
}

#............................................................................
# The launch configuration for each EC2 Instance that will run in the cluster
#............................................................................

resource "aws_launch_configuration" "connector_zonea" {
  name_prefix = "${var.CONNECTOR_CLUSTER_NAME_ZONEA}"
  instance_type = "${var.SERVICE_ECS_INSTANCE_TYPE}"
  iam_instance_profile = "${var.SERVICE_ECS_INSTANCE_PROFILE}"
  key_name = "${var.KEY_PAIR_NAME}"
  security_groups = ["${var.SERVICE-SG}"]
  image_id = "${var.ECS_INSTANCE_IMAGE_ID}"
  user_data = "${data.template_file.connector_zonea.rendered}"
  associate_public_ip_address = "${var.SERVICE_INSTANCE_PUBLICIP_ASSOCIATION}"
  root_block_device { 
         volume_size = "${var.SERVICE_ECS_INSTANCE_VOLUME_SIZE}"
         delete_on_termination = true
  }
  lifecycle { create_before_destroy = true }
}
resource "aws_launch_configuration" "connector_zoneb" {
  name_prefix = "${var.CONNECTOR_CLUSTER_NAME_ZONEB}"
  instance_type = "${var.SERVICE_ECS_INSTANCE_TYPE}"
  iam_instance_profile = "${var.SERVICE_ECS_INSTANCE_PROFILE}"
  key_name = "${var.KEY_PAIR_NAME}"
  security_groups = ["${var.SERVICE-SG}"]
  image_id = "${var.ECS_INSTANCE_IMAGE_ID}"
  user_data = "${data.template_file.connector_zoneb.rendered}"
  associate_public_ip_address = "${var.SERVICE_INSTANCE_PUBLICIP_ASSOCIATION}"
  root_block_device {
    volume_size = "${var.SERVICE_ECS_INSTANCE_VOLUME_SIZE}"
    delete_on_termination = true
  }
  lifecycle { create_before_destroy = true }
}

resource "aws_launch_configuration" "service_zonea" {
  name_prefix = "${var.SERVICE_CLUSTER_NAME_ZONEA}"
  instance_type = "${var.SERVICE_ECS_INSTANCE_TYPE}"
  iam_instance_profile = "${var.SERVICE_ECS_INSTANCE_PROFILE}"
  key_name = "${var.KEY_PAIR_NAME}"
  security_groups = ["${var.SERVICE-SG}"]
  image_id = "${var.ECS_INSTANCE_IMAGE_ID}"
  user_data = "${data.template_file.service_zonea.rendered}"
  associate_public_ip_address = "${var.SERVICE_INSTANCE_PUBLICIP_ASSOCIATION}"
  root_block_device {
    volume_size = "${var.SERVICE_ECS_INSTANCE_VOLUME_SIZE}"
    delete_on_termination = true
  }
  lifecycle { create_before_destroy = true }
}
resource "aws_launch_configuration" "service_zoneb" {
  name_prefix = "${var.SERVICE_CLUSTER_NAME_ZONEB}"
  instance_type = "${var.SERVICE_ECS_INSTANCE_TYPE}"
  iam_instance_profile = "${var.SERVICE_ECS_INSTANCE_PROFILE}"
  key_name = "${var.KEY_PAIR_NAME}"
  security_groups = ["${var.SERVICE-SG}"]
  image_id = "${var.ECS_INSTANCE_IMAGE_ID}"
  user_data = "${data.template_file.service_zoneb.rendered}"
  associate_public_ip_address = "${var.SERVICE_INSTANCE_PUBLICIP_ASSOCIATION}"
  root_block_device {
    volume_size = "${var.SERVICE_ECS_INSTANCE_VOLUME_SIZE}"
    delete_on_termination = true
  }
  lifecycle { create_before_destroy = true }
}
#......................................................................................................
# The auto scaling group that specifies how we want to scale the number of EC2 Instances in the cluster
#......................................................................................................


resource "aws_autoscaling_group" "connector_zonea" {
  name = "${var.STACK} Connectors ZoneA"
  min_size = "${var.SERVICE_ECS_INSTANCE_MIN_SIZE}"
  max_size = "${var.SERVICE_ECS_INSTANCE_MAX_SIZE}"
  desired_capacity = "${var.SERVICE_ECS_INSTANCE_DESIRED_CAPACITY}"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.connector_zonea.name}"
  vpc_zone_identifier = ["${split(",", var.SERVICE_ECS_INSTANCE_SUBNET_ZONEA)}"]
  health_check_type = "${var.ECS_INSTANCE_HEALTH_CHECK_TYPE}"
  
  lifecycle { create_before_destroy = true }

  tag {
    key = "Name"
    value = "${var.STACK} Connectors ZoneA"
    propagate_at_launch = true
  }
  tag {
    key = "Description"
    value = "Ec2 linux runnning ${var.CONNECTOR_CLUSTER_NAME_ZONEA} docker containers"
    propagate_at_launch = true
  }
  tag {
    key = "Containers Information"
    value = "Frontends: authentication,client-management, authorization Connectors:authentication,system-services,client-management,administration, configuration service"
    propagate_at_launch = true
  }
  tag {
    key = "StackID"
    value = "${var.STACKID}"
    propagate_at_launch = true
  }
  tag {
    key = "StackType"
    value = "${var.STACKTYPE}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "connector_zoneb" {
  name = "${var.STACK} Connectors ZoneB"
  min_size = "${var.SERVICE_ECS_INSTANCE_MIN_SIZE}"
  max_size = "${var.SERVICE_ECS_INSTANCE_MAX_SIZE}"
  desired_capacity = "${var.SERVICE_ECS_INSTANCE_DESIRED_CAPACITY}"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.connector_zoneb.name}"
  vpc_zone_identifier = ["${split(",", var.SERVICE_ECS_INSTANCE_SUBNET_ZONEB)}"]
  health_check_type = "${var.ECS_INSTANCE_HEALTH_CHECK_TYPE}"

  lifecycle { create_before_destroy = true }

  tag {
    key = "Name"
    value = "${var.STACK} Connectors ZoneB"
    propagate_at_launch = true
  }
  tag {
    key = "Description"
    value = "Ec2 linux runnning ${var.CONNECTOR_CLUSTER_NAME_ZONEB} docker containers"
    propagate_at_launch = true
  }
  tag {
    key = "Containers Information"
    value = "Frontends: authentication,client-management, authorization Connectors:authentication,system-services,client-management,administration, configuration service"
    propagate_at_launch = true
  }
  tag {
    key = "StackID"
    value = "${var.STACKID}"
    propagate_at_launch = true
  }
  tag {
    key = "StackType"
    value = "${var.STACKTYPE}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "service_zonea" {
  name = "${var.STACK} Services ZoneA"
  min_size = "${var.SERVICE_ECS_INSTANCE_MIN_SIZE}"
  max_size = "${var.SERVICE_ECS_INSTANCE_MAX_SIZE}"
  desired_capacity = "${var.SERVICE_ECS_INSTANCE_DESIRED_CAPACITY}"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.service_zonea.name}"
  vpc_zone_identifier = ["${split(",", var.SERVICE_ECS_INSTANCE_SUBNET_ZONEA)}"]
  health_check_type = "${var.ECS_INSTANCE_HEALTH_CHECK_TYPE}"

  lifecycle { create_before_destroy = true }

  tag {
    key = "Name"
    value = "${var.STACK} Services ZoneA"
    propagate_at_launch = true
  }
  tag {
    key = "Description"
    value = "Ec2 linux runnning ${var.SERVICE_CLUSTER_NAME_ZONEA}  docker containers"
    propagate_at_launch = true
  }
  tag {
    key = "Containers Information"
    value = "authentication, business-entity, system-service, authorization, identity, notification"
    propagate_at_launch = true
  }
  tag {
    key = "StackID"
    value = "${var.STACKID}"
    propagate_at_launch = true
  }
  tag {
    key = "StackType"
    value = "${var.STACKTYPE}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "service_zoneb" {
  name = "${var.STACK} Services ZoneB"
  min_size = "${var.SERVICE_ECS_INSTANCE_MIN_SIZE}"
  max_size = "${var.SERVICE_ECS_INSTANCE_MAX_SIZE}"
  desired_capacity = "${var.SERVICE_ECS_INSTANCE_DESIRED_CAPACITY}"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.service_zoneb.name}"
  vpc_zone_identifier = ["${split(",", var.SERVICE_ECS_INSTANCE_SUBNET_ZONEB)}"]
  health_check_type = "${var.ECS_INSTANCE_HEALTH_CHECK_TYPE}"

  lifecycle { create_before_destroy = true }

  tag {
    key = "Name"
    value = "${var.STACK} Services ZoneB"
    propagate_at_launch = true
  }
  tag {
    key = "Description"
    value = "Ec2 linux runnning ${var.SERVICE_CLUSTER_NAME_ZONEB}  docker containers"
    propagate_at_launch = true
  }
  tag {
    key = "Containers Information"
    value = "authentication, business-entity, system-service, authorization, identity, notification"
    propagate_at_launch = true
  }
  tag {
    key = "StackID"
    value = "${var.STACKID}"
    propagate_at_launch = true
  }
  tag {
    key = "StackType"
    value = "${var.STACKTYPE}"
    propagate_at_launch = true
  }
}
#================================================================================================================




