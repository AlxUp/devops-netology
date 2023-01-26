terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "AQAAAAANdHX0AATuwdg5U76VcE1mkfjv3CQRBos"
  cloud_id  = "ajet0q7b5t7b48rvpmd3"
  folder_id = "b1gfvhkruu80dhlor8th"
  zone      = "ru-central1-a, ru-central1-b"
}

resource "yandex_iam_service_account" "alxup" {
  name        = "alxup"
  description = "service account to manage IG"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = "b1gfvhkruu80dhlor8th"
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.alxup.id}",
  ]
}

resource "yandex_compute_instance_group" "http" {
  name               = "http"
  folder_id          = "b1gfvhkruu80dhlor8th"
  service_account_id = yandex_iam_service_account.alxup.id
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory        = 4
      cores         = 4
      core_fraction = 20
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd8f1tik9a7ap9ik2dg1"
        size     = 15
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.network-1.id}"
      subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}","${yandex_vpc_subnet.subnet-2.id}"]
    }
    metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
    allocation_policy {
    zones = ["ru-central1-a","ru-central1-b"]
  }
  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  application_load_balancer {
    target_group_name        = "target-group"
    target_group_description = "load balancer target group"
  }
}
resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.0.0/24"]
}
resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
#VM3 - Prometheus
resource "yandex_compute_instance" "prometheus" {
  name                      = "prom"
  zone                      = "ru-central1-a"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }
  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = "fd8f1tik9a7ap9ik2dg1"
      size     = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
#VM4  Grafana
resource "yandex_compute_instance" "grafana" {
  name                      = "grafana"
  zone                      = "ru-central1-a"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }
  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = "fd8f1tik9a7ap9ik2dg1"
      size     = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
#VM5  kibana
resource "yandex_compute_instance" "kibana" {
  name                      = "kibana"
  zone                      = "ru-central1-a"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }
  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = "fd8f1tik9a7ap9ik2dg1"
      size     = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
#VM6  Elasticsearch
resource "yandex_compute_instance" "elastic" {
  name                      = "elastic"
  zone                      = "ru-central1-a"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }
  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = "fd8f1tik9a7ap9ik2dg1"
      size     = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
#VM7 Bastion host
resource "yandex_compute_instance" "bastion" {
  name                      = "bastion"
  zone                      = "ru-central1-a"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }
  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = "fd8f1tik9a7ap9ik2dg1"
      size     = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
#Network

resource "yandex_vpc_security_group" "alx-sg" {
  name        = "alx-sg"
  description = "Description for security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "Rule description 1"
    v4_cidr_blocks = ["192.168.0.0/24", "192.168.0.0/24"]
    port           = 80

  }

}

output "internal_ip_address_prometheus" {
  value = yandex_compute_instance.prometheus.network_interface.0.ip_address
}
output "external_ip_address_prometheus" {
  value = yandex_compute_instance.prometheus.network_interface.0.nat_ip_address
}
output "internal_ip_address_grafana" {
  value = yandex_compute_instance.grafana.network_interface.0.ip_address
}
output "external_ip_address_grafana" {
  value = yandex_compute_instance.grafana.network_interface.0.nat_ip_address
}
output "internal_ip_address_kibana" {
  value = yandex_compute_instance.kibana.network_interface.0.ip_address
}
output "external_ip_address_kibana" {
  value = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
}
output "internal_ip_address_elastic" {
  value = yandex_compute_instance.elastic.network_interface.0.ip_address
}
output "external_ip_address_elastic" {
  value = yandex_compute_instance.elastic.network_interface.0.nat_ip_address
}
output "internal_ip_address_bastion" {
  value = yandex_compute_instance.bastion.network_interface.0.ip_address
}
output "external_ip_address_bastion" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}
