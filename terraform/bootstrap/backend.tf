terraform {
  backend "s3" {
    bucket         = "platform-engineering-bootstrap-state"
    key            = "terraform/bootstrap.tfstate"
    region         = "eu-west-2"
    encrypt        = true
  }
}

