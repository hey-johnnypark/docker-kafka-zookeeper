Docker Kafka Zookeeper
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
