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
