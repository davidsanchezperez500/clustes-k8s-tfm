#!/bin/bash

# Me conecto al proyecto
gcloud config set project dataproc-gke
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-b

# Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
REGION=$(gcloud config get-value compute/region)
CLUSTER=cluster-$PROJECT
DEPLOYMENT=deployment-$PROJECT

#Elimino el cluster gke
gcloud beta container clusters delete $CLUSTER \
--region $REGION \
#--zone $REGION-b,$REGION-c,$REGION-a

#Elimino el deployment
helm delete $PROJECT

#Elimino el cluster dataproc
gcloud dataproc clusters delete $CLUSTER
