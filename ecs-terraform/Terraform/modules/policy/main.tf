#..............................................................................
# IAM policy we add to ECS cluster instances that allows them to do their thing
#..............................................................................

resource "aws_iam_role_policy" "ecs_instance_policy" {
  name = "${var.STACK}-ECS-Instance-Policy"
  policy = "${file("${path.module}/policies/ecs-instance-policy.json")}"
  role = "${aws_iam_role.ecs_instance_role.name}"
  lifecycle { create_before_destroy = true }
}
#..........................................
# An IAM Role that we attach to ECS services
#..........................................

resource "aws_iam_role" "ecs_service_role" {
  name = "${var.STACK}-ECS-Service-Role"
  assume_role_policy = "${file("${path.module}/policies/ecs-service.json")}"
}
#.....................................................................
# Managed IAM Policy for ECS services to communicate with EC2 Instances
#.....................................................................

resource "aws_iam_role_policy_attachment" "ecs_service" {
  role = "${aws_iam_role.ecs_service_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
#........................................
# An IAM Role for ECS service autoscaling
#........................................

resource "aws_iam_role" "ecs_service_autoscale" {
  name = "${var.STACK}-ecs-service-autoscale"
  assume_role_policy = "${file("${path.module}/policies/ecs-service-autoscale.json")}"
}
#...............................................
# Managed IAM Policy for ECS service autoscaling
#...............................................
resource "aws_iam_role_policy_attachment" "ecs_service_autoscale" {
  role = "${aws_iam_role.ecs_service_autoscale.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}

#.....................................................................
# An IAM instance profile we attach to the EC2 instances in the cluster
#.....................................................................
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name  = "${var.STACK}_ECS_Instance_Profile"
  role = "${aws_iam_role.ecs_instance_role.name}"
}

#..............................................................
# An IAM role that we attach to the EC2 Instances in the cluster
#..............................................................

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.STACK}-ECS-Instance-Role"
  assume_role_policy = "${file("${path.module}/policies/ecs-instance.json")}"

  lifecycle { create_before_destroy = true }
}

