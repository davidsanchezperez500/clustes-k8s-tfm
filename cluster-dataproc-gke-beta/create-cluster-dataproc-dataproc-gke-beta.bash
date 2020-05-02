#!/bin/bash

# Me conecto al proyecto
gcloud config set project dataproc-gke

PROJECT=$(gcloud config get-value core/project)
REGION=$(gcloud config get-value compute/region)
DATAPROC_CLUSTER=dataproc3
VERSION="1.4.27-beta"
BUCKET_NAME=bucket-$PROJECT-1
GKE_CLUSTER=gke


gcloud beta dataproc clusters create $DATAPROC_CLUSTER \
    --gke-cluster=$GKE_CLUSTER\
    --region $REGION \
    --image-version=$VERSION \
    --bucket=$BUCKET_NAME \
