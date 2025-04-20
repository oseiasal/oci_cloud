output "ip_da_maquina" {
  value = oci_core_instance.instance.public_ip
}
