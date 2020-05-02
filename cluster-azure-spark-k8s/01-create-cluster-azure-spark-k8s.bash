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
"appId": "2bc77b48-abc7-4640-a0b9-dac75a3d0a39",
"displayName": "SparkSP",
"name": "http://SparkSP",
"password": "831effea-7292-4013-95d0-c3a44f1cafba",
"tenant": "cf037e9e-cfa5-47cd-8acb-69dd475dde1e"
}



#VNET_ID=$(az network vnet show --resource-group GrupoRecursosClusterK8s --name VnetClusterK8s --query id -o tsv)
#SUBNET_ID=$(az network vnet subnet show --resource-group GrupoRecursosClusterK8s --vnet-name VnetClusterK8s --name SubnetClusterK8s --query id -o tsv)


#az role assignment create --assignee <appId> --scope $VNET_ID --role Contributor
#az role assignment create --assignee d8b5957b-5307-4712-8c6d-fb92e06e1036 --scope $VNET_ID --role Contributor

#ClusterK8s necista como mínimo standard_DS2_v2
#Standard_D12_v2 \

# --service-principal <appId> \
# --client-secret <password> \


#Creo el Cluster de Kubernetes
az aks create \
    --resource-group GrupoRecursosClusterK8s \
    --name ClusterK8s \
    --node-vm-size standard_DS2_v2\
    --node-count 2 \
    --service-principal 2bc77b48-abc7-4640-a0b9-dac75a3d0a39 \
    --client-secret 831effea-7292-4013-95d0-c3a44f1cafba \
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

#Creo el container registry
az acr create \
--resource-group GrupoRecursosClusterK8s \
--name imagenclusterk8s \
--sku Basic
#imagenClusterK8s.azurecr.io

CLIENT_ID=$(az aks show \
--resource-group GrupoRecursosClusterK8s \
--name ClusterK8s \
--query "servicePrincipalProfile.clientId" \
--output tsv)

ACR_ID=$(az acr show \
--name imagenClusterK8s \
--resource-group GrupoRecursosClusterK8s \
--query "id" \
--output tsv)

az role assignment create \
--assignee $CLIENT_ID \
--role acrpull \
--scope $ACR_ID

#loguearse para subir imagenes
az acr login --name imagenclusterk8s
