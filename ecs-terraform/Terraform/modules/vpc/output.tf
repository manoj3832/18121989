output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "all_subnets_ids" {
  value = "${join(",", aws_subnet.private_zonea.*.id, aws_subnet.private_zoneb.*.id, aws_subnet.public_zonea.*.id, aws_subnet.public_zoneb.*.id)}"
}
output "public_subnet_ids" {
  value = "${join(",", aws_subnet.public_zonea.*.id, aws_subnet.public_zoneb.*.id)}"
}
output "private_subnet_ids" {
  value = "${join(",", aws_subnet.private_zonea.*.id, aws_subnet.private_zoneb.*.id)}"
}

output "public_subnet_zonea" {
  value = "${aws_subnet.public_zonea.id}"
}

output "public_subnet_zoneb" {
  value = "${aws_subnet.public_zoneb.id}"
}

output "private_subnet_zonea" {
  value = "${aws_subnet.private_zonea.id}"
}

output "private_subnet_zoneb" {
  value = "${aws_subnet.private_zoneb.id}"
}
output "availability_zonea" {
  value = "${aws_subnet.public_zonea.availability_zone}"
}
output "availability_zoneb" {
  value = "${aws_subnet.public_zoneb.availability_zone}"
}
