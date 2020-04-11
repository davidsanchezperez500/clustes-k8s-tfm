  #!/bin/bash

# Me conecto al proyecto
gcloud config set project dataproc-gke
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-b

# Creo las variables de entorno
PROJECT=$(gcloud config get-value core/project)
REGION=$(gcloud config get-value compute/region)
CLUSTER=cluster-$PROJECT
BUCKET_NAME=bucket-$PROJECT-1
MACHINE_TIPE=n1-standard-2

#Creo el cluste en gke


gcloud beta container --project "dataproc-gke" clusters create "cluster-dataproc-gke" \
--zone "us-central1-b" \
--no-enable-basic-auth \
--cluster-version "1.14.10-gke.27" \
--machine-type "n1-standard-2" \
--image-type "COS" \
--disk-type "pd-ssd" \
--disk-size "75" \
--metadata disable-legacy-endpoints=true \
--scopes "https://www.googleapis.com/auth/cloud-platform" \
--preemptible \
--num-nodes "1" \
--enable-stackdriver-kubernetes \
--enable-ip-alias \
--network "projects/dataproc-gke/global/networks/default" \
--subnetwork "projects/dataproc-gke/regions/us-central1/subnetworks/default" \
--default-max-pods-per-node "110" \
--no-enable-master-authorized-networks \
--addons HorizontalPodAutoscaling,HttpLoadBalancing \
--enable-autoupgrade \
--enable-autorepair \
--workload-metadata-from-node EXPOSED \
--node-locations "us-central1-b","us-central1-a","us-central1-c" \




# gcloud beta container clusters create $CLUSTER \
# --machine-type $MACHINE_TIPE \
# --preemptible \
# --num-nodes 1 \
# --workload-metadata-from-node EXPOSED \
# --scopes cloud-platform \
# --disk-type pd-ssd \
# --disk-size 75 \
# --region $REGION \
# --node-locations $REGION-b,$REGION-c,$REGION-a \
