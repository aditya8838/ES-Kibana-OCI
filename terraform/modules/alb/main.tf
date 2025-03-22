resource "aws_lb" "project_lb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = [var.public_subnet1_id, var.public_subnet2_id]

  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "elastic_tg" {
  name     = "elastic-tg"
  port     = 9200
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "elastic1" {
  target_group_arn = aws_lb_target_group.elastic_tg.arn
  target_id        = var.elasticsearch1_id
  port             = 9200
}

resource "aws_lb_target_group_attachment" "elastic2" {
  target_group_arn = aws_lb_target_group.elastic_tg.arn
  target_id        = var.elasticsearch2_id
  port             = 9200
}

resource "aws_lb_target_group_attachment" "elastic3" {
  target_group_arn = aws_lb_target_group.elastic_tg.arn
  target_id        = var.elasticsearch3_id
  port             = 9200
}

resource "aws_lb_target_group_attachment" "elastic4" {
  target_group_arn = aws_lb_target_group.elastic_tg.arn
  target_id        = var.elasticsearch4_id
  port             = 9200
}

resource "aws_lb_target_group" "kibana_tg" {
  name     = "kibana-tg"
  port     = 5601
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "kibana1" {
  target_group_arn = aws_lb_target_group.kibana_tg.arn
  target_id        = var.kibana1_id
  port             = 5601
}

resource "aws_lb_target_group_attachment" "kibana2" {
  target_group_arn = aws_lb_target_group.kibana_tg.arn
  target_id        = var.kibana2_id
  port             = 5601
}

resource "aws_lb_listener" "elastic_listener" {
  load_balancer_arn = aws_lb.project_lb.arn
  port              = 9200
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.elastic_tg.arn
  }
}

resource "aws_lb_listener" "kibana_listener" {
  load_balancer_arn = aws_lb.project_lb.arn
  port              = 5601
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kibana_tg.arn
  }
}
