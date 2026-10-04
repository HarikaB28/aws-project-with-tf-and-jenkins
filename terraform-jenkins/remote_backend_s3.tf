terraform {
  backend "s3" {
    bucket = "harika-bucket-2806"
    key    = "web-project/jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
