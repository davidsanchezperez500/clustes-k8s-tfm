## Acceder a Jupyter Notebook

###1. Creamos variables de entorno
PROJECT=$(gcloud config get-value core/project)
CLUSTER_M=cluster-$PROJECT-m
REGION=$(gcloud config get-value dataproc/region)
PORT_JUPYTER=8123

###2. Creamos un tunel SSH usando el puerto local 1080
gcloud compute ssh $CLUSTER_M\
  --project=$PROJECT \
  --zone=$REGION-a -- -D 1080 -N

###3. Conectamos Chrome con el proxy
/usr/bin/google-chrome \
  --proxy-server="socks5://localhost:1080" \
  --user-data-dir="/tmp/$CLUSTER_M" http://$CLUSTER_M:$PORT_JUPYTER
