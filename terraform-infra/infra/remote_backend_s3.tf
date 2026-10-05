terraform {
  backend "s3" {
    bucket = "harika-app-rds"
    key    = "rds-key/terraform.tfstate"
    region = "eu-west-1"
  }
}
