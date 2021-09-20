# resource "aws_route53_record" "domain_plebiscito_com" {
#   zone_id = "Z058455325ILSHXP1BHY5"
#   name    = "elplebiscito.com"
#   type    = "A"
#   ttl     = "300"
#   records = [aws_instance.web_worker_01.public_ip]
# }

