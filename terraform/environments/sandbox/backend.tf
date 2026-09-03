terraform {
  backend "s3" {
    bucket       = "platform-engineering-terraform-state-058264480534"
    key          = "sandbox/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}


