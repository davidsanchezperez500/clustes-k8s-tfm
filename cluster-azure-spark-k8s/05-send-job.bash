#vInicie kube-proxy en otra línea de comandos con el código siguiente.
kubectl proxy

cd $sparkdir

#crear cuenta de servicio
kubectl create serviceaccount spark

kubectl create clusterrolebinding spark-role \
--clusterrole=edit \
--serviceaccount=default:spark \
--namespace=default

#envio trabajo

./bin/spark-submit \
  --master k8s://http://127.0.0.1:8001 \
  --deploy-mode cluster \
  --name spark-pi \
  --class org.apache.spark.examples.SparkPi \
  --conf spark.executor.instances=3 \
  --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
  --conf spark.kubernetes.container.image=$REGISTRY_NAME/spark:$REGISTRY_TAG \
  $jarUrl


kubectl port-forward spark-pi-1588515033897-driver 4040:4040 4040:4040

spark-pi-1588509915528-driver


spark-pi-1588515033897-driver
