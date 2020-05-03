  #!/bin/bash

# Me conecto al proyecto
gcloud config set project dataproc-gke


# Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
REGION=$(gcloud config get-value compute/region)
BUCKET=bucket-$PROJECT-1

GKE_CLUSTER=cluster-$PROJECT
GKE_CLUSTER_VERSION="1.14.10-gke.27"
GKE_IMAGE_TYPE="COS"

DATAPROC_CLUSTER=dataproc-$GKE_CLUSTER
DATAPROC_VERSION="1.4.27-beta"

MACHINE_TIPE=n1-standard-2
DISK_TYPE="pd-ssd"
SCOPES=cloud-platform

NAMESPACE=spark

#Creo el cluste en gke

gcloud beta container --project $PROJECT clusters create $GKE_CLUSTER \
--region $REGION \
--no-enable-basic-auth \
--cluster-version $GKE_CLUSTER_VERSION \
--machine-type $MACHINE_TIPE \
--image-type $GKE_IMAGE_TYPE \
--disk-type $DISK_TYPE \
--metadata disable-legacy-endpoints=true \
--preemptible \
--num-nodes 1 \
--enable-stackdriver-kubernetes \
--enable-ip-alias \
--workload-metadata-from-node GCE_METADATA \
--addons HorizontalPodAutoscaling,HttpLoadBalancing \
--scopes $SCOPES \
--disk-type pd-ssd \
--disk-size 75 \
--region $REGION \
--enable-autoupgrade \
--enable-autorepair \
--node-locations $REGION-b,$REGION-c,$REGION-a \

#creo el namespace
kubectl create namespace spark

# 
# gcloud beta dataproc clusters export $DATAPROC_CLUSTER --region=$REGION --destination values-cluster-$DATAPROC_CLUSTER.yaml
#
# gcloud beta dataproc clusters describe $DATAPROC_CLUSTER --region=$REGION > description-cluster-$DATAPROC_CLUSTER.yaml
