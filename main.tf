#moduls
module "vpc_dev" {
source = "./vpc"
token     = var.token
cloud_id  = var.cloud_id
folder_id = var.folder_id
network_name = var.network_name
subnet_name = var.subnet_name
subnet_zone = var.subnet_zone
subnet_v4_cidr_blocks = var.subnet_v4_cidr_blocks
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = "${module.vpc_dev.network_id}"
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = ["${module.vpc_dev.subnet_id}"]
  instance_name   = "web"
  instance_count  = 2
  image_family    = "ubuntu-2004-lts"
  public_ip       = true

  metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = 1
  }
}
