variable "project_id" {
  type          = string
  default       = "dataproc-21"
  description   = "Identificador del proyecto"

}

variable "region" {
  type          = string
  default       = "us-central1"
  description   = "Región por defecto para asignar regiones y zonas"
}
