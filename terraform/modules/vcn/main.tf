resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartiment_id
  cidr_block     = "10.0.0.0/16"
  display_name   = "tf-vcn"
  dns_label      = "internal"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartiment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "internet-gateway"
}

resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartiment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "default-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "subnet" {
  compartment_id             = var.compartiment_id
  vcn_id                     = oci_core_vcn.vcn.id
  cidr_block                 = "10.0.1.0/24"
  display_name               = "public-subnet"
  route_table_id             = oci_core_route_table.route_table.id
  prohibit_public_ip_on_vnic = false  # Permite IP público
  security_list_ids          = [oci_core_security_list.security_list.id, oci_core_security_list.openvpn_security_list.id] 
}

# resource "oci_core_security_list" "security_list" {
#   compartment_id = var.compartiment_id
#   vcn_id         = oci_core_vcn.vcn.id
#   display_name   = "lista-de-seguranca"

#   ingress_security_rules {
#     protocol = "6"  # TCP
#     source   = "0.0.0.0/0"  

#     tcp_options {
#       min = 22  # Porta SSH
#       max = 22
#     }
#   }

#   ingress_security_rules {
#     protocol = "6"  # TCP
#     source   = "0.0.0.0/0"  

#     tcp_options {
#       min = 443  # Porta SSH
#       max = 443
#     }
#   }

#   ingress_security_rules {
#     protocol = "6"  # TCP
#     source   = "0.0.0.0/0"  

#     tcp_options {
#       min = 81  # Porta SSH
#       max = 81
#     }
#   }
#   ingress_security_rules {
#     protocol = "6"  # TCP
#     source   = "0.0.0.0/0"  

#     tcp_options {
#       min = 5678  # Porta SSH
#       max = 5678
#     }
#   }
#   ingress_security_rules {
#     protocol = "6"  
#     source   = "0.0.0.0/0"  

#     tcp_options {
#       min = 80  
#       max = 80
#     }
#   }

#   ingress_security_rules {
#     protocol = "6"  
#     source   = "0.0.0.0/0"  

#     tcp_options {
#       min = 8080  
#       max = 8080
#     }
#   }

#   egress_security_rules {
#     protocol    = "all"
#     destination = "0.0.0.0/0"
#   }
# }


resource "oci_core_security_list" "openvpn_security_list" {
  compartment_id = var.compartiment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "openvpn-security-list"

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"  # Permitir tráfego de qualquer IP (ajuste conforme necessário)
    stateless = false
    tcp_options {
      min = 1194
      max = 1194
    }
  }

  ingress_security_rules {
    protocol = "17" # UDP
    source   = "0.0.0.0/0"  # Permitir tráfego de qualquer IP (ajuste conforme necessário)
    stateless = false
    udp_options {
      min = 1194
      max = 1194
    }
  }

    ingress_security_rules {
    protocol = "6"  # TCP/UDP, 6 for both
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 51820
      max = 51820
    }
  }

  ingress_security_rules {
    protocol = "17"  # UDP (17)
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
  }

}


resource "oci_core_security_list" "security_list" {
  compartment_id = var.compartiment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "lista-de-seguranca"

  dynamic "ingress_security_rules" {
    for_each = [22, 443, 81, 5678, 80, 8080, 9100, 9090]
    content {
      protocol = "6"  # TCP
      source   = "0.0.0.0/0"

      tcp_options {
        min = ingress_security_rules.value
        max = ingress_security_rules.value
      }
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

