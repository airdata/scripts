echo 'deb http://packages.elastic.co/logstashforwarder/debian stable main' | sudo tee /etc/apt/sources.list.d/logstashforwarder.list
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get update
sudo apt-get install logstash-forwarder

