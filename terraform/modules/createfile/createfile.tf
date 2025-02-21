output "inventory_ini" {
  value = templatefile("${path.module}/inventory.tpl", {
    webserver_ip       = var.mainmachine_ip
    n8nmachine_ip      = var.n8nmachine_ip
    client1_public_key = "8WZfO5c4bi+/djOcjQPIhukP2BGMXoISsD+qpK7aI1c="
    client2_public_key = "8WZfO5c4bi+/djOcjQPIhukP2BGMXoISsD+qpK7aI1c="
  })
}

resource "local_file" "inventory_ini" {
  content  = templatefile("${path.module}/inventory.tpl", {
    webserver_ip       = var.mainmachine_ip
    n8nmachine_ip      = var.n8nmachine_ip
    client1_public_key = "8WZfO5c4bi+/djOcjQPIhukP2BGMXoISsD+qpK7aI1c="
    client2_public_key = "8WZfO5c4bi+/djOcjQPIhukP2BGMXoISsD+qpK7aI1c="
  })

  filename = "../ansible/inventory.ini"
}