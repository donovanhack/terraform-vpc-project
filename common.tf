terraform {
  required_version = ">= 0.12"
  # This S3 bucket is assumed to already exist
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "misterplod-tf-state-bucket"
    key            = "tfstate"
    dynamodb_table = "terraform_lock"
  }
}

provider "aws" {
  region  = local.aws_region
  version = "~> 2.31"
}

locals {
  aws_region = "eu-west-1"

  tags = {
    ManagedBy   = "terraform"
    Owner       = "engineering-sa"
    Environment = "development"
    Status      = "active"
  }

}
