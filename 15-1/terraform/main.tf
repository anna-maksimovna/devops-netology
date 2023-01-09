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
  cloud_id  = "b1gukgdippc16e20ecq2"
  folder_id = "b1gtdp9f0lma03j8m6c2"
  zone      = local.zone
}

locals {
  zone           = "ru-central1-a"
  nat_gateway    = "192.168.10.254"
}

resource "yandex_vpc_network" "netology-vpc" {}

resource "yandex_vpc_subnet" "public" {
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = local.zone
  network_id     = "${yandex_vpc_network.netology-vpc.id}"
}

resource "yandex_vpc_route_table" "private_route_table" {
  network_id = yandex_vpc_network.netology-vpc.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = local.nat_gateway
  }
}

resource "yandex_vpc_subnet" "private" {
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = local.zone
  network_id     = "${yandex_vpc_network.netology-vpc.id}"
  route_table_id = yandex_vpc_route_table.private_route_table.id
}