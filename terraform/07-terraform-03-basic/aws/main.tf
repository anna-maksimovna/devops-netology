terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
        }
    }
}
provider "aws" {
  region = "us-east-1"
}

locals {
    web_instance_type_map = {
        stage = "t3.micro"
        prod = "t3.large"
    }

    web_instance_count_map = {
        stage = 1
        prod = 2
    }
    instances = {
        "t3.micro" = "ami-00514a528eadbc95b"
        "t3.large" = "ami-00514a528eadbc95b"
    }
}

resource "aws_instance" "web1" {
    ami = "ami-00514a528eadbc95b"
    instance_type = local.web_instance_type_map[terraform.workspace]
    count = local.web_instance_count_map[terraform.workspace]

    lifecycle {
    create_before_destroy = true
  }
}

//По заданию непонятно, то ли надо в зависимости от воркспейса разное количество инстансов, то ли надо как в теории продемонстрировать использование foreach и key-value
//В общем привела пример, что несколько ресурсов можно запустить с помощью цикла и причем с разными настройками
resource "aws_instance" "web1" {
    for_each = local.instances

    ami = each.value
    instance_type = each.key
}