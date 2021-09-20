resource "aws_default_security_group" "default" {
  vpc_id      = module.network.vpc_id

  ingress = [
    {
      description      = "All ports on all protocols"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = [var.cidr_block]
      ipv6_cidr_blocks = []
      security_groups  = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "All ports on all protocols"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = [var.cidr_block]
      ipv6_cidr_blocks = []
      security_groups  = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  tags = merge(
    module.tags.tags_no_name,
    {
      Name = "Allow private network traffic"
    }
  )
}
resource "aws_security_group" "vpc_internal" {
  name        = "vpc_internal-${module.tags.name}"
  description = "Allow TCP and UDP traffic on all ports within the private network"
  vpc_id      = module.network.vpc_id

  ingress = [
    {
      description      = "All ports on all protocols"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = [var.cidr_block]
      ipv6_cidr_blocks = []
      security_groups  = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "All ports on all protocols"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = [var.cidr_block]
      ipv6_cidr_blocks = []
      security_groups  = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  tags = merge(
    module.tags.tags_no_name,
    {
      Name = "Allow private network traffic"
    }
  )
}

resource "aws_security_group" "public_in" {
  name        = "public_in-${module.tags.name}"
  description = "Allow TCP and UDP traffic on all ports within the private network"
  vpc_id      = module.network.vpc_id

  ingress = [
    {
      description      = "Allow TCP 80"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      security_groups  = []
      prefix_list_ids  = []
      self             = true
    },
    {
      description      = "Allow TCP 443"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      security_groups  = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "All ports on all protocols"
      from_port        = 0
      to_port          = 0
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  tags = merge(
    module.tags.tags_no_name,
    {
      Name = "Incoming web traffic"
    }
  )
}

resource "aws_security_group" "ssh_home" {
  name        = "ssh_home-${module.tags.name}"
  description = "Pa que entre el guacho pistola"
  vpc_id      = module.network.vpc_id

  ingress = [
    {
      description      = "Allow SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["190.244.97.161/32"]
      ipv6_cidr_blocks = []
      security_groups  = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  egress = []
  
tags = merge(
    module.tags.tags_no_name,
    {
      Name = "Incoming SSH on IP Address"
    }
  )
}

resource "aws_security_group" "egress_all" {
  name        = "egress_all-${module.tags.name}"
  description = "Allow both TCP/UDP traffic to outside"
  vpc_id      = module.network.vpc_id

  ingress = []

  egress = [
    {
      description      = "All outgoing connections allowed"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      security_groups  = []
      prefix_list_ids  = []
      self             = false
    }
  ]

tags = merge(
    module.tags.tags_no_name,
    {
      Name = "Outgoing connections to internet"
    }
  )
}


