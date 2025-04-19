module "n8n_machine" {
    source = "../../../modules/instance"
    compartiment_id = var.compartiment_id
    subnet = module.network.subnet_id
    totalCPUs = 1
    totalRAM = 6
    instance_name = "N8N Machine"
    ssh_public_key = var.ssh_public_key
}

module "network" {
    source = "../../../modules/vcn"
    compartiment_id = var.compartiment_id
    tenancy_ocid = var.compartiment_id
    ports = [22, 80, 81, 443]
}

module "createfile" {
    source = "../../../modules/createfile"
    machine_name = "n8n_machine"
    machine_ip = module.n8n_machine.ip_da_maquina
}

output "n8n_machine_ip" {
    value = module.n8n_machine.ip_da_maquina
}