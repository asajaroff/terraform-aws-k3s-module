# Tagging variables
variable "namespace" {
  type    = string
  default = "namespace"
}

variable "environment-name" {
  type    = string
  default = "decomposer"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "owner" {
  type    = string
  default = "Account owner"
}

# Network variables
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "availability_zone_amount" {
  type    = number
  default = 2
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cidr_block" {
  type    = string
  default = "172.16.0.0/16"
}

variable "private_subnets" {
  type    = list(string)
  default = ["172.16.0.0/24", "172.16.1.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["172.16.100.0/24", "172.16.101.0/24"]
}

# Node related
variable "key_name" {
  type    = string
  default = "ec2-key-name"
}
variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8000
      external = 8000
      protocol = "tcp"
    }
  ]
}
