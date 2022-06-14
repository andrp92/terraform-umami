resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.instance.name
  password = var.db_password
  depends_on = [
    google_sql_database_instance.instance
  ]
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.instance.name
  depends_on = [
    google_sql_database_instance.instance
  ]
}

resource "google_sql_database_instance" "instance" {
  provider = google-beta

  name             = "${var.db_instance_name}-${random_id.db_name_suffix.hex}"
  region           = var.region
  database_version = var.db_version
  project          = var.project


  depends_on = [google_service_networking_connection.private_vpc_connection, google_compute_instance.umami-instance]

  settings {
    tier = var.db_tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/${var.project}/global/networks/default"
    }
  }
}
