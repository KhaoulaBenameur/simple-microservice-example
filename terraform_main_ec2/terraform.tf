terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.25.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }

  required_version = ">= 1.6.3"
}
