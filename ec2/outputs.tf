output "instance1_id" {
  value = element(aws_instance.app_test_instance.*.id, 1)
}

output "instance2_id" {
  value = element(aws_instance.app_test_instance.*.id, 2)
}