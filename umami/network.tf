# Setup firewall rules for securing connection and openning just required ports
resource "google_compute_firewall" "allow-http" {
  name          = "${var.project}-allow-http"
  network       = "default"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_tags = ["web"]
}
resource "google_compute_firewall" "allow-ssh" {
  name          = "${var.project}-allow-ssh"
  direction     = "INGRESS"
  network       = "default"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# Setup private IP for VPN peering
resource "google_compute_global_address" "private_ip_address" {

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "default"
}

# Setup private VPC network for VM - DB communication
resource "google_service_networking_connection" "private_vpc_connection" {

  network                 = "default"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
