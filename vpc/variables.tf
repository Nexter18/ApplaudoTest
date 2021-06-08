variable "cidr_range_vpc" {
}

variable "public_cidrs" {
  type    = list(string)
}

variable "private_cidrs" {
  type    = list(string)
}