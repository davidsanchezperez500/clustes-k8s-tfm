#!/bin/bash

#Creo una cuenta de Azure Storage y un contenedor para almacenar el archivo jar.

RESOURCE_GROUP=sparkdemo
STORAGE_ACCT=sparkdemo$RANDOM

az group create \
  --name $RESOURCE_GROUP \
  --location eastus

az storage account create \
  --resource-group $RESOURCE_GROUP \
  --name $STORAGE_ACCT \
  --sku Standard_LRS

export AZURE_STORAGE_CONNECTION_STRING=`az storage account show-connection-string \
  --resource-group $RESOURCE_GROUP \
  --name $STORAGE_ACCT -o tsv`

#Carguo el archivo jar en la cuenta de Azure Storage con los siguientes comandos.
CONTAINER_NAME=jars
BLOB_NAME=SparkPi-assembly-0.1.0-SNAPSHOT.jar
FILE_TO_UPLOAD=target/scala-2.11/SparkPi-assembly-0.1.0-SNAPSHOT.jar

echo "Creating the container..."
az storage container create \
  --name $CONTAINER_NAME

az storage container set-permission \
  --name $CONTAINER_NAME \
  --public-access blob

echo "Uploading the file..."
az storage blob upload \
  --container-name $CONTAINER_NAME \
  --file $FILE_TO_UPLOAD \
  --name $BLOB_NAME

jarUrl=$(az storage blob url \
  --container-name $CONTAINER_NAME \
  --name $BLOB_NAME | tr -d '"')


  #Inicio kube-proxy en otra shell con el código siguiente.
  kubectl proxy

  #Vuelvo a la shell anterior
  cd $sparkdir

  #crear cuenta de servicio
  kubectl create serviceaccount spark

  kubectl create clusterrolebinding spark-role \
  --clusterrole=edit \
  --serviceaccount=default:spark \
  --namespace=default
