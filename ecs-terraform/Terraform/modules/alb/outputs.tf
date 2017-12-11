output "alb_listener_arn" {
  value = "${aws_alb_listener.listener.arn}"
}

output "authentication-frontend" {
  value = "${aws_alb_target_group.login.arn}"
}

output "system-manager-frontend" {
  value = "${aws_alb_target_group.system-manager.arn}"
}

output "client-management-frontend" {
  value = "${aws_alb_target_group.client-manager.arn}"

}

output "authentication-connector" {
  value = "${aws_alb_target_group.authentication.arn}"
}

output "system-services-connector" {
  value = "${aws_alb_target_group.system-services.arn}"
}
output "administration-connector" {
  value = "${aws_alb_target_group.administration.arn}"
}
output "client-management-connector" {
  value = "${aws_alb_target_group.client-management.arn}"
}
output "configuration-services-connector" {
  value = "${aws_alb_target_group.configuration-services.arn}"
}

output "authentication-service" {
  value = "${aws_alb_target_group.authentication-service.arn}"
}

output "authorization-service" {
  value = "${aws_alb_target_group.authorization-service.arn}"
}

output "identity-service" {
  value = "${aws_alb_target_group.identity-service.arn}"
}

output "business-entity-service" {
  value = "${aws_alb_target_group.business-entity-service.arn}"
}

output "system-service" {
  value = "${aws_alb_target_group.system-service.arn}"
}

output "notification-service" {
  value = "${aws_alb_target_group.notification-service.arn}"
}