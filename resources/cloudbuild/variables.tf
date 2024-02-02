variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "logique-devops"
}

variable "region" {
  description = "The region the cluster in"
  default     = "asia-southeast2"
}

variable "github_token" {
  description = "The value github_token_secret on secret manager"
  type        = string
  sensitive   = true
}