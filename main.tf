terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
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

resource "aws_instance" "example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = var.instance_type

  tags = {
    Name = "${var.project_name}-instance"
    Env  = var.environment
  }
}