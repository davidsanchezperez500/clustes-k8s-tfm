variable "project_dataproc" {
  type        = string
  default     = "dataproc-21"
  description = "Identificador del proyecto Dataproc"
}
variable "project_dataproc_gke" {
  type        = string
  default     = "dataproc-gke"
  description = "Identificador del proyecto GKE"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Región por defecto para asignar regiones y zonas"
}

variable "name_cluster_dataproc" {
  type        = string
  default     = "cluster-dataproc-21"
  description = "Nombre del cluster dataproc"
}

variable "name_cluster_dataproc_gke" {
  type        = string
  default     = "cluster-dataproc-gke"
  description = "Nombre del cluster GKE"
}

variable "staging_bucket_dataproc" {
  type        = string
  default     = "bucket-dataproc-21"
  description = "Nombre del bucket"
}
variable "staging_bucket_dataproc_gke" {
  type        = string
  default     = "bucket-dataproc-gke"
  description = "Nombre del bucket"
}

variable "machine_type" {
  type        = string
  default     = "n1-standard-2"
  description = "Tipo de maquinas"
}
