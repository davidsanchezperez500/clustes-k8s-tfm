az group create \
  --name tfm \
  --location "Central US"

templateFile="/home/david/repos/tfm-compara-cloud/cluster-azure-spark/template.json"
az deployment group create \
  --name blanktemplate \
  --resource-group tfm \
  --template-file $templateFile \
#  --clusterName cluster-azure-spark

az group delete --name tfm
