# Deploy an EC2 instance running last version of Ubuntu 20.04
resource "aws_instance" "Challenge_for_Interview" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.nano"
  availability_zone = "us-east-1a"
  subnet_id     = module.vpc.public_subnets[0]

  root_block_device {
    volume_size           = "8"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  vpc_security_group_ids = [
    aws_security_group.sg_Challenge_for_Interview.id,
  ]

  tags = local.common_tags
}

# S3 bucket definitions
resource "aws_s3_bucket" "Challenge_for_Interview_Bucket" {
  bucket = var.tag_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = local.common_tags
}