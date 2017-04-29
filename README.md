# docker-spark

Dockerfile for [Apache Spark](https://spark.apache.org/)

Docker images built from this Dockerfile are available from
[Docker Hub](https://hub.docker.com/r/b9company/spark/)

## Usage

```
docker run -ti b9company/spark:2.1.0-hadoop2.7 ./bin/spark-shell --master local\[2\]
```

## Build Notes

The Docker image can be tailored through variables during the build process.
Note that `SPARK_VERSION` and `HADOOP_VERSION` are required variables in order
to specify which Spark version to build.

| Build-time Variable | Description |
| ------------------- | ----------- |
| `SPARK_VERSION`     | **Mandatory**. Spark version to build. |
| `HADOOP_VERSION`    | **Mandatory**. Hadoop version to build. |
| `SPARK_MIRROR`      | *Optional*. Mirror to use to download Spark. |
| `SPARK_ARCHIVE`     | *Optional*. URL to the Spark tarball. In such case, `SPARK_MIRROR` is ignored. |

To build `b9company/spark:2.1.0-hadoop2.7` Docker image, run:

```
make build SPARK_VERSION=2.1.0 HADOOP_VERSION=2.7
```
