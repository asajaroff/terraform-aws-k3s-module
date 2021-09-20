module "loadbalancers" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  depends_on = [
    aws_instance.node-1,
  ]

  name = "${module.tags.name}-nginx"

  load_balancer_type = "network"

  vpc_id             = module.network.vpc_id
  subnets            = module.network.public_subnets

#  access_logs = {
#    bucket = "access-logs-loadbalancers-${module.tags.name}"
#  }

  target_groups = [
    {
      name_prefix      = "node-1"
      backend_protocol = "TCP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          target_id = aws_instance.node-1.id
          port = 80
        }
      ]
    }
  ]

#  https_listeners = [
#    {
#      port               = 443
#      protocol           = "HTTPS"
#      certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
#      target_group_index = 0
#    }
#  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

  tags = module.tags.tags_no_name
}
