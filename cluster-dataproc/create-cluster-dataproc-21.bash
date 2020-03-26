

# Me conecto al proyecto
gcloud config set project dataproc-21
gcloud config set dataproc/region us-central1


PROJECT=$(gcloud config get-value core/project)
CLUSTER=cluster-dataproc-21
REGION=$(gcloud config get-value dataproc/region)


# Creo el cluster dataproc
gcloud dataproc clusters create $CLUSTER \
--region $REGION \
--zone us-central1-b \
--subnet default \
--master-machine-type n1-standard-2 \
--master-boot-disk-type=pd-ssd \
--master-boot-disk-size 100 \
--num-workers 2 --worker-machine-type n1-standard-2 \
--worker-boot-disk-type=pd-ssd \
--worker-boot-disk-size 50 \
--image-version 1.3-deb9 \
--project dataproc-21

# Ver la descripcion del cluster
gcloud dataproc clusters describe $CLUSTER --region=$REGION


# Exportar la descripción
gcloud dataproc clusters export $CLUSTER --region=$REGION --destination values-cluster-$CLUSTER.yaml
