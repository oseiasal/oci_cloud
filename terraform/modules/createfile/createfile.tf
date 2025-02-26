output "inventory_ini" {
  value = templatefile("${path.module}/inventory.tpl", {
    webserver_ip       = var.mainmachine_ip
    n8nmachine_ip      = var.n8nmachine_ip
  })
}

resource "local_file" "inventory_ini" {
  content  = templatefile("${path.module}/inventory.tpl", {
    webserver_ip       = var.mainmachine_ip
    n8nmachine_ip      = var.n8nmachine_ip
  })

  filename = "../ansible/inventory.ini"
}