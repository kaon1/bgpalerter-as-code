/* remotes.tf
Retrieves data from the base account terraform state.
*/

data "terraform_remote_state" "account_base" {
  backend = "s3"
  config = {
    region   = "us-east-1"
    bucket   = "xxx-tf-state"
    key      = "xxx"
    role_arn = "xxx"
  }
}
