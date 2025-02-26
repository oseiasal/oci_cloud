output "n8n_public_ip" {
  value = oci_core_instance.n8nmachine.public_ip
}

output "mainmachine_public_ip" {
  value = oci_core_instance.mainmachine.public_ip
}