From ubuntu
MAINTAINER s.chabrolles.fr.ibm.com

###########################################################################################
# elasticsearch
###########################################################################################

#Install Prerequisites 
RUN apt-get update && \
apt-get -y upgrade && \
apt-get install -y wget software-properties-common openjdk-7-jre-headless


#Install Elasticsearch
ENV elasticsearch_version elasticsearch-1.4.2
RUN cd /tmp && \ 
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/${elasticsearch_version}.deb && \
dpkg -i /tmp/${elasticsearch_version}.deb && \
rm -f /tmp/${elasticsearch_version}.deb

#Configure Elasticsearch
RUN echo "script.disable_dynamic: true" >> /etc/elasticsearch/elasticsearch.yml && \
perl -pi -e "s/#ES_JAVA_OPTS=/ES_JAVA_OPTS=\"-Xss1664k\"/g" /etc/init.d/elasticsearch ; \
#echo "network.host: localhost" >> /etc/elasticsearch/elasticsearch.yml && \
#echo "http.cors.enabled: true" >> /etc/elasticsearch/elasticsearch.yml && \
#echo "http.cors.allow-origin: http://localhost:80" >> /etc/elasticsearch/elasticsearch.yml && \
sudo service elasticsearch restart && \
sudo update-rc.d elasticsearch defaults 95 10

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

# Expose the Elasticsearch port and data volume
EXPOSE 9200
VOLUME ["/var/lib/elasticsearch"]

# Set the default command to run when starting the container
CMD service elasticsearch start ; sleep 30 ; tail -f /var/log/elasticsearch/elasticsearch.log
