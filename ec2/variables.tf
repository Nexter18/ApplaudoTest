  
variable "my_public_key" {}

variable "ami_id" {}

variable "instance_type" {}

variable "security_group" {}

variable "subnets" {
  type = list(string)
}