provider "google" {
  project     = "${var.project_id}"
  region      = "${var.region}"
  zone        = "${var.region}-b"
  credentials = file("/home/david/private-keys/credential-terraform-dataproc-gke.json")
}
