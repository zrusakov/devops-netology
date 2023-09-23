resource "yandex_compute_instance" "db" {
  for_each   = {
    for z in var.db: 
	z.vm_name => z
  }
  name       = each.value.vm_name
  platform_id = var.platform_id_v1
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
          size = each.value.disk
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
  depends_on = [yandex_compute_instance.web]
}
