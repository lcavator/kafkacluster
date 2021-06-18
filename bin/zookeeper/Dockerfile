FROM centos

ARG KAFKA_VERSION=2.8.0
ARG SCALA_VERSION=2.12


ENV ZOOKEEPER_MY_ID 1
ENV ZOOKEEPER_DATADIR /data/zookeeper
ENV ZOOKEEPER_CLIENT_PORT=2181
ENV ZOOKEEPER_SERVER_PORT_LEADER=2888
ENV ZOOKEEPER_SERVER_PORT_ELECTION=3888
ENV ZOOKEEPER_MAX_CLIENT 0
ENV ZOOKEEPER_TICK_TIME 2000
ENV ZOOKEEPER_INIT_LIMIT 10
ENV ZOOKEEPER_SYNC_TIME 5
ENV ZOOKEEPER_SERVER_CLUS_CONFIG ${HOSTNAME}

RUN yum -y update
RUN yum install -y wget gettext which java-1.8.0-openjdk.x86_64 

WORKDIR /opt

#Download kafka and verify 
RUN wget -q https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
wget -q https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz.asc && \
wget -q https://downloads.apache.org/kafka/KEYS && \
gpg --import KEYS && \
gpg --verify kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz.asc kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

RUN tar xfvz kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz; mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} kafka

WORKDIR /opt/kafka

COPY zookeeper-entrypoint.sh /usr/local/bin/zookeeper-entrypoint.sh
COPY config/zookeeper.properties config/zookeepertemplate.properties

RUN set -eux; \
    groupadd -g 1000 zookeeper; \
    useradd -g zookeeper -u 1000 zookeeper; \
    mkdir -p "${ZOOKEEPER_DATADIR}"; \
    chown -R zookeeper:zookeeper "${ZOOKEEPER_DATADIR}" "/opt/kafka"

#VOLUME [${ZOOKEEPER_DATADIR}]

EXPOSE ${ZOOKEEPER_CLIENT_PORT}

USER 1000

ENTRYPOINT [ "/bin/bash", "/usr/local/bin/zookeeper-entrypoint.sh" ]