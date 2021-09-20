module "tags" {
  source  = "rhythmictech/tags/terraform"
  version = "1.0.0"

  enforce_case = "lower"
  name_seperator = "-"

  names = [
    var.namespace,
    var.environment 
  ]

  tags = {
    "Environment"   = var.environment
    "Namespace"     = var.namespace,
    "Owner"         = var.owner,
    "Terraform"     = "true"
  }
}
