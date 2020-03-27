#!/bin/bash
# Me conecto al proyecto
gcloud config set project dataproc-gke
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-b

# Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
CLUSTER=cluster-$PROJECT
REGION=$(gcloud config get-value dataproc/region)
FILE_BUCKET=gs://bucket-$PROJECT-1/hello-world-local.py


gcloud dataproc jobs submit spark \
    --cluster $CLUSTER  \
    --class org.apache.spark.examples.SparkPi \
    --jars file:///usr/lib/spark/examples/jars/spark-examples.jar
