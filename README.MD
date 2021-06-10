# Applaudo Test

Using Terraform, create the following infrastructure in AWS:

Create a custom VPC with three private subnets and three public subnets.
Create an application load balancer to serve traffic web between two EC2 instances.
Deploy a VPN server to ssh from home (you local network) to the EC2 instances.
Create a CI/CD template in any tool that you know, deploy an update to an Nginx environment in one of the EC2 Instances already created.

## Steps for use

1. [Download Terraform](https://www.terraform.io/downloads.html).
2. Create your SSH keys:

    `ssh-keygen -N '' -f ./certs/ovpn`

3. Edit your own `cert_details` (use `cert_details.sample` as template)

