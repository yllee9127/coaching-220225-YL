# Create two ECR repo for S3 and SQS services

# resource "aws_ecr_repository" "flask-sqs-repo" {
#   name         = "yap-flask-sqs-repo"
#   force_delete = true
# }

# resource "aws_ecr_repository" "flask-s3-repo" {
#   name         = "yap-flask-s3-repo"
#   force_delete = true
# }

# Create ECS cluster and service
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"

  cluster_name = "yap-cluster"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    yap-s3-service = {
      cpu    = 512
      memory = 1024

      container_definitions = {
        yap-s3-app = {
          essential = true
          image     = "255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/yap-flask-s3-repo:latest"
          port_mappings = [
            {
              containerPort = 5001
              hostPort      = 5001
              protocol      = "tcp"
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      
      subnet_ids                         = data.aws_subnets.public.ids
      security_group_ids                 = [aws_security_group.ecs-s3-sg.id]                                                       #Create a SG resource and pass it here
    }
  
    yap-sqs-service = {
      cpu    = 512
      memory = 1024

      container_definitions = {
        yap-sqs-app = {
          essential = true
          image     = "255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/yap-flask-sqs-repo:latest"
          port_mappings = [
            {
              containerPort = 5002
              hostPort      = 5002
              protocol      = "tcp"
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      
      subnet_ids                         = data.aws_subnets.public.ids
      security_group_ids                 = [aws_security_group.ecs-sqs-sg.id]                                                       #Create a SG resource and pass it here
    }
  }
}

