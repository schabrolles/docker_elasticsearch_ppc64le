docker run -d --name elasticsearch -h elasticsearch -v /var/lib/elasticsearch:/var/lib/elasticsearch -v /var/log/elasticsearch:/var/log/elasticsearch -v /etc/elasticsearch:/etc/elasticsearch schabrolles/elasticsearch
#docker run -ti --name elasticsearch -h elasticsearch -v /var/lib/elasticsearch:/var/lib/elasticsearch schabrolles/elasticsearch /bin/bash

