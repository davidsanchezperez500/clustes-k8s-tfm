## Estructura carpetas

### cluster-dataproc
Contiene los archivos de creación del cluster de Dataproc en el proyecto dataproc-21

### cluster-dataproc-gke
Contiene los archivos de creación del cluster de kubernetes en el proyecto dataproc-gke y los helm de los deployment
Nos añadimos los repositorios de Helm
$ helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
$ helm repo add dataproc http://storage.googleapis.com/dataproc-helm-charts


### jobs-pyspark
Contiene los archivos python  y los Jobs para ejecutarlos en dataproc, esta será una carpeta común a todos los proyectos

### terraform-clusters
Contiene los archivos de terraform de la infraestructura de los clusters
Hay un archivo con variables globales global_vars.tf  con un enlace en las subcarpetas
ln -sr global_vars.tf cluster-dataproc-gke/
