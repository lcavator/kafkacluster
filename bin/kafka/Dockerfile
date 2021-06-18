FROM centos:latest

ARG KAFKA_VERSION=2.8.0
ARG SCALA_VERSION=2.12

ENV KAFKA_PLAIN_PORT 9092
ENV KAFKA_DATADIR /data/kafka
ENV KAFKA_BROKER_ID 1
ENV KAFKA_NUM_NETWORK_THREADS 3
ENV KAFKA_NUM_IO_THREADS 8  
ENV KAFKA_SOCKET_SEND_BUFER_BYTES 102400
ENV KAFKA_SOCKET_RECEIVE_BUFER_BYTE 102400
ENV KAFKA_SOCKET_REQUEST_MAX_BYTES 104857600
ENV KAFKA_LOG_DIRS /data/kafka
ENV KAFKA_NUM_PARTITIONS 8
ENV KAFKA_NUM_RECOVERY_THREADS_PER_DATA_DIR 1
ENV KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR 2
ENV KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR 1
ENV KAFKA_TRANSACTION_STATE_LOG_MIN_ISR 1
ENV KAFKA_LOG_RETENTION_HOUR 168
ENV KAFKA_LOG_SEGMENT_BYTES 1073741824
ENV KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS 300000
ENV KAFKA_ZOOKEEPER_CONNECT zookeeper01:2181
ENV KAFKA_ZOOKEEPER_CONNECTION_TIMEOUT_MS 6000
ENV KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS 0

RUN yum -y update
RUN yum install -y wget gettext which java-1.8.0-openjdk.x86_64 

WORKDIR /opt

#Download kakfa and verify 
RUN wget -q https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
wget -q https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz.asc && \
wget -q https://downloads.apache.org/kafka/KEYS && \
gpg --import KEYS && \
gpg --verify kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz.asc kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

RUN tar xfvz kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz; mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} kafka

WORKDIR /opt/kafka

COPY kafka-entrypoint.sh /usr/local/bin/kafka-entrypoint.sh
COPY config/server.properties config/servertemplate.properties

RUN set -eux; \
    groupadd -g 1000 kafka; \
    useradd -g kafka -u 1000 kafka; \
    mkdir -p "${KAFKA_DATADIR}"; \
    chown -R kafka:kafka "${KAFKA_DATADIR}" "/opt/kafka"

#VOLUME [${KAFKA_DATADIR}]

EXPOSE ${KAFKA_PLAIN_PORT}

USER 1000

ENTRYPOINT [ "/bin/bash", "/usr/local/bin/kafka-entrypoint.sh" ]