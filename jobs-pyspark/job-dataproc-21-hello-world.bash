#!/bin/bash

# Creo las variables de entorno
CLUSTER=cluster-dataproc-21
REGION=$(gcloud config get-value dataproc/region)
FILE_BUCKET=gs://bucket-dataproc-21/hello-world-local.py


gcloud dataproc jobs submit pyspark \
    --cluster $CLUSTER --region $REGION \
    $FILE_BUCKET
