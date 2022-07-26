provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "tf-assesment-2022-07"
    key    = "netspi/terraform.tfstate"
    region = "us-east-1"
  }
}
