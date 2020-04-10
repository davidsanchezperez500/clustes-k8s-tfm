#!/bin/bash
# Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
BUCKET_NAME=bucket-$PROJECT
REGION=$(gcloud config get-value dataproc/region)
FILE_LOCAL=/home/david/repos/tfm-compara-cloud/jobs-pyspark/hello-world-local.py

# Creo Bucket y subo archivo local
gsutil mb -p $PROJECT -c standard -l $REGION gs://$BUCKET_NAME
gsutil cp  $FILE_LOCAL gs://$BUCKET_NAME
