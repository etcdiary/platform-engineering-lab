provider "aws" {
  region = "eu-west-2"
  allowed_account_ids = ["058264480534"]
}

module "terraform_state" {
  source = "../../modules/s3-state"

  bucket_name   = "platform-engineering-module-test-058264480534"
}