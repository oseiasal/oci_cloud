# Instância
resource "oci_core_instance" "instance" {
  compartment_id      = var.compartiment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape               = "VM.Standard.A1.Flex" # Shape gratuita

  source_details {
    source_id   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa2bkpvolpr3ptdsazup3lt4ae7ljxqziw25rey4nw3zzfzmo6ec6q"
    source_type = "image"
  }

  shape_config {
    ocpus         = var.totalCPUs
    memory_in_gbs = var.totalRAM
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.subnet

  }


  metadata = {
    ssh_authorized_keys = file("~/.ssh/aws_terraform.pub")
  }

  display_name = var.instance_name
}


data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartiment_id
}


