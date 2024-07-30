resource "aws_security_group" "application_sg" {
  name   = "app_security"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = aws_security_group.application_sg.id

  type = "ingress"

  from_port   = 22
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.application_sg.id

  type = "egress"

  from_port   = 22
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}



