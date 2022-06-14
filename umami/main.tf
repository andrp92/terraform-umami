# Set provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.24.0"
    }
  }
}
provider "google" {
  credentials = file("${var.json_key_path}")
  project     = var.project
  region      = var.region
  zone        = var.zone
}

# Enable api services required for terraform provisioning
resource "google_project_service" "api-services" {
  for_each = toset([
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sqladmin.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
  ])
  disable_on_destroy = false
  service            = each.value
}

# Create VM with debian image and attach a disk and network interface
resource "google_compute_instance" "umami-instance" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.instance_image
    }
  }
  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${file(var.public_key_path)}"
  }
  network_interface {
    network = "default" # Enables private ip address
    access_config {}    # Enables external ip address
  }
  tags       = ["umami", "web"]
  depends_on = [google_project_service.api-services]
}
