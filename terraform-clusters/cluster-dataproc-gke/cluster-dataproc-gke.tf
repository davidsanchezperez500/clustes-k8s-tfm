provider "google" {
  credentials = file("/home/david/private-keys/credential-terraform-dataproc-gke.json")
}

resource "google_container_cluster" "cluster-dataproc-gke" {
  project     = "${var.project_dataproc_gke}"
  name        = "${var.name_cluster_dataproc_gke}"
  location    = "${var.region}"

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"


resource "google_container_node_pool" "cluster-dataproc-gke-node-pool" {
  name       = "${var.name_cluster}"
  location   = "${var.region}"
  cluster    = google_container_cluster.cluster-dataproc-gke
  node_count = 3

  node_config {
    preemptible  = true
    machine_type = "${var.machine_type}"

    metadata = {
      disable-legacy-endpoints = "true"
    }
    # workload_metadata_config = {
    #   node_metadata = "EXPOSE"
    # }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
