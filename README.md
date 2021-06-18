# kafkacluster
Some docker, docker-compose example to a self study on Kafka server infrastructure

docker-compose-kafka-cluster:
 - 3 zookeeper node in cluster; 
 - 3 kafka brokers in cluster;
 - kafka manager
 - ZooNavigator

docker-compose-kafka-cluster-mirrormaker:
 - 1 zookeeper
 - 2 kafka brokers cluser prod
 - 2 kafka brokers cluser dr
 - ZooNavigator
 - kafka manager
 - mirrormaker (prod --> dir)
