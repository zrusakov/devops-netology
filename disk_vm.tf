resource "yandex_compute_disk" "storage" {
  count = 3
  name        = "storage-${count.index + 1}"
  zone       = var.default_zone
  size       = 1
}

resource "yandex_compute_instance" "storage" {
  for_each   = {
    for s in var.storage:
        s.vm_name => s
  }
  name       = each.value.vm_name
  platform_id = var.platform_id_v1
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
	core_fraction = each.value.cf
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
          size = each.value.disk
    }
  }
  dynamic "secondary_disk" {
	for_each = yandex_compute_disk.storage
		content {
		disk_id = secondary_disk.value.id
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
