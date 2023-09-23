###cloud vars
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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###compute vars
variable "image_name" {
  type = string
  default = "ubuntu-2004-lts"
  description = "ubuntu release name"
}

variable "web_config" {
  type = map(number)
  default = {
    cores = "2"
    memory = "1"
    core_fraction = "5"
        }
  description = "compute config cpu/ram/core fraction for web"
}

variable "platform_id_v1" {
  type        = string
  default     = "standard-v1"
  description = "type of vm_db_ CPU platform https://cloud.yandex.ru/docs/compute/concepts/vm-platforms"
}

variable "db" {
  type = list(object({ 
	vm_name=string, 
	cpu=number, 
	ram=number, 
	disk=number }))
  default = [
    {
	vm_name= "main", 
	cpu= "2", 
	ram= "2", 
	disk= "35"
    },
    {
	vm_name= "replica", 
	cpu= "4", 
	ram= "4", 
	disk= "45"
    }
  ]
  description = "compute config cpu/ram/core fraction for db"
}
