#!/bin/bash

cd elasticsearch

#elasticsearch sources with tests
git clone https://github.com/elasticsearch/elasticsearch.git
mv elasticsearch elasticsearch-1.3.4-tests
cd elasticsearch-1.3.4-tests
git checkout tags/v1.3.4
cd ..

wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.tar.gz
tar -xvzf elasticsearch-1.3.4.tar.gz
cd ..

cd logstash
wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
tar -xvzf logstash-1.4.2.tar.gz
cd ..
