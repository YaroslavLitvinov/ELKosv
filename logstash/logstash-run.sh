#!/bin/bash

#run release build
MODE=release
RUN_PY_ARG=

#run debug build
#MODE=debug
#RUN_PY_ARG=-d

LOGSTASH=logstash-1.4.2

ORIG_PATH=`pwd`

cd $OSV_HOME

make mode=$MODE image=java
echo input { stdin { } } output { stdout {} } > /tmp/logstash-config.txt
echo "[manifest]\n/$LOGSTASH/**: $ORIG_PATH/$LOGSTASH/**\n/tmp/logstash-config.txt: /tmp/logstash-config.txt" > /tmp/logstash.usr.manifest

cd build/$MODE.x64 && ../../scripts/upload_manifest.py -o usr.img -m /tmp/logstash.usr.manifest; cd ../..;

./scripts/run.py -e "--env=GEM_HOME=/$LOGSTASH/vendor/bundle/jruby/2.1/ /java.so -Xmx500m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -Djava.awt.headless=true -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -jar /$LOGSTASH/vendor/jar/jruby-complete-1.7.11.jar -I/$LOGSTASH/lib /$LOGSTASH/lib/logstash/runner.rb agent -f /tmp/logstash-config.txt"
