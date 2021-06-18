#!/bin/bash

#subst env in config template file
CMD=$(which envsubst)
$CMD < /usr/local/config/producer.properties.template > /usr/local/config/producer.properties
$CMD < /usr/local/config/consumer.properties.template > /usr/local/config/consumer.properties


bin/kafka-mirror-maker.sh --consumer.config /usr/local/config/consumer.properties --num.streams 2 --producer.config /usr/local/config/producer.properties --whitelist=".*"