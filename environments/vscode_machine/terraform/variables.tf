variable "tenancy_ocid" {
  description = "OCID do seu tenancy"
}

variable "ssh_public_key" {
  description = "Chave pública SSH para acesso à instância"
}

variable "compartiment_id" {
  description = "OCID do seu compartimento"
}

variable "user" {
  description = "OCID do seu usuário"
}
variable "fingerprint" {
  description = "Fingerprint da chave de API"
}
variable "tenancy" {
  description = "OCID do seu tenancy"
}
variable "region" {
  description = "Região onde a instância será criada"
}
variable "key_file" {
  description = "Caminho para o arquivo da chave privada"
}
variable "ssh_key" {
  description = "Caminho para o arquivo da chave privada"
}