#!/bin/bash
# Me conecto al proyecto
gcloud config set project dataproc-gke
gcloud config set compute/region us-central1


# Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)

GKE_CLUSTER=cluster-$PROJECT
DATAPROC_CLUSTER=dataproc-$GKE_CLUSTER

REGION=$(gcloud config get-value dataproc/region)


gcloud dataproc jobs submit spark \
    --cluster $DATAPROC_CLUSTER  \
    --region $REGION \
    --class org.apache.spark.examples.SparkPi \
    --jars file:///usr/lib/spark/examples/jars/spark-examples.jar
