#!/bin/bash
gcloud config set project dataproc-gke
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-b

gcloud beta container clusters create cluster-dataproc-gke \
--machine-type n1-standard-2 \
--preemptible \
--num-nodes 1 \
--workload-metadata-from-node EXPOSED \
--scopes cloud-platform \
--disk-type pd-ssd \
--disk-size 75 \
--region us-central1 \
--node-locations us-central1-b,us-central1-c,us-central1-a
