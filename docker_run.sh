docker run -d --name elasticsearch -h elasticsearch -v /var/lib/elasticsearch:/var/lib/elasticsearch -v /var/log/elasticsearch:/var/log/elasticsearch -v /etc/elasticsearch:/etc/elasticsearch schabrolles/elasticsearch:1.4
#docker run -ti --name elasticsearch -h elasticsearch -v /var/lib/elasticsearch:/var/lib/elasticsearch schabrolles/elasticsearch:1.4 /bin/bash

