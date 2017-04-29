FROM openjdk:8-jre

LABEL maintainer="the B9 Company <lab@b9company.fr>"

ARG SPARK_VERSION
ARG HADOOP_VERSION
ARG SPARK_MIRROR="http://apache.crihan.fr/dist/spark"
ARG SPARK_ARCHIVE="${SPARK_MIRROR}/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"

ENV SPARK_HOME /usr/local/spark

RUN ["bash", "-c", "set -o pipefail && wget -qO - \"${SPARK_ARCHIVE}\" | tar zx -C /usr/local/"]
RUN ln -s `basename "${SPARK_ARCHIVE}" .tgz` "${SPARK_HOME}"

ENV PATH "$PATH:${SPARK_HOME}/bin"

WORKDIR "${SPARK_HOME}"
