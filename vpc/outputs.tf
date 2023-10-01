output "network_id" {
  value = yandex_vpc_network.dev.id
}

output "subnet_name" {
  value = yandex_vpc_subnet.dev.name
}

output "subnet_id" {
  value = yandex_vpc_subnet.dev.id
}

output "subnet_zone" {
  value = yandex_vpc_subnet.dev.zone
}

output "subnet_v4_cidr_blocks" {
  value = yandex_vpc_subnet.dev.v4_cidr_blocks
}
