# resource "aws_ecr_repository" "ecr" {
#   name         = "yap-ecr"
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
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      
      subnet_ids                         = data.aws_subnets.public.ids
      security_group_ids                 = [aws_security_group.ecs-sg.id]                                                       #Create a SG resource and pass it here
    }
  
    # yap-sqs-service = {
    #   cpu    = 512
    #   memory = 1024

    #   container_definitions = {
    #     yap-sqs-app = {
    #       essential = true
    #       image     = "255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/yap-flask-sqs-repo:latest"
    #       port_mappings = [
    #         {
    #           containerPort = 8080
    #           protocol      = "tcp"
    #         }
    #       ]
    #     }
    #   }
    #   assign_public_ip                   = true
    #   deployment_minimum_healthy_percent = 100
      
    #   subnet_ids                         = data.aws_subnets.public.ids
    #   security_group_ids                 = [aws_security_group.ecs-sg.id]                                                       #Create a SG resource and pass it here
    # }
  }
}

