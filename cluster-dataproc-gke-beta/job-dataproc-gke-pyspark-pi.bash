#!/bin/bash
# Me conecto al proyecto
gcloud config set project dataproc-gke
gcloud config set compute/region us-central1


# Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
GKE_CLUSTER=cluster-$PROJECT
DATAPROC_CLUSTER=dataproc-$GKE_CLUSTER
REGION=$(gcloud config get-value dataproc/region)
BUCKET=bucket-$PROJECT-1
FILE_BUCKET=gs://$BUCKET/pyspark-pi.py


gcloud dataproc jobs submit pyspark \
  --cluster $DATAPROC_CLUSTER $FILE_BUCKET \
  --region $REGION \
