output "ssl_sg_id" {
  value = "${aws_security_group.ssl.id}"
}
output "postgresql_sg_id" {
  value = "${aws_security_group.postgresql.id}"
}
output "docker_sg_id" {
  value = "${aws_security_group.docker.id}"
}
output "mq_sg_id" {
  value = "${aws_security_group.rabbit.id}"
}
output "admin_sg_id" {
  value = "${aws_security_group.admin.id}"
}


