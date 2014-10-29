#!/bin/sh

#run release build
MODE=release
RUN_PY_ARG=

#run debug build
#MODE=debug
#RUN_PY_ARG=-d

ES=elasticsearch-1.3.4

ORIG_PATH=`pwd`

cd $OSV_HOME
make mode=$MODE image=cli,java
echo "[manifest]\n/$ES/**: $ORIG_PATH/$ES/**" > /tmp/elasticsearch.usr.manifest

cd build/$MODE.x64 && ../../scripts/upload_manifest.py -o usr.img -m /tmp/elasticsearch.usr.manifest; cd ../..;

#run with sudo to enable networking
sudo ./scripts/run.py $RUN_PY_ARG -nv -e "/java.so -Xms256m -Xmx1g -Xss256k -Djava.awt.headless=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -Delasticsearch -Des.foreground=yes -Des.path.home=/$ES -cp :/$ES/lib/elasticsearch-1.3.4.jar:/$ES/lib/* org.elasticsearch.bootstrap.Elasticsearch"

cd $ORIG_PATH
