FROM ubuntu:xenial

RUN apt-get update && apt-get -y install wget curl 
ADD conf/cloudera.list /etc/apt/sources.list.d
RUN wget -qO - http://archive.cloudera.com/kudu/ubuntu/xenial/amd64/kudu/archive.key | apt-key add - && \
apt-get update && \
apt-get -y dist-upgrade && \
apt-get -y install kudu kudu-master kudu-tserver libkuduclient0 libkuduclient-dev

VOLUME /var/lib/kudu/master /var/lib/kudu/tserver

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 8050 8051 7050 7051
CMD ["help"]
