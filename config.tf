data template_file "cloudinit" {
  template = file("${path.module}/cloud-init.yml")

  vars = {
    username           = var.username
    ssh_public_key     = file(var.ssh_public_key)
    packages           = jsonencode(var.packages)
  }
}
