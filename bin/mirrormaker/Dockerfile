FROM centos

ARG KAFKA_VERSION=2.5.0
ARG SCALA_VERSION=2.12


ENV MIRRORMAKER_CONSUMER_BOOTSTRAP_SERVER kafka-prod:9092
ENV MIRRORMAKER_CONSUMER_GROUP_ID MirroMakerGroup
ENV MIRRORMAKER_CONSUMER_EXCLUDE_INTERNAL_TOPIC true
ENV MIRRORMAKER_CONSUMER_CLIENT_ID mirror_maker_consumer

ENV MIRRORMAKER_PRODUCER_BOOTSTRAP_SERVER kafka-dr:9092
ENV MIRRORMAKER_PRODUCER_BATCH_SIZE 100
ENV MIRRORMAKER_PRODUCER_CLIENT_ID mirror_maker_producer


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

COPY mirrormaker-entrypoint.sh /usr/local/bin/mirrormaker-entrypoint.sh
COPY config/consumer.properties /usr/local/config/consumer.properties.template
COPY config/producer.properties /usr/local/config/producer.properties.template


RUN set -eux; \
    groupadd -g 1000 kafka; \
    useradd -g kafka -u 1000 kafka; \
    mkdir -p /usr/local/config; \
    chown -R 1000:1000 /usr/local/config/
    
USER 1000

ENTRYPOINT [ "/bin/bash", "/usr/local/bin/mirrormaker-entrypoint.sh" ]