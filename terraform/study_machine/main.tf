module "study_machine" {
    source = "../modules/instance"
    compartiment_id = var.compartiment_id
    subnet = module.network.subnet_id
    totalCPUs = 1
    totalRAM = 6
    instance_name = "Estudos Machine"
}

module "network" {
    source = "../modules/vcn"
    compartiment_id = var.compartiment_id
    tenancy_ocid = var.compartiment_id
}

module "createfile" {
    source = "../modules/createfile"
    machine_name = "study_machine"
    machine_ip = module.study_machine.ip_da_maquina
}