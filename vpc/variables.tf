##cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "network_name" {
  type        = string
  description = "yandex_vpc_network name"
}

variable "subnet_name" {
  type        = string
  description = "yandex_vpc_subnet name"
}

variable "subnet_zone" {
  type        = string
  description = "yandex_vpc_subnet zone"
}

variable "subnet_v4_cidr_blocks" {
  type        = string
  description = "yandex_vpc_subnet v4_cidr_blocks"
}
