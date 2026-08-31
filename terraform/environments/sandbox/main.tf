module "vpc" {
  source = "../../modules/vpc"

  environment = var.environment

  vpc_cidr = "10.10.0.0/16"

  availability_zones = [
    "eu-west-2a",
    "eu-west-2b"
  ]
}