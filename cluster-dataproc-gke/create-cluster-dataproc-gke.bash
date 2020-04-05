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
gcloud beta container clusters create $CLUSTER \
--machine-type $MACHINE_TIPE \
--preemptible \
--num-nodes 1 \
--workload-metadata-from-node EXPOSED \
--scopes cloud-platform \
--disk-type pd-ssd \
--disk-size 75 \
--region $REGION \
--node-locations $REGION-b,$REGION-c,$REGION-a \
