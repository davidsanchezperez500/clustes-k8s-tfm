variable "project_id" {
  type        = string
  default     = "dataproc-21"
  description = "Identificador del proyecto"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Región por defecto para asignar regiones y zonas"
}

variable "name_cluster" {
  type        = string
  default     = "cluster-dataproc-21"
  description = "Nombre del cluster"
}

variable "staging_bucket" {
  type        = string
  default     = "dataproc-staging-bucket"
  description = "Nombre del bucket"
}

variable "machine_type" {
  type        = string
  default     = "n1-standard-2"
  description = "Tipo de maquinas"
}
