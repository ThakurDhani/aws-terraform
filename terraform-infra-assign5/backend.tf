terraform {
  backend "s3" {
    bucket         = "terraform-state-dhani136"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
