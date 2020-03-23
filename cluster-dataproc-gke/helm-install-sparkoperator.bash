#!/bin/bash

#Creo las variables de entorno
NAMESPACE=spark

#Instalo el deploy con Helm
helm install sparkoperator incubator/sparkoperator --namespace $NAMESPACE --set sparkJobNamespace=$NAMESPACE \
