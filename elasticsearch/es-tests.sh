#!/bin/sh

#run release build
MODE=release
RUN_PY_ARG=

#run debug build
#MODE=debug
#RUN_PY_ARG=-d

ORIG_PATH=`pwd`

ES_TESTS=elasticsearch-1.3.4-tests

cd $ES_TESTS
mvn clean validate generate-test-sources process-test-resources test-compile

SUITE_FILE=all.suites
cp ../$SUITE_FILE target/

cd $OSV_HOME
make mode=$MODE image=cli,java

echo "[manifest]\n/$ES_TESTS/**: $ORIG_PATH/$ES_TESTS/**\n/m2/**:/home/zvm/.m2/**" > /tmp/elasticsearch-tests.usr.manifest

cd build/$MODE.x64 && ../../scripts/upload_manifest.py -o usr.img -m /tmp/elasticsearch-tests.usr.manifest; cd ../..;

./scripts/run.py $RUN_PY_ARG -c1 -e "--cwd=$ES_TESTS /java.so -Xmx512m -Xms512m -Xss256k -XX:MaxPermSize=128m -XX:MaxDirectMemorySize=512m -Des.logger.prefix= -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/$ES_TESTS/logs/ -Dtests.prefix=tests -Dtests.seed=1F3ABE5FFE2DF5E0 -Des.logger.level=INFO -Des.node.local= -Des.node.mode= -Djava.awt.headless=true -Djava.io.tmpdir=. -Djava.security.policy=/$ES_TESTS/dev-tools/tests.policy -Djunit4.tempDir=/$ES_TESTS/target -Dtests.appendseed= -Dtests.assertion.disabled= -Dtests.awaitsfix= -Dtests.badapples= -Dtests.bwc= -Dtests.bwc.path=/$ES_TESTS/backwards -Dtests.bwc.version= -Dtests.class= -Dtests.client.ratio= -Dtests.cluster= -Dtests.compatibility= -Dtests.enable_mock_modules= -Dtests.failfast= -Dtests.filter= -Dtests.heap.size=512m -Dtests.integration= -Dtests.iters= -Dtests.jvm.argline= -Dtests.maxfailures= -Dtests.method= -Dtests.network= -Dtests.nightly= -Dtests.processors= -Dtests.rest= -Dtests.rest.blacklist= -Dtests.rest.spec= -Dtests.rest.suite= -Dtests.security.manager= -Dtests.showSuccess= -Dtests.slow= -Dtests.timeoutSuite= -Dtests.verbose= -Dtests.version=1.3.4 -Dtests.weekly= -ea -da:... -classpath /$ES_TESTS/target/test-classes:/$ES_TESTS/target/classes:/m2/repository/org/hamcrest/hamcrest-all/1.3/hamcrest-all-1.3.jar:/m2/repository/com/carrotsearch/randomizedtesting/randomizedtesting-runner/2.1.2/randomizedtesting-runner-2.1.2.jar:/m2/repository/junit/junit/4.10/junit-4.10.jar:/m2/repository/org/apache/lucene/lucene-test-framework/4.9.1/lucene-test-framework-4.9.1.jar:/m2/repository/com/carrotsearch/randomizedtesting/junit4-ant/2.1.3/junit4-ant-2.1.3.jar:/m2/repository/org/apache/ant/ant/1.8.2/ant-1.8.2.jar:/m2/repository/org/apache/httpcomponents/httpclient/4.3.1/httpclient-4.3.1.jar:/m2/repository/org/apache/httpcomponents/httpcore/4.3/httpcore-4.3.jar:/m2/repository/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar:/m2/repository/commons-codec/commons-codec/1.6/commons-codec-1.6.jar:/m2/repository/org/apache/lucene/lucene-core/4.9.1/lucene-core-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-analyzers-common/4.9.1/lucene-analyzers-common-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-codecs/4.9.1/lucene-codecs-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-queries/4.9.1/lucene-queries-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-memory/4.9.1/lucene-memory-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-highlighter/4.9.1/lucene-highlighter-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-queryparser/4.9.1/lucene-queryparser-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-sandbox/4.9.1/lucene-sandbox-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-suggest/4.9.1/lucene-suggest-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-misc/4.9.1/lucene-misc-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-join/4.9.1/lucene-join-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-grouping/4.9.1/lucene-grouping-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-spatial/4.9.1/lucene-spatial-4.9.1.jar:/m2/repository/org/apache/lucene/lucene-expressions/4.9.1/lucene-expressions-4.9.1.jar:/m2/repository/org/antlr/antlr-runtime/3.5/antlr-runtime-3.5.jar:/m2/repository/org/ow2/asm/asm/4.1/asm-4.1.jar:/m2/repository/org/ow2/asm/asm-commons/4.1/asm-commons-4.1.jar:/m2/repository/com/spatial4j/spatial4j/0.4.1/spatial4j-0.4.1.jar:/m2/repository/com/vividsolutions/jts/1.13/jts-1.13.jar:/m2/repository/com/github/spullara/mustache/java/compiler/0.8.13/compiler-0.8.13.jar:/m2/repository/com/google/guava/guava/17.0/guava-17.0.jar:/m2/repository/com/carrotsearch/hppc/0.5.3/hppc-0.5.3.jar:/m2/repository/joda-time/joda-time/2.3/joda-time-2.3.jar:/m2/repository/org/joda/joda-convert/1.2/joda-convert-1.2.jar:/m2/repository/org/mvel/mvel2/2.2.0.Final/mvel2-2.2.0.Final.jar:/m2/repository/com/fasterxml/jackson/core/jackson-core/2.4.1.1/jackson-core-2.4.1.1.jar:/m2/repository/com/fasterxml/jackson/dataformat/jackson-dataformat-smile/2.4.1/jackson-dataformat-smile-2.4.1.jar:/m2/repository/com/fasterxml/jackson/dataformat/jackson-dataformat-yaml/2.4.1/jackson-dataformat-yaml-2.4.1.jar:/m2/repository/com/fasterxml/jackson/dataformat/jackson-dataformat-cbor/2.4.1/jackson-dataformat-cbor-2.4.1.jar:/m2/repository/io/netty/netty/3.9.1.Final/netty-3.9.1.Final.jar:/m2/repository/com/ning/compress-lzf/1.0.2/compress-lzf-1.0.2.jar:/m2/repository/com/tdunning/t-digest/3.0/t-digest-3.0.jar:/m2/repository/org/codehaus/groovy/groovy-all/2.3.2/groovy-all-2.3.2.jar:/m2/repository/log4j/log4j/1.2.17/log4j-1.2.17.jar:/m2/repository/org/slf4j/slf4j-api/1.6.2/slf4j-api-1.6.2.jar:/m2/repository/net/java/dev/jna/jna/4.1.0/jna-4.1.0.jar:/m2/repository/org/fusesource/sigar/1.6.4/sigar-1.6.4.jar:/m2/repository/com/carrotsearch/randomizedtesting/junit4-ant/2.1.2/junit4-ant-2.1.2.jar com.carrotsearch.ant.tasks.junit4.slave.SlaveMainSafe -eventsfile /$ES_TESTS/target/$SUITE_FILE.events @/$ES_TESTS/target/$SUITE_FILE"

#get tests results
RESULT_URL=http://192.168.122.89:8000/file/%2F$ES_TESTS%2Ftarget%2F$SUITE_FILE.events?op=GET
sudo echo $RESULT_URL
sleep 2 && curl --request GET $RESULT_URL > $ORIG_PATH/tests-results.events && echo See results in file $ORIG_PATH/tests-results.events && echo "type exit\n" &
sudo ./scripts/run.py -e "/cli/cli.so" -nv

cd $ORIG_PATH

