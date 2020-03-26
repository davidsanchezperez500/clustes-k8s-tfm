#!/bin/bash

# Creo las variables de entorno
CLUSTER=cluster-dataproc-gke
REGION=$(gcloud config get-value dataproc/region)
FILE_BUCKET=gs://bucket-dataproc-gke-1/hello-world-local.py


gcloud dataproc jobs submit pyspark \
    --cluster $CLUSTER --region $REGION \
    $FILE_BUCKET
