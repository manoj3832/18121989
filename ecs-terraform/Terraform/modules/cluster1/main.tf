#
# ECS Cluster
#
resource "aws_ecs_cluster" "connector" {
  name = "${var.CONNECTOR_CLUSTER_NAME_ZONEA}"
}
resource "aws_ecs_cluster" "service" {
  name = "${var.SERVICE_CLUSTER_NAME_ZONEA}"
}
#
# ECS Service Depends_On Iam roles and Policy
#
resource "aws_iam_role_policy" "ecs_role_policy" {
  name = "${var.STACK}ECS_DEPENDS_ROLE_POLICY_ZONEA"
  role = "${aws_iam_role.ecs_role.id}"

  policy = "${file("${path.module}/policies/ecs-service-role-policy.json")}"
}

resource "aws_iam_role" "ecs_role" {
  name = "${var.STACK}-ECS_DEPENDS_ROLE-ZONEA"

  assume_role_policy = "${file("${path.module}/policies/ecs-service-role.json")}"
}
#....................................
# Tak Definitions
#

#Frontends ..........................
resource "aws_ecs_task_definition" "authentication-frontend" {
  family = "authentication-frontend"
  container_definitions = "${file("${path.module}/task-definition/authentication-frontend.json")}"
}
resource "aws_ecs_task_definition" "system-manager-frontend" {
  family = "system-manager-frontend"
  container_definitions = "${file("${path.module}/task-definition/system-manager-frontend.json")}"
}
resource "aws_ecs_task_definition" "client-management-frontend" {
  family = "client-management-frontend"
  container_definitions = "${file("${path.module}/task-definition/client-management-frontend.json")}"
}

#=====================================================================================================
#Services .....................................
#
resource "aws_ecs_task_definition" "authentication-service" {
  family = "authentication-service"
  container_definitions = "${file("${path.module}/task-definition/authentication-service.json")}"
}
resource "aws_ecs_task_definition" "authorization-service" {
  family = "authorization-service"
  container_definitions = "${file("${path.module}/task-definition/authorization-service.json")}"
}
resource "aws_ecs_task_definition" "business-entity-service" {
  family = "business-entity-service"
  container_definitions = "${file("${path.module}/task-definition/business-entity-service.json")}"
}
resource "aws_ecs_task_definition" "identity-service" {
  family = "identity-service"
  container_definitions = "${file("${path.module}/task-definition/identity-service.json")}"
}
resource "aws_ecs_task_definition" "notification-service" {
  family = "notification-service"
  container_definitions = "${file("${path.module}/task-definition/notification-service.json")}"
}
resource "aws_ecs_task_definition" "system-service" {
  family = "system-service"
  container_definitions = "${file("${path.module}/task-definition/system-service.json")}"
}

#=====================================================================================================
#connector
resource "aws_ecs_task_definition" "system-services-connector" {
  family = "system-services-connector"
  container_definitions = "${file("${path.module}/task-definition/system-services-connector.json")}"
}
resource "aws_ecs_task_definition" "administration-connector" {
  family = "administration-connector"
  container_definitions = "${file("${path.module}/task-definition/administration-connector.json")}"
}
resource "aws_ecs_task_definition" "client-management-connector" {
  family = "client-management-connector"
  container_definitions = "${file("${path.module}/task-definition/client-management-connector.json")}"
}
resource "aws_ecs_task_definition" "authentication-connector" {
  family = "authentication-connector"
  container_definitions = "${file("${path.module}/task-definition/authentication-connector.json")}"
}
resource "aws_ecs_task_definition" "configuration-services-connector" {
  family = "configuration-services-connector"
  container_definitions = "${file("${path.module}/task-definition/configuration-services-connector.json")}"
}
#======================================================================================================
#....................................................................................................
## ECS Service
#...................................................................................................
#===============================================

