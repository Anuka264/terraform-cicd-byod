terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {}
variable "instance_type" {}
variable "environment" {}
variable "project_name" {}
variable "subnet_id" {}

resource "aws_instance" "example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = var.instance_type
  subnet_id     = var.subnet_id 

  tags = {
    Name = "${var.project_name}-instance"
    Env  = var.environment
  }
}