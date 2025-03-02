# Security Group for ECS S3 service
resource "aws_security_group" "ecs-s3-sg" {
  name_prefix = "yl-ecs-s3-sg" #Security group name, e.g. jazeel-terraform-security-group
  description = "Security group for ECS S3 service"
  #vpc_id      = data.aws_vpc.selected.id #VPC ID (Same VPC as your EC2 subnet above), E.g. vpc-xxxxxxx
  vpc_id      = module.vpc-1.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_5001" {
  security_group_id = aws_security_group.ecs-s3-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5001
  ip_protocol       = "tcp"
  to_port           = 5001
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_5001" {
  security_group_id = aws_security_group.ecs-s3-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# Security Group for ECS SQS service
resource "aws_security_group" "ecs-sqs-sg" {
  name_prefix = "yl-ecs-sqs-sg" #Security group name, e.g. jazeel-terraform-security-group
  description = "Security group for ECS SQS service"
  #vpc_id      = data.aws_vpc.selected.id #VPC ID (Same VPC as your EC2 subnet above), E.g. vpc-xxxxxxx
  vpc_id      = module.vpc-1.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_5002" {
  security_group_id = aws_security_group.ecs-sqs-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5002
  ip_protocol       = "tcp"
  to_port           = 5002
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_5002" {
  security_group_id = aws_security_group.ecs-sqs-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}