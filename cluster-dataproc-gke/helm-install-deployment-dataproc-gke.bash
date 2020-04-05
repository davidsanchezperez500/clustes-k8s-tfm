#!/bin/bash
# Me conecto al proyecto
gcloud config set project dataproc-gke
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-b

#Creo namespace
kubectl create namespace spark

#Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
CLUSTER=cluster-$PROJECT
REGION=us-central1
NAMESPACE=spark
BUCKET_NAME=bucket-$PROJECT-1
DEPLOYMENT=deployment-$PROJECT
PROVIDED_TOKEN=af447856907ac92bc1e3f7c4677cb637067ac09b7cd727959c7e8a298f870c29

#Instalo el deploy con Helm
helm install  $DEPLOYMENT dataproc/dataproc-sparkoperator --namespace $NAMESPACE \
--set projectId=$PROJECT \
--set clusterName=$CLUSTER \
--set dataprocRegion=$REGION \
--set sparkJobNamespace=$NAMESPACE \
--set bucket=$BUCKET_NAME \
--set alphaWhitelistToken=$PROVIDED_TOKEN \
--set operatorVersion=latest
