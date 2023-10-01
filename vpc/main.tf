#создаем облачную сеть
resource "yandex_vpc_network" "dev" {
  name = var.network_name
}

#создаем подсеть
resource "yandex_vpc_subnet" "dev" {
  name           = var.subnet_name
  zone           = var.subnet_zone
  network_id     = yandex_vpc_network.dev.id
  v4_cidr_blocks = ["${var.subnet_v4_cidr_blocks}"]
}
