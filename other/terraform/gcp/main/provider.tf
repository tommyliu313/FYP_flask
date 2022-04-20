provider "google" {
    credentials = file("itp4121project-da9e77c5e6ab.json")
    project     = "itp4121project"
    region      = "asia-east2"
    zone        = "asia-east2-a"

}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

# See versions at https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version
resource "google_sql_database_instance" "instance" {
  name             = "mysqlproject"
  region           = "asia-east2"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}
