/* main.tf
Invokes the infrastructure
*/

module "bgpalerter" {
  source               = "../modules/fargate-infra"
  environment          = "prd"
  app_name             = var.app_name
  account_id           = var.account_id
  route53_hosted_zone  = var.route53_hosted_zone
  logs_endpoint        = var.logs_endpoint
  logs_source_category = var.logs_source_category
  image_tag            = "latest"
  container_port       = var.container_port
  common_tags          = local.common_tags
  image_name           = var.image_name
  image_tag_digest     = var.image_tag_digest
}
