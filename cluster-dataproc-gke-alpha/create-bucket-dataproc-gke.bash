#!/bin/bash
# Me conecto al proyecto
gcloud config set project dataproc-gke
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-b

# Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
BUCKET_NAME=bucket-$PROJECT-1
FILE_LOCAL=/home/david/repos/tfm-compara-cloud/jobs-pyspark/hello-world-local.py
REGION=us-central1

# Creo Bucket y subo archivo local
gsutil mb -p $PROJECT -c standard -l $REGION gs://$BUCKET_NAME
gsutil cp  $FILE_LOCAL gs://$BUCKET_NAME
