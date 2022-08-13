### ECS File creates the Fargate service for the docker container
### Sets CPU and RAM
### Creates the bgpalerter task definition and runs it

resource "aws_ecs_cluster" "bgpalerter-fargate" {
  name               = local.svc_name
  capacity_providers = ["FARGATE_SPOT"]


  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }

  tags = var.common_tags
}

// ECS service

resource "aws_ecs_service" "bgpalerter-svc" {
  name            = local.svc_name
  cluster         = aws_ecs_cluster.bgpalerter-fargate.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = xxx
    security_groups = [xxx]
  }

  load_balancer {
    target_group_arn = xxx
    container_name   = xxx
    container_port   = xxx
  }

  tags = xxx
}

### Create BGPAlerter Task
resource "aws_ecs_task_definition" "task_definition" {
  family = local.svc_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = xxx
  task_role_arn            = xxx
  ### CPU and Memory
  cpu                      = 512
  memory                   = 1024
  tags                     = xxx
  container_definitions = jsonencode([
    {
      name  = local.svc_name
      image = "${var.image_name}${var.image_tag_digest}"
      essential  = true
      ### Call the shell script when the image starts. This replaces the slack webhook and starts the service
      entryPoint = ["/bin/sh", "/opt/bgpalerter/volume/slack-token-replace.sh"]
      secrets = [
        {
          name      = "SLACK_API_TOKEN"
          valueFrom = xxx
        }
      ]
      portMappings = [
        {
          containerPort = 8011
          hostPort      = 8011
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = local.svc_name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "bgpalerter"
        }
      }
    }
  ])
}
