#!/bin/bash

# Me conecto al proyecto
gcloud config set project dataproc-gke

PROJECT=$(gcloud config get-value core/project)
REGION=$(gcloud config get-value compute/region)
BUCKET=bucket-$PROJECT-1

GKE_CLUSTER=cluster-$PROJECT

DATAPROC_CLUSTER=dataproc-$GKE_CLUSTER
DATAPROC_VERSION="1.4.27-beta"
NAMESPACE=spark

MACHINE_TIPE=n1-standard-2
DISK_TYPE="pd-ssd"
SCOPES=cloud-platform



# Creo el cluster dataproc
gcloud beta dataproc clusters create $DATAPROC_CLUSTER \
--project $PROJECT \
--gke-cluster=$GKE_CLUSTER \
--bucket $BUCKET \
--gke-cluster-namespace=$NAMESPACE \
--region $REGION \
--image-version $DATAPROC_VERSION
