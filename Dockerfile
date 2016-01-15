FROM java:8-jre
MAINTAINER kosho@elastic.co

# retrieve gosu
RUN curl -o /usr/local/bin/gosu -fsSL https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64
RUN chmod +x /usr/local/bin/gosu

# install elasticsearch and plugins
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
RUN apt-get update && apt-get install elasticsearch

RUN mkdir /usr/share/elasticsearch/config && chown elasticsearch:elasticsearch /usr/share/elasticsearch/config
RUN mkdir /usr/share/elasticsearch/logs && chown elasticsearch:elasticsearch /usr/share/elasticsearch/logs
RUN mkdir /usr/share/elasticsearch/data && chown elasticsearch:elasticsearch /usr/share/elasticsearch/data

ADD config/elasticsearch.yml /usr/share//elasticsearch/config

ENV PATH /usr/share/elasticsearch/bin:$PATH

RUN plugin install license
RUN plugin install watcher
RUN plugin install marvel-agent

# install kibana and plugins
RUN curl -L -O https://download.elastic.co/kibana/kibana/kibana-4.3.1-linux-x64.tar.gz
RUN mkdir /usr/share/kibana
RUN tar zxf kibana-4.3.1-linux-x64.tar.gz -C /usr/share/kibana --strip-components 1
ENV PATH /usr/share/kibana/bin:$PATH
RUN kibana plugin --install elastic/sense
RUN kibana plugin --install kibana/timelion
RUN kibana plugin --install elasticsearch/marvel/latest
RUN chown -R elasticsearch:elasticsearch /usr/share/kibana/optimize

EXPOSE 9200 9300 5601

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

