output "inventory_ini" {
  value = templatefile("${path.module}/inventory.tpl", {
    machine_ip      = var.machine_ip
    # machine_name    = var.machine_name
  })
}

resource "local_file" "inventory_ini" {
  content  = templatefile("${path.module}/inventory.tpl", {
    machine_ip      = var.machine_ip
  })

  filename = "../../ansible/${var.machine_name}.ini"
}