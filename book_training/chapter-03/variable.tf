variable "client_id" {}
variable "client_secret" {}
variable "ssh-public_key" {
    default = "~/.ssh/id_rsa.pub"
}
variable "dns_prefix" {
    default = "aks"
}
variable "cluster_name" {
    default = "aks"
}
variable "resource_group_name" {
    default = "ResourceGroup-Chapter03"
}
variable "location" {
    default = "japaneast"
}
