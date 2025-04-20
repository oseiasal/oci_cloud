terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}
provider "oci" {
  # config_file_profile = "DEFAULT"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user
  fingerprint      = var.fingerprint
  private_key_path      = var.key_file
  region           = var.region
  
}
