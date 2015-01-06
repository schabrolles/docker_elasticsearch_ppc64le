docker run -d --name elasticsearch -h elasticsearch schabrolles/elasticsearch_ppc64le

sleep 1
sudo docker cp elasticsearch:/var/lib/elasticsearch /var/lib
sudo docker cp elasticsearch:/var/log/elasticsearch /var/log
sudo docker cp elasticsearch:/etc/elasticsearch /etc
sleep 1

docker rm -vf elasticsearch
