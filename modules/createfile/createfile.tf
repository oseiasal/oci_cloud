resource "local_file" "inventory_ini" {
  content  = templatefile("${path.module}/inventory.tpl", {
    machine_ip      = var.machine_ip
  })

   filename = "${var.output_path}/${var.machine_name}.ini"
}

variable "output_path" {
  type = string
}