//where to load the bgpalerter tfstate in s3
terraform {
  backend "s3" {
    bucket       = "xxx-tf-state"
    key          = "bgpalerter"
    region       = "us-east-1"
    session_name = "xxx"
  }
}
