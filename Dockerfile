FROM openjdk:8-jre

LABEL maintainer="the B9 Company <lab@b9company.fr>"

ARG SPARK_VERSION
ARG HADOOP_VERSION
ARG SPARK_MIRROR="http://apache.crihan.fr/dist/spark"
ARG SPARK_ARCHIVE="${SPARK_MIRROR}/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"

ENV SPARK_HOME /usr/local/spark

RUN ["bash", "-c", "set -o pipefail && wget -qO - \"${SPARK_ARCHIVE}\" | tar zx -C /usr/local/"]
RUN ln -s `basename "${SPARK_ARCHIVE}" .tgz` "${SPARK_HOME}"

RUN apt-get update \
 && apt-get install -y \
      python3 \
 && rm -rf /var/lib/apt/lists/*

ENV PYSPARK_PYTHON "/usr/bin/python3"
# See: https://issues.apache.org/jira/browse/SPARK-13330
ENV PYTHONHASHSEED 0

ENV PATH "$PATH:${SPARK_HOME}/bin"

WORKDIR "${SPARK_HOME}"
