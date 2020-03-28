provider "google" {
  project     = "${var.project_dataproc}"
  region      = "${var.region}"
  zone        = "${var.region}-b"
  credentials = file("/home/david/private-keys/credential-terraform-dataproc-21.json")
}

resource "google_dataproc_cluster" "cluster-dataproc" {
  name   = "${var.name_cluster_dataproc}"
  region = "${var.region}"
  labels = {
    foo = "bar"
  }

  cluster_config {
    #staging_bucket = "${var.staging_bucket}"

    master_config {
      num_instances = 1
      machine_type  = "${var.machine_type}"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 100
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = "${var.machine_type}"
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 50
        num_local_ssds    = 1
      }
    }

    # Override or set some custom properties
    software_config {
      image_version = "1.3.7-deb9"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    gce_cluster_config {
      tags = ["foo", "bar"]
      service_account_scopes = [
        "https://www.googleapis.com/auth/monitoring",
        "useraccounts-ro",
        "storage-rw",
        "logging-write",
      ]
    }

    # You can define multiple initialization_action blocks
    #initialization_action {
    #script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
    #timeout_sec = 500
    #}
  }
}
