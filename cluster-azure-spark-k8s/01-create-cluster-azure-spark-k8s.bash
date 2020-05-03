#creo el grupo de recursos

az group create \
  --name GrupoRecursosClusterK8s \
  --location eastus

# az network vnet create \
#   --resource-group GrupoRecursosClusterK8s \
#   --name VnetClusterK8s \
#   --address-prefixes 10.0.0.0/8 \
#   --subnet-name SubnetClusterK8s \
#   --subnet-prefix 10.240.0.0/16

#az ad sp create-for-rbac --skip-assignment

#Creo una entidad de servicio para el clúster.
az ad sp create-for-rbac --name SparkSP

{
  "appId": "2ac54dcd-8093-4d7f-90b0-1bf4cdc7820f",
  "displayName": "SparkSP",
  "name": "http://SparkSP",
  "password": "77430068-17f8-45e1-9dd3-a2947578ff09",
  "tenant": "d92b97ff-05b7-4608-a1e2-364285093e48"
}




#Creo el Cluster de Kubernetes
az aks create \
    --resource-group GrupoRecursosClusterK8s \
    --name ClusterK8s \
    --node-vm-size standard_DS2_v2\
    --node-count 2 \
    --service-principal 2ac54dcd-8093-4d7f-90b0-1bf4cdc7820f \
    --client-secret 77430068-17f8-45e1-9dd3-a2947578ff09 \
    --generate-ssh-keys
    #--network-plugin kubenet \
    #--service-cidr 10.0.0.0/16 \
    #--dns-service-ip 10.0.0.10 \
    #--pod-cidr 192.168.0.0/16 \
    #--docker-bridge-address 172.17.0.1/16 \
    #--vnet-subnet-id $SUBNET_ID \


#Me conectamos al cluster
az aks get-credentials \
  --resource-group GrupoRecursosClusterK8s \
  --name ClusterK8s
