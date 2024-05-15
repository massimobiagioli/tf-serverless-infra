provider "aws" {
  region  = var.aws_params["region"]
  profile = var.aws_params["profile"]
}

terraform {
  required_providers {
    aws = {
      version = ">= 5.46.0"
      source  = "hashicorp/aws"
    }
  }

  required_version = "~> 1.0"

  # backend "s3" {
  #   bucket         = "tester-dev-tfstate"
  #   key            = "dev/tfstate/terraform.tfstate"
  #   dynamodb_table = "tester-dev-tfstate-locks"
  #   region         = "eu-west-1"
  #   encrypt        = true
  # }
}
