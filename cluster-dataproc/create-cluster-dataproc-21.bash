# Me conecto al proyecto
gcloud config set project dataproc-21
gcloud config set dataproc/region us-central1


# Declaro las variables
PROJECT=$(gcloud config get-value core/project)
CLUSTER=cluster-$PROJECT
REGION=$(gcloud config get-value dataproc/region)
MACHINE_TIPE=n1-standard-2
BUCKET_NAME=bucket-$PROJECT


# Creo el cluster dataproc
gcloud beta dataproc clusters create $CLUSTER \
--project $PROJECT \
--bucket $BUCKET \
--optional-components=ANACONDA,JUPYTER \
--enable-component-gateway \
--region $REGION \
--zone $REGION-b \
--subnet default \
--master-machine-type $MACHINE_TIPE \
--master-boot-disk-type=pd-ssd \
--master-boot-disk-size 100 \
--num-workers 2 --worker-machine-type $MACHINE_TIPE \
--worker-boot-disk-type=pd-ssd \
--worker-boot-disk-size 50 \
--image-version 1.4-ubuntu18 \
--scopes 'https://www.googleapis.com/auth/cloud-platform'


# Ver la descripcion del cluster
gcloud beta dataproc clusters describe $CLUSTER --region=$REGION

#Exporta la descripcion
gcloud beta dataproc clusters describe $CLUSTER --region=$REGION > description-cluster-$CLUSTER.yaml

# Exportar la configuración
gcloud beta dataproc clusters export $CLUSTER --region=$REGION --destination values-cluster-$CLUSTER.yaml
