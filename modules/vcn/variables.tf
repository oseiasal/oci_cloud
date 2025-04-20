variable "tenancy_ocid" {
  description = "OCID do seu tenancy"
}

variable "compartiment_id" {
  description = "OCID do seu compartimento"
}

variable "ports" {
  description = "OCID do seu compartimento"
  default = [22, 80, 81, 443]
}