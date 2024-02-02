module "private_cloudsql" {
  source                  = "../../modules/postgresql-v2"
  name_cloudsql           = var.name_cloudsql
  project_id              = var.project_name
  disk_size               = var.disk_size_gb
  disk_type               = var.disk_type
  disk_autoresize         = var.disk_autoresize
  deletion_protection     = var.deletion_protection
  database_version        = var.database_version
  region                  = var.region_name
  zone                    = var.zone_name
  tier                    = var.tier
  maintenance_window_day  = var.maintenance_window_day
  maintenance_window_hour = var.maintenance_window_hour
  availability_type       = var.availability_type
  private_network         = var.private_network

  backup_configuration_enabled                    = var.backup_configuration_enabled
  backup_configuration_start_time                 = var.backup_configuration_start_time
  backup_configuration_location                   = var.backup_configuration_location
  backup_configuration_pit_recovery_enabled       = var.backup_configuration_pit_recovery_enabled
  backup_configuration_log_rentention_days        = var.backup_configuration_log_rentention_days
  backup_configuration_retention_retained_backup  = var.backup_configuration_retention_retained_backup
  backup_configuration_retention_unit             = var.backup_configuration_retention_unit
}
