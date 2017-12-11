# Internet facing Application load balancer that distributes load between the target groups instances

resource "aws_alb" "alb" {
  name = "${var.STACK}"
  internal = false
  security_groups = ["${var.ALB_SG}"]
  subnets = ["${split(",", var.ALB_SUBNETS)}"]
  tags {
    Name = "${var.STACK} LOAD BALANCER"
    Description = "${var.STACK} application load balancer to manage nodes and HTTPS/HTTP termination"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

#.............................................................................................
# ALB target group that defines the port/protocol the instances will listen on
#.............................................................................................
#====================================
## Frontend TargetGroups ##
#====================================
# /login
resource "aws_alb_target_group" "login" {
  name = "${var.STACK}-login-frontend"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "/login/"
  }
  tags {
    Name = "${var.STACK} FRONTEND TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
#...........
#client-manager
resource "aws_alb_target_group" "client-manager" {
  name = "${var.STACK}-cm-frontend"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "/client-manager/"
  }
  tags {
    Name = "${var.STACK} FRONTEND TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

#system-manager
resource "aws_alb_target_group" "system-manager" {
  name = "${var.STACK}-sm-frontend"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "/system-manager/"
  }
  tags {
    Name = "${var.STACK} FRONTEND TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
#===============================================
## Connectors Target Groups ##
#===============================================
#/authentication
resource "aws_alb_target_group" "authentication" {
  name = "${var.STACK}-auth-connector"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} CONNECTORS TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
#...........
#/administration
resource "aws_alb_target_group" "administration" {
  name = "${var.STACK}-administration-connector"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} CONNECTORS TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
#
#client-management
resource "aws_alb_target_group" "client-management" {
  name = "${var.STACK}-clm-connector"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} CONNECTORS TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
#...
#system-services
resource "aws_alb_target_group" "system-services" {
  name = "${var.STACK}-ss-connector"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} CONNECTORS TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
#configuration-services
resource "aws_alb_target_group" "configuration-services" {
  name = "${var.STACK}-cs-connector"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} CONNECTORS TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

#==========================================
## Services Target Groups ##
#==========================================

resource "aws_alb_target_group" "authentication-service" {
  name = "${var.STACK}-authe-service"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.SERVICE_TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} SERVICES TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_alb_target_group" "authorization-service" {
  name = "${var.STACK}-autho-service"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.SERVICE_TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} SERVICES TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_alb_target_group" "business-entity-service" {
  name = "${var.STACK}-be-service"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.SERVICE_TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} SERVICES TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_alb_target_group" "identity-service" {
  name = "${var.STACK}-id-service"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.SERVICE_TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} SERVICES TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_alb_target_group" "system-service" {
  name = "${var.STACK}-system-service"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.SERVICE_TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} SERVICES TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}

resource "aws_alb_target_group" "notification-service" {
  name = "${var.STACK}-notify-service"
  protocol = "${var.TARGET_GROUP_PROTOCOL}"
  port = "${var.SERVICE_TARGET_GROUP_PORT}"
  vpc_id = "${var.VPC_ID}"

  health_check {
    interval = "${var.TARGET_GROUP_HEALTH_CHECK_INTERVAL}"
    timeout = "${var.TARGET_GROUP_HEALTH_CHECK_TIMEOUT}"
    healthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_HEALTHY_THRESHOLD}"
    unhealthy_threshold = "${var.TARGET_GROUP_HEALTH_CHECK_UNHEALTHY_THRESHOLD}"
    path = "${var.HEALTHCHECK_PATH}"
  }
  tags {
    Name = "${var.STACK} SERVICES TARGET GROUP"
    Description = "${var.STACK} ${aws_alb.alb.arn} tagret group"
    StackType = "${var.STACKTYPE}"
    StackId = "${var.STACKID}"
    StackVersion = "${var.STACKVERSION}"
  }
}
#......................................................................................................

#.................................................................................................
# ALB listener that checks for connection requests from clients using the port/protocol specified
# These requests are then forwarded to one or more target groups, based on the rules defined
#................................................................................................
resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port = "${var.ALB_LISTNER_PORT}"
  protocol = "${var.ALB_LISTNER_PROTOCOL}"
  ssl_policy = "${var.ALB_LISTNER_SSL_POLICY_NAME}"
  certificate_arn = "${var.ALB_CERTIFICATE_ARN}"

  default_action {
    target_group_arn = "${aws_alb_target_group.login.arn}"
    type = "forward"
  }

  depends_on = ["aws_alb_target_group.login"]
}


resource "aws_alb_listener_rule" "login" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.login.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/login*"]
  }
}

resource "aws_alb_listener_rule" "authentication" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.authentication.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/authentication*"]
  }
}

resource "aws_alb_listener_rule" "administration" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 3

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.administration.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/administration*"]
  }
}

resource "aws_alb_listener_rule" "client-management" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 4

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.client-management.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/client-management*"]
  }
}

resource "aws_alb_listener_rule" "client-manager" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 5

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.client-manager.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/client-manager*"]
  }
}

resource "aws_alb_listener_rule" "system-manager" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 6

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.system-manager.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/system-manager*"]
  }
}

resource "aws_alb_listener_rule" "system-services" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 7

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.system-services.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/system-services*"]
  }
}
resource "aws_alb_listener_rule" "configuration-services" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 8

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.configuration-services.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/configuration-services*"]
  }
}

resource "aws_alb_listener_rule" "authentication-service" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 9

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.authentication-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/authentication-service/healthcheck*"]
  }
}

resource "aws_alb_listener_rule" "authorization-service" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.authorization-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/authorization-service/healthcheck*"]
  }
}

resource "aws_alb_listener_rule" "identity-service" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 11

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.identity-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/identity-service/healthcheck*"]
  }
}

resource "aws_alb_listener_rule" "business-entity-service" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 12

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.business-entity-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/business-entity-service/healthcheck*"]
  }
}

resource "aws_alb_listener_rule" "system-service" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 13

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.system-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/system-service/healthcheck*"]
  }
}

resource "aws_alb_listener_rule" "notification-service" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  priority     = 14

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.notification-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/notification-service/healthcheck*"]
  }
}
#=========================================================
