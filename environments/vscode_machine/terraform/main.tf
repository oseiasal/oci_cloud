module "vscode_machine" {
    source = "../../../modules/instance"
    compartiment_id = var.compartiment_id
    subnet = module.network.subnet_id
    totalCPUs = 1
    totalRAM = 6
    instance_name = "VSCODE Machine"
    ssh_public_key = var.ssh_public_key
}

module "network" {
    source = "../../../modules/vcn"
    compartiment_id = var.compartiment_id
    tenancy_ocid = var.compartiment_id
    ports = [22, 80, 81, 443, 11434 ]
    network_name = "vscode_network"
}

module "createfile" {
    source = "../../../modules/createfile"
    machine_name = "vscode_machine"
    machine_ip = module.vscode_machine.ip_da_maquina
    output_path  = "${path.module}/../ansible"
}

output "vscode_machine_ip" {
    value = module.vscode_machine.ip_da_maquina
}