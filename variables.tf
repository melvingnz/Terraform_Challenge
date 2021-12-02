# AWS VPC configuration
variable aws_region {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Main VPC name"
  default     = "VPC_MG"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
  type = map
  default = {
    us-east-1a = "10.0.5.0/24"
    us-east-1b = "10.0.6.0/24"
    us-east-1c = "10.0.7.0/24"
  }
}

# S3 bucket name
variable "tag_bucket_name" {
  description = "Name tag to set for the S3 Bucket."
  type        = string
  default     = "Challenge_for_Interview.flugel.it"
}

# Dinamically search latest Ubuntu 20.04 AMIs
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}