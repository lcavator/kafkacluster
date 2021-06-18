#!/bin/bash

#subst env in config template file
CMD=$(which envsubst)
$CMD < config/zookeepertemplate.properties > config/zookeeper.properties

#Split ZOOKEEPER_SERVER_CLUS_CONFIG zookeeper server cluster list in format serer1;server2;server3 to server.1=hostname:ZOOKEEPER_SERVER_PORT_LEADER:ZOOKEEPER_SERVER_PORT_ELECTION
IFS=';'
COUNT='1'
read -ra SERVERS <<< "${ZOOKEEPER_SERVER_CLUS_CONFIG}"
for i in "${SERVERS[@]}"; do
    echo "server.$COUNT=$i:${ZOOKEEPER_SERVER_PORT_LEADER}:${ZOOKEEPER_SERVER_PORT_ELECTION}" >> config/zookeeper.properties
    COUNT=$(($COUNT+1))
done
echo ${ZOOKEEPER_MY_ID} > ${ZOOKEEPER_DATADIR}/myid

bin/zookeeper-server-start.sh config/zookeeper.properties