resource "google_container_cluster" "cluster-dataproc-gke" {
  name     = "${var.name_cluster}"
  location = "${var.region}"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1


}


resource "google_container_node_pool" "cluster-dataproc-gke" {
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
