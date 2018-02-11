# Elastic Meetup - Kafka Demo
This is the demo environment for https://www.meetup.com/Turkey-Elastic-Fantastics/events/247707990/ Elastic-Turkey meetup.


## Features

* Installs [MySQL](https://dev.mysql.com/downloads/repo/apt/), Kafka ([Confluent Open Source](https://docs.confluent.io/current/installation/installing_cp.html#deb-packages-via-apt)), and [Elastic Stack](https://www.elastic.co/downloads)
* Creates a sample database table with data
* Includes a sample Kafka connect json file for reading data from MySQL
* Use Logstash as a Kafka consumer to ingest data into Elasticsearch


## Vagrant and Ansible

Do a simple `vagrant up` by using [Vagrant](https://www.vagrantup.com)'s [Ansible provisioner](https://www.vagrantup.com/docs/provisioning/ansible.html). All you need is a working [Vagrant installation](https://www.vagrantup.com/docs/installation/) (1.8.6+ but the latest version is always recommended), a [provider](https://www.vagrantup.com/docs/providers/) (tested with the latest [VirtualBox](https://www.virtualbox.org) version), and 2.5GB of RAM.

With the [Ansible playbooks](https://docs.ansible.com/ansible/playbooks.html) in the */kafka-elastic/* folder you can configure the whole system step by step. Just run them in the given order inside the Vagrant box:


```
> vagrant ssh
$ ansible-playbook /kafka-elastic/1_configure-elasticsearch.yml
$ ansible-playbook /kafka-elastic/2_configure-kibana.yml
$ ansible-playbook /kafka-elastic/3_configure-logstash.yml
$ ansible-playbook /kafka-elastic/4_configure-mysql.yml
```

Or if you are in a hurry, run all playbooks with `$ /kafka-elastic/all.sh` at once.

## Kafka - Stream data out of MySQL
Once all the tools are setup we can stream data out of MySQL.  In order to read data from MySQL, we need to configure Kafka as producer and load it from a JSON configuration file.

To load the configuration via JSON converter, use the following command:
```
confluent load jdbc_source_mysql_demo -d /kafka-elastic/templates/kafka-connect-jdbc-source.json
```

```/kafka-elastic/templates/kafka-connect-jdbc-source.json``` file has all the details and necessary configurations to read from the newly created MySQL table (namely ```demo.foobar```)


You can check the status of loaded configuration by running the following command:
```
confluent status jdbc_source_mysql_demo
```

In order to access Kafka topic as a consumer and test our input, run the following command:
```
kafka-console-consumer \
--bootstrap-server localhost:9092 \
--property print.key=true \
--from-beginning \
--topic mysql-foobar
```

## Adding rows to MySQL
You can do one of the following:
```
$ ansible-playbook /kafka-elastic/update-mysql.yml
```
This simply runs the sql commands in ```/kafka-elastic/templates/demo_update.sql```

You can always use your favorite mysql client to connect and add rows for testing purposes.

## Kibana

Access Kibana at [http://localhost:5601](http://localhost:5601)



## Notes: 
Inspired by Confluent blog: https://www.confluent.io/blog/simplest-useful-kafka-connect-data-pipeline-world-thereabouts-part-1/

However, this blog doest not cover Logstash and it's applicable to Elasticsearch 5.x version only (Elasticsearch 6.x is not supported as per: https://docs.confluent.io/current/connect/connect-elasticsearch/docs/elasticsearch_connector.html)
