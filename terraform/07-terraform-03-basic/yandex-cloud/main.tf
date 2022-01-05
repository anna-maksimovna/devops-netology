terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token     = "${var.yc_token}"
  cloud_id  = "${var.yc_cloud_id}"
  folder_id = "${var.yc_folder_id}"
  zone      = "${var.yc_zone}"
}

locals {
  core_map = {
    stage = 2
    prod  = 4
  }

  memory_map = {
    stage = 4
    prod  = 16
  }

  instances = ["0", "1", "2"]
}

resource "yandex_compute_instance" "default" {
  for_each = local.instances

  name        = "test"+each.value
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = local.core_map[terraform.workspace]
    memory = local.memory_map[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "image_id"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.foo.id}"
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.foo.id}"
}