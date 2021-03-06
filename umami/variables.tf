# Project and provider variables
variable "project" {
  default = "analytics-353001"
}
variable "region" {
  default = "europe-west9"
}
variable "zone" {
  default = "europe-west9-c"
}
variable "json_key_path" {
}

# VM instance variables
variable "instance_image" {
  default = "debian-cloud/debian-11"
}
variable "instance_name" {
  default = "umami-instance"
}
variable "instance_type" {
  default = "e2-small"
}

# Remote connection variables
variable "private_key_path" {
  default = "~/.ssh/wsl2"
}
variable "public_key_path" {
  default = "~/.ssh/wsl2.pub"
}
variable "gce_ssh_user" {
  default = "debian"
}

# Postgresql database variables
variable "db_user" {
}
variable "db_password" {
}
variable "db_name" {
  default = "umami-db"
}
variable "db_version" {
  default = "POSTGRES_11"
}
variable "db_instance_name" {
  default = "umami-db-instance"
}
variable "db_tier" {
  default = "db-f1-micro"
}
