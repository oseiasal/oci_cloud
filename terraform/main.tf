module "network" {
    source = "./modules/vcn"
    compartiment_id = var.compartiment_id
    tenancy_ocid = var.compartiment_id
}

module "instance" {
    source = "./modules/instance"
    compartiment_id = var.compartiment_id
    subnet = module.network.subnet_id
}
module "createfile" {
    source = "./modules/createfile"
    mainmachine_ip = module.instance.mainmachine_public_ip
    n8nmachine_ip = module.instance.n8n_public_ip
}

