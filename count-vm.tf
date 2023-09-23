resource "yandex_compute_instance" "web" {
  count = 2
  name        = "web-${count.index + 1}"
  platform_id = var.platform_id_v1
  resources {
    cores         = var.web_config.cores
    memory        = var.web_config.memory
    core_fraction = var.web_config.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = local.spe
    ssh-keys           = local.key
  }
}

