module "n8n_machine" {
    source = "../modules/instance"
    compartiment_id = var.compartiment_id
    subnet = module.network.subnet_id
    totalCPUs = 1
    totalRAM = 6
    instance_name = "N8N Machine"
}

module "network" {
    source = "../modules/vcn"
    compartiment_id = var.compartiment_id
    tenancy_ocid = var.compartiment_id
}

module "createfile" {
    source = "../modules/createfile"
    machine_name = "n8n_machine"
    machine_ip = module.n8n_machine.ip_da_maquina
}