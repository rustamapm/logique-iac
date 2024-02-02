variable "project_name" {
  type        = string
  default     = "logique-devops"
}

variable "name_cloudsql" {
  type        = string
  default     = "db-logique"
}

variable "project_id" {
  type        = string
  default     = "logique-devops"
}

variable "region_name" {
  type        = string
  default     = "asia-southeast2"
}

variable "zone_name" {
  type        = string
  default     = "asia-southeast2-a"
}

variable "tier" {
  type        = string
  description = "Machine type CLoudSQL. Example=db-f1-micro, db-g1-small, db-n1-standard-1, db-n1-standard-2, db-n1-standard-4, db-n1-standard-8, db-custom-1-4096 multiple 256 for custm image"
  default     = "db-custom-1-4096"
}


variable "disk_size_gb" {
    type            = number
    default         = 10
}

variable "disk_type" {
  description = "The disk type for the master instance. The type of data disk: PD_SSD or PD_HDD"
  type        = string
  default     = "PD_SSD"
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size"
  type        = bool
  default     = true
}

variable "deletion_protection" {
    type            = bool
    default         = false
}

variable "database_version" {
    type            = string
    description     = "Database version. Example:MYSQL_5_6, MYSQL_5_7,  POSTGRES_9_6, POSTGRES_10, POSTGRES_11, POSTGRES_12, SQLSERVER_2017_STANDARD, SQLSERVER_2017_WEB"
    default         = "POSTGRES_15"
}
variable "ipv4_enabled" {
    type            = string
    description     = "Database version. Example:MYSQL_5_6, MYSQL_5_7,  POSTGRES_9_6, POSTGRES_10, POSTGRES_11, POSTGRES_12, SQLSERVER_2017_STANDARD, SQLSERVER_2017_WEB"
    default         = "false"
}
variable "availability_type" {
    type            = string
    description     = "Availability type ZONAL=non-HA or REGIONAL=HA"
    default         = "ZONAL"
}

variable "maintenance_window_day" {
    type            = number
    description     = "The day of week (1-7) for the master instance maintenance, starting on Monday"
    default         = 7
}

variable "maintenance_window_hour" {
    type            = number
    description     = "The hour of day (0-23) maintenance window for the master instance maintenance, UTC +0"
    default         = 20
}

variable "private_network" {
    type            = string
    description     = "private network subnet for your VPC"
    default         = "projects/logique-413015/global/networks/default"
}

variable "backup_configuration_enabled" {
    type            = bool
    description     = "True if backup configuration is enabled"
    default         = true
}

variable "backup_configuration_start_time" {
    type            = string
    description     = "format time indicating when backup configuration starts"
    default         = "03:00"
}

variable "backup_configuration_location" {
    type            = string
    description     = "The region where the backup will be stored"
    default         = null
}

variable "backup_configuration_pit_recovery_enabled" {
    type            = bool
    description     = "True if Point-in-time recovery is enabled. Will restart database if enabled after instance creation. Valid only for PostgreSQL instances"
    default         = true
}

variable "backup_configuration_log_rentention_days" {
    type            = string
    description     = "The number of days of transaction logs we retain for point in time restore, from 1-7"
    default         = 5
}

variable "backup_configuration_retention_retained_backup" {
    type            = number
    description     = "Depending on the value of retention_unit, this is used to determine if a backup needs to be deleted. If retention_unit is 'COUNT', we will retain this many backups"
    default         = 7
}

variable "backup_configuration_retention_unit" {
    type            = string
    description     = "The unit that 'retained_backups' represents"
    default         = "COUNT"
}