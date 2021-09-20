namespace         = "k3s"
environment       = "dev"
aws_region        = "us-east-1"
key_name          = "asajaroff@gmail.com"
availability_zone_names = [
  "us-east-1a"
]

cidr_block          = "172.16.0.0/16"
private_subnets     = ["172.16.0.0/24", "172.16.1.0/24"]
public_subnets      = ["172.16.100.0/24", "172.16.101.0/24"]
