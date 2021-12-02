data "aws_caller_identity" "current" {
}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  common_tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}