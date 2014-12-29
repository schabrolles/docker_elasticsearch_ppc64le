From ubuntu
MAINTAINER s.chabrolles.fr.ibm.com

#Install Prerequisites 
RUN apt-get update && \
apt-get -y upgrade && \
apt-get install -y wget software-properties-common openjdk-7-jre-headless


#Install Elasticsearch
RUN wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add - && \
sudo add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" && \
sudo apt-get update && sudo apt-get install elasticsearch && \
sudo update-rc.d elasticsearch defaults 95 10

#Configure Elasticsearch
RUN echo "script.disable_dynamic: true" >> /etc/elasticsearch/elasticsearch.yml && \
echo "network.host: localhost" >> /etc/elasticsearch/elasticsearch.yml && \
sudo service elasticsearch restart && \
sudo update-rc.d elasticsearch defaults 95 10

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

# Expose the Elasticsearch port
EXPOSE 9200

# Set the default command to run when starting the container
CMD ["service elasticsearch start"]
