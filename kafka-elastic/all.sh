#!/bin/bash

# Run all playbooks at once
ansible-playbook /kafka-elastic/1_configure-elasticsearch.yml
ansible-playbook /kafka-elastic/2_configure-kibana.yml
ansible-playbook /kafka-elastic/3_configure-logstash.yml
ansible-playbook /kafka-elastic/4_configure-mysql.yml
