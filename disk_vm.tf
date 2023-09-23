resource "yandex_compute_disk" "storage" {
  count = 3
  name        = "storage-${count.index + 1}"
  zone       = var.default_zone
  size       = 1
}

resource "yandex_compute_instance" "storage" {
  name       = "storage"
  platform_id = var.platform_id_v1
  resources {
    cores         = 2
    memory        = 4
	core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  dynamic "secondary_disk" {
	for_each = lookup(each.value, "secondary_disk")
		content {
		disk_id = yandex_compute_disk.storage.id
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
  depends_on = [yandex_compute_disk.storage]
}
