#!/bin/bash

#subst env in config template file
CMD=$(which envsubst)
$CMD < config/servertemplate.properties > config/server.properties
bin/kafka-server-start.sh config/server.properties
