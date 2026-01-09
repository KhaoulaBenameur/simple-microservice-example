variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
  default = "Lab-VPC"
}

variable "subnet_public1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_public2" {
  type    = string
  default = "10.0.2.0/24"
}

variable "subnet_private1" {
  type    = string
  default = "10.0.3.0/24"
}

variable "subnet_private2" {
  type    = string
  default = "10.0.4.0/24"
}

variable "sg_name" {
  type    = string
  default = "Lab-SG"
}

variable "instance_type" {
  type    = string
  default = "t2.medium"
}

variable "key_name" {
  type    = string
}

variable "instance_name" {
  type    = string
  default = "Lab-Jumphost"
}

variable "lab_instance_profile" {
  type    = string
  default = "LabInstanceProfile"
}

variable "ami_id" {
  type    = string
  default = "ami-0c02fb55956c7d316" # Amazon Linux 2 LTS US-East-1
}

