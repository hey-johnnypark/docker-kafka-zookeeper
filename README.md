Docker Kafka Zookeeper ![Build Status](https://travis-ci.org/hey-johnnypark/docker-kafka-zookeeper.svg?branch=master)
======================
Docker image for Kafka message broker including Zookeeper

Build
-----
```
$ docker build .
[...]
Successfully built 9b382d40bccc
```

Run container
-------------
```
docker run -p 2181:2181 -p 9092:9092 -e ADVERTISED_HOST=<YOUR_HOST> 9b382d40bccc
```

Test
----
Run Kafka console consumer
```
kafka-console-consumer --bootstrap-server <YOUR_HOST>:9092 --topic test
```

Run Kafka console producer
```
kafka-console-producer --broker-list <YOUR_HOST>:9092 --topic test
test1
test2
test3
```

Verify messages been received in console consumer
```
test1
test2
test3
```

Credits
-------
Originally cloned and inspired by https://github.com/spotify/docker-kafka
