#!/bin/bash
#Creo namespace
#kubectl create namespace spark

#Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
CLUSTER=cluster-dataproc-gke
REGION=us-central1
NAMESPACE=spark
BUCKET=bucket-dataproc-gke
DEPLOYMENT=deployment-dataproc-gke
PROVIDED_TOKEN=af447856907ac92bc1e3f7c4677cb637067ac09b7cd727959c7e8a298f870c29

#Instalo el deploy con Helm 
helm install  $DEPLOYMENT dataproc/dataproc-sparkoperator --namespace $NAMESPACE \
--set projectId=$PROJECT \
--set clusterName=$CLUSTER \
--set dataprocRegion=$REGION \
--set sparkJobNamespace=$NAMESPACE \
--set bucket=$BUCKET \
--set alphaWhitelistToken=$PROVIDED_TOKEN
