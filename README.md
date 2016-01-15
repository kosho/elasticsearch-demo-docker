# All-in-one Elasticsearch Docker Image

## Contents

- Elasticsearch 2.1.1
  - Watcher
  - Marvel Agent
- Kibana 4.3.1
  - Sense
  - Marvel
  - Timelinon

## Creating Docker Image

~~~
$ docker build -t REPOSITORY[:TAG] .
~~~

## Running and Connecting to Elasticsearch and Kibana

Type in `docker` run command as follows. You may need to clearly assign local ports for the container.

~~~
$ docker run -p 9200:9200 -p 9300:9300 -p 5601:5601 -d REPOSITORY elasticsearch
~~~

Make sure virtual machine's IP address with `docker-machine ip default`, and open `http://docker-machine-ip:9200` or `http://docker-machine-ip:5601` by your browser.
