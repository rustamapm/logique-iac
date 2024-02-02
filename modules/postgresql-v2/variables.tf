variable "project_id" {
  description = "The project ID to manage the Cloud SQL resources"
  type        = string
}

variable "name_cloudsql" {
  type        = string
  description = "The name of the Cloud SQL resources"
}

variable "private_network" {
  type        = string
  description = "The name of the Private Network resources"
}

variable "backup_configuration_enabled" {
  type        = bool
}

variable "backup_configuration_start_time" {
  type        = string
}

variable "backup_configuration_location" {
  type        = string
}

variable "backup_configuration_pit_recovery_enabled" {
  type        = bool
}

variable "backup_configuration_log_rentention_days" {
  type        = string
}

variable "backup_configuration_retention_retained_backup" {
  type        = number
}

variable "backup_configuration_retention_unit" {
  type        = string
}

// required
variable "database_version" {
  description = "The database version to use"
  type        = string
}

// required
variable "region" {
  description = "The region of the Cloud SQL resources"
  type        = string
  default     = "asia-southeast2"
}

// Master
variable "tier" {
  description = "The tier for the master instance."
  type        = string
  default     = ""
}

variable "zone" {
  description = "The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`."
  type        = string
  default     = ""
}

variable "activation_policy" {
  description = "The activation policy for the master instance. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  type        = string
  default     = "ALWAYS"
}

variable "availability_type" {
  description = "The availability type for the master instance. Can be either `REGIONAL` or `null`."
  type        = string
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size"
  type        = bool
  #default     = true
}

variable "disk_size" {
  description = "The disk size for the master instance"
  type        = number
}

variable "disk_type" {
  description = "The disk type for the master instance."
  type        = string
  #default     = "PD_SSD"
}

variable "pricing_plan" {
  description = "The pricing plan for the master instance."
  type        = string
  default     = "PER_USE"
}

variable "maintenance_window_day" {
  description = "The day of week (1-7) for the master instance maintenance."
  type        = number
}

variable "maintenance_window_hour" {
  description = "The hour of day (0-23) maintenance window for the master instance maintenance."
  type        = number
}

variable "maintenance_window_update_track" {
  description = "The update track of maintenance window for the master instance maintenance. Can be either `canary` or `stable`."
  type        = string
  default     = "canary"
}

variable "database_flags" {
  description = "List of Cloud SQL flags that are applied to the database server. See [more details](https://cloud.google.com/sql/docs/mysql/flags)"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}


variable "user_labels" {
  type        = map(string)
  default     = {}
  description = "The key/value labels for the master instances."
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  type = object({
    binary_log_enabled = bool
    enabled            = bool
    start_time         = string
    location           = string
  })
  default = {
    binary_log_enabled = true
    enabled            = true
    start_time         = null
    location           = null
  }
}

variable "ip_configuration" {
  description = "The ip_configuration settings subblock"
  type = object({
    authorized_networks = list(map(string))
    ipv4_enabled        = bool
    private_network     = string
    require_ssl         = bool
  })
  default = {
    authorized_networks = []
    ipv4_enabled        = false
    private_network     = null
    require_ssl         = null
  }
}

// Read Replicas
variable "read_replicas" {
  description = "List of read replicas to create"
  type = list(object({
    name            = string
    tier            = string
    zone            = string
    disk_type       = string
    disk_autoresize = bool
    disk_size       = string
    user_labels     = map(string)
    database_flags = list(object({
      name  = string
      value = string
    }))
    ip_configuration = object({
      authorized_networks = list(map(string))
      ipv4_enabled        = bool
      private_network     = string
      require_ssl         = bool
    })
  }))
  default = []
}

// variable "var.name_read_replica" {
//   description = "The optional read instance name"
//   type        = string
//   default     = ""
// }

// variable "db_name" {
//   description = "The name of the default database to create"
//   type        = string
// }

variable "db_charset" {
  description = "The charset for the default database"
  type        = string
  default     = ""
}

variable "db_collation" {
  description = "The collation for the default database. Example: 'utf8_general_ci'"
  type        = string
  default     = ""
}

variable "additional_databases" {
  description = "A list of databases to be created in your cluster"
  type = list(object({
    name      = string
    charset   = string
    collation = string
  }))
  default = []
}

variable "user_name" {
  description = "The name of the default user"
  type        = string
  default     = "default"
}

variable "user_host" {
  description = "The host for the default user"
  type        = string
  default     = "satrio.wicaksono@bankina.id"
}

variable "user_password" {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  type        = string
  default     = ""
}

variable "additional_users" {
  description = "A list of users to be created in your cluster"
  type = list(object({
    name     = string
    password = string
    host     = string
  }))
  default = []
}

variable "create_timeout" {
  description = "The optional timout that is applied to limit long database creates."
  type        = string
  default     = "10m"
}

variable "update_timeout" {
  description = "The optional timout that is applied to limit long database updates."
  type        = string
  default     = "10m"
}

variable "delete_timeout" {
  description = "The optional timout that is applied to limit long database deletes."
  type        = string
  default     = "10m"
}

variable "encryption_key_name" {
  description = "The full path to the encryption key used for the CMEK disk encryption"
  type        = string
  default     = null
}

variable "module_depends_on" {
  description = "List of modules or resources this module depends on."
  type        = list(any)
  default     = []
}

variable "deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance."
  type        = bool
  default     = true
}

variable "read_replica_deletion_protection" {
  description = "Used to block Terraform from deleting replica SQL Instances."
  type        = bool
  default     = false
}