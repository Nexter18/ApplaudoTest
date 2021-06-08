output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}

output "security_group" {
  value = aws_security_group.allow_all.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet1" {
  value = element(aws_subnet.public_subnet.*.id, 1 )
}

output "subnet2" {
  value = element(aws_subnet.public_subnet.*.id, 2 )
}

output "subnet3" {
  value = element(aws_subnet.public_subnet.*.id, 3 )
}

output "private_subnet1" {
  value = element(aws_subnet.private_subnet.*.id, 1 )
}

output "private_subnet2" {
  value = element(aws_subnet.private_subnet.*.id, 2 )
}

output "private_subnet3" {
  value = element(aws_subnet.private_subnet.*.id, 3 )
}

output "curl" {
  value = "curl http://${aws_instance.ec2.public_ip}"
}

output "Login-with-Key" {
  value = "ssh -i ${aws_key_pair.sshkey.key_name} ubuntu@${aws_instance.ec2.public_ip}"
}