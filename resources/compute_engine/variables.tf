variable "gcp_project_id" {
  default = "logique-devops"
}
variable "region" {
  default = "asia-southeast2"
}
variable "zone" {
  default = "asia-southeast2-a"
}
variable "vm_name" {
  default = "bastion"
}
variable "vm_type" {
  default = "e2-custom-2-1024"
}
variable "vm_image" {
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}
variable "vm_image_type" {
  default = "pd-ssd"
}
variable "service_account_email" {
  default = "270777581819-compute@developer.gserviceaccount.com"
}
variable "metadata_script" {
  default = "autoscript.sh"
}
variable "creds_file" {
  default = ".keys/account.json"
}