#Clono el repositorio
git clone -b branch-2.4 https://github.com/apache/spark

#Cambio al directorio del repositorio clonado
#y guardo la ruta de acceso al código fuente de Spark en una variable.

cd spark
sparkdir=$(pwd)

#Ejecuto el siguiente comando
#para compilar el código fuente de Spark con compatibilidad con Kubernetes.

./build/mvn -Pkubernetes -DskipTests clean package

[INFO] Reactor Summary for Spark Project Parent POM 2.4.6-SNAPSHOT:
[INFO]
[INFO] Spark Project Parent POM ........................... SUCCESS [  1.940 s]
[INFO] Spark Project Tags ................................. SUCCESS [  3.400 s]
[INFO] Spark Project Sketch ............................... SUCCESS [  3.841 s]
[INFO] Spark Project Local DB ............................. SUCCESS [  2.155 s]
[INFO] Spark Project Networking ........................... SUCCESS [  4.236 s]
[INFO] Spark Project Shuffle Streaming Service ............ SUCCESS [  2.318 s]
[INFO] Spark Project Unsafe ............................... SUCCESS [  4.146 s]
[INFO] Spark Project Launcher ............................. SUCCESS [  3.732 s]
[INFO] Spark Project Core ................................. SUCCESS [01:33 min]
[INFO] Spark Project ML Local Library ..................... SUCCESS [  4.261 s]
[INFO] Spark Project GraphX ............................... SUCCESS [  7.003 s]
[INFO] Spark Project Streaming ............................ SUCCESS [ 18.026 s]
[INFO] Spark Project Catalyst ............................. SUCCESS [01:01 min]
[INFO] Spark Project SQL .................................. SUCCESS [01:54 min]
[INFO] Spark Project ML Library ........................... SUCCESS [01:05 min]
[INFO] Spark Project Tools ................................ SUCCESS [  0.518 s]
[INFO] Spark Project Hive ................................. SUCCESS [ 27.027 s]
[INFO] Spark Project REPL ................................. SUCCESS [  2.692 s]
[INFO] Spark Project Kubernetes ........................... SUCCESS [  4.416 s]
[INFO] Spark Project Assembly ............................. SUCCESS [  1.879 s]
[INFO] Spark Integration for Kafka 0.10 ................... SUCCESS [  4.370 s]
[INFO] Kafka 0.10+ Source for Structured Streaming ........ SUCCESS [  7.097 s]
[INFO] Spark Project Examples ............................. SUCCESS [  9.175 s]
[INFO] Spark Integration for Kafka 0.10 Assembly .......... SUCCESS [  2.598 s]
[INFO] Spark Avro ......................................... SUCCESS [  3.951 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  07:35 min
[INFO] Finished at: 2020-04-13T18:07:50+02:00
[INFO] ------------------------------------------------------------------------


REGISTRY_NAME=imagenclusterk8s.azurecr.io
REGISTRY_TAG=v1

./bin/docker-image-tool.sh -r $REGISTRY_NAME -t $REGISTRY_TAG build
./bin/docker-image-tool.sh -r $REGISTRY_NAME -t $REGISTRY_TAG push

#Preparo el trabajo de spark
mkdir myprojects
cd myprojects
sbt new sbt/scala-seed.g8

#name [Scala Seed Project]: SparkPi
cd sparkpi

touch project/assembly.sbt
echo 'addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.10")' >> project/assembly.sbt

EXAMPLESDIR="src/main/scala/org/apache/spark/examples"
mkdir -p $EXAMPLESDIR
cp $sparkdir/examples/$EXAMPLESDIR/SparkPi.scala $EXAMPLESDIR/SparkPi.scala

cat <<EOT >> build.sbt
// https://mvnrepository.com/artifact/org.apache.spark/spark-sql
libraryDependencies += "org.apache.spark" %% "spark-sql" % "2.3.0" % "provided"
EOT

sed -ie 's/scalaVersion.*/scalaVersion := "2.11.11"/' build.sbt
sed -ie 's/name.*/name := "SparkPi",/' build.sbt

#empaqueto el proyecto en un jar
sbt assembly

#Packaging /home/david/repos/spark/myprojects/sparkpi/target/scala-2.11/SparkPi-assembly-0.1.0-SNAPSHOT.jar ...
