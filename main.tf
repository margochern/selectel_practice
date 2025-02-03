# Создание ключевой пары для доступа к ВМ
module "keypair" {
  source             = "./modules/keypair"
  keypair_name       = "keypair-tf"
  keypair_public_key = file("./keys.pub")
  region             = var.region
}

# Создание приватной сети для ВМ
module "nat" {
  source = "./modules/nat"
}

# Создание первой ВМ (todo-app)
module "todo" {
  source = "./modules/server_remote_root_disk"

  server_name         = "todo-app"
  server_zone         = var.server_zone
  server_vcpus        = var.server_vcpus
  server_ram_mb       = var.server_ram_mb
  server_root_disk_gb = var.server_root_disk_gb
  server_volume_type  = var.server_volume_type
  server_image_name   = var.server_image_name
  server_ssh_key      = module.keypair.keypair_name
  region              = var.region
  network_id          = module.nat.network_id
  subnet_id           = module.nat.subnet_id
  server_preemptible_tag = var.server_preemptible_tag
}

# Создание второй ВМ (mysql-db)
module "db_server" {
  source = "./modules/server_remote_root_disk"

  server_name         = "mysql-db"
  server_zone         = var.server_zone
  server_vcpus        = var.server_vcpus
  server_ram_mb       = var.server_ram_mb
  server_root_disk_gb = var.server_root_disk_gb
  server_volume_type  = var.server_volume_type
  server_image_name   = var.server_image_name
  server_ssh_key      = module.keypair.keypair_name
  region              = var.region
  network_id          = module.nat.network_id
  subnet_id           = module.nat.subnet_id
  server_preemptible_tag = var.server_preemptible_tag
}

# Создание inventory файла для ansible
resource "local_file" "ansible_inventory" {
  content = templatefile("./resources/inventory.tmpl",
    {
      todo_vm_ip_public  = module.todo.floating_ip,
      db_server_vm_ip_public      = module.db_server.floating_ip,
    }
  )
  filename = "./ansible/inventory.ini"
}