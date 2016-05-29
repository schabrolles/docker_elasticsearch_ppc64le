From schabrolles/ubuntu
MAINTAINER s.chabrolles.fr.ibm.com

###########################################################################################
# elasticsearch
###########################################################################################
ENV DEBIAN_FRONTEND noninteractive

#Install Prerequisites 
RUN apt-get update && \
apt-get -y upgrade && \
apt-get install -y wget software-properties-common openjdk-8-jre-headless

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

#RUN set -x \
#	&& apt-get update \
#	&& apt-get install -y --no-install-recommends elasticsearch=$ELASTICSEARCH_VERSION \
#	&& rm -rf /var/lib/apt/lists/*

RUN cd /tmp &&\
wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.3/elasticsearch-2.3.3.deb &&\
dpkg -i elasticsearch-2.3.3.deb

ENV PATH /usr/share/elasticsearch/bin:$PATH
ENV WORKDIR /usr/share/elasticsearch

RUN cd $WORKDIR &&\
set -ex\
	&& for path in \
		./data \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done

COPY config ./config

VOLUME /usr/share/elasticsearch/data

COPY docker-entrypoint.sh /

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
