#!/bin/bash
#Creo namespace
kubectl create namespace spark

#Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
CLUSTER=cluster-dataproc-gke
REGION=us-central1
BUCKET=bucket-dataproc-gke
DEPLOYMENT=deployment-dataproc-gke
NAMESPACE=saprk

helm install  "${DEPLOYMENT}" dataproc/dataproc-sparkoperator \
--set sparkJobNamespace=default \
--set projectId="${PROJECT}" \
--set dataprocRegion="${REGION}" \
--set bucket="${BUCKET}" \
--set clusterName="${CLUSTER}" \
--set namespace="${NAMESPACE}"
