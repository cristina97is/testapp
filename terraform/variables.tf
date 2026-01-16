variable "cloud_id" {
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  description = "Yandex Folder ID"
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
}
variable "yc_token" {
type = string
sensitive = true
}