#Frontend
resource "aws_ecs_service" "authentication-frontend" {
  name = "authentication-frontend"
  cluster = "${aws_ecs_cluster.connector.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.authentication-frontend.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.AUTHENTICATION-FRONTEND-TG}"
    container_name = "authentication-frontend"
    container_port = "${var.TARGET_GROUP_PORT}"
  }


}
resource "aws_ecs_service" "system-manager-frontend" {
  name = "system-manager-frontend"
  cluster = "${aws_ecs_cluster.connector.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.system-manager-frontend.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.SYSTEM-MANAGER-FRONTEND-TG}"
    container_name   = "system-manager-frontend"
    container_port   = "${var.TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "client-management-frontend" {
  name = "client-management-frontend"
  cluster = "${aws_ecs_cluster.connector.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.client-management-frontend.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.CLIENT-MANAGEMENT-FRONTEND-TG}"
    container_name   = "client-management-frontend"
    container_port   = "${var.TARGET_GROUP_PORT}"
  }
}
#=============================================================================================
#Services
resource "aws_ecs_service" "authentication-service" {
  name = "authentication-service"
  cluster = "${aws_ecs_cluster.service.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.authentication-service.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.AUTHENTICATION-SERVICE-TG}"
    container_name   = "authentication-service"
    container_port   = "${var.SERVICE_TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "authorization-service" {
  name = "authorization-service"
  cluster = "${aws_ecs_cluster.service.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.authorization-service.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.AUTHORIZATION-SERVICE-TG}"
    container_name   = "authorization-service"
    container_port   = "${var.SERVICE_TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "business-entity-service" {
  name = "business-entity-service"
  cluster = "${aws_ecs_cluster.service.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.business-entity-service.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.BUSINESS-ENTITY-SERVICE-TG}"
    container_name   = "business-entity-service"
    container_port   = "${var.SERVICE_TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "identity-service" {
  name = "identity-service"
  cluster = "${aws_ecs_cluster.service.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.identity-service.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.IDENTITY-SERVICE-TG}"
    container_name   = "identity-service"
    container_port   = "${var.SERVICE_TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "notification-service" {
  name = "notification-service"
  cluster = "${aws_ecs_cluster.service.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.notification-service.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.NOTIFICATION-SERVICE-TG}"
    container_name   = "notification-service"
    container_port   = "${var.SERVICE_TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "system-service" {
  name = "system-service"
  cluster = "${aws_ecs_cluster.service.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.system-service.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.SYSTEM-SERVICE-TG}"
    container_name   = "system-service"
    container_port   = "${var.SERVICE_TARGET_GROUP_PORT}"
  }

}
#============================================================================================
# Connectors
#
resource "aws_ecs_service" "authentication-connector" {
  name = "authentication-connector"
  cluster = "${aws_ecs_cluster.connector.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.authentication-connector.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.AUTHENTICATION-CONNECTOR-TG}"
    container_name   = "authentication-connector"
    container_port   = "${var.TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "client-management-connector" {
  name = "client-management-connector"
  cluster = "${aws_ecs_cluster.connector.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.client-management-connector.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.CLIENT-MANAGEMENT-CONNECTOR-TG}"
    container_name   = "client-management-connector"
    container_port   = "${var.TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "system-services-connector" {
  name = "system-services-connector"
  cluster = "${aws_ecs_cluster.connector.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.system-services-connector.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.SYSTEM-SERVICES-CONNECTOR-TG}"
    container_name   = "system-services-connector"
    container_port   = "${var.TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "configuration-services-connector" {
  name = "configuration-services-connector"
  cluster = "${aws_ecs_cluster.connector.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.configuration-services-connector.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.CONFIGURATION-SERVICES-CONNECTOR-TG}"
    container_name   = "configuration-services-connector"
    container_port   = "${var.TARGET_GROUP_PORT}"
  }

}
resource "aws_ecs_service" "administration-connector" {
  name = "administration-connector"
  cluster = "${aws_ecs_cluster.connector.id}"
  iam_role = "${var.ECS_SERVICE_ROLE}"
  depends_on = ["aws_iam_role_policy.ecs_role_policy"]
  task_definition = "${aws_ecs_task_definition.administration-connector.arn}"
  desired_count = "${var.ECS_DESIRED_COUNT}"
  deployment_minimum_healthy_percent = "${var.ECS_MINIMUM_HEALTH_PERCENTAGE}"

  load_balancer {
    target_group_arn = "${var.ADMINISTRATION-CONNECTOR-TG}"
    container_name   = "administration-connector"
    container_port   = "${var.TARGET_GROUP_PORT}"
  }

}
#================================================================================================
