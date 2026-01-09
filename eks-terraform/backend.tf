terraform {
  backend "s3" {
    bucket = "terraform-state-8bfeb855"
    key    = "k8/terraform.tfstate"
    region = "us-east-1"
  }
}
