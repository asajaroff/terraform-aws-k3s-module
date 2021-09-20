data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Web servers
# 
#
resource "aws_instance" "node-1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.xlarge"
  key_name      = var.key_name
  subnet_id     = module.network.public_subnets.0
  vpc_security_group_ids = [
    aws_security_group.ssh_home.id,
    aws_security_group.egress_all.id,
    aws_security_group.public_in.id,
    aws_security_group.vpc_internal.id
  ]
  user_data = file("bin/nodes-cloud-init.sh")

  tags = merge(
    module.tags.tags_no_name,
    {
      Name = "node-1-${module.tags.name}"
    },
  )
}
