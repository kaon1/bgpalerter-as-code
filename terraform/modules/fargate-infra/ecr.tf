/* ecr.tf
This file creates the ECR repository for the docker image.
*/

resource "aws_ecr_repository" "app_image" {
  name                 = "bgpalerter"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

