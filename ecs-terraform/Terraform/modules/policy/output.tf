output "ecs_instance_profile_name" {
  value = "${aws_iam_instance_profile.ecs_instance_profile.name}"
}

output "ecs_service_role_arn" {
  value = "${aws_iam_role.ecs_service_role.arn}"
}

output "ecs_service_autoscale_role_arn" {
  value = "${aws_iam_role.ecs_service_autoscale.arn}"
}
