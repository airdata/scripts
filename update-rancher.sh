docker pull rancher/server:stable
docker stop rancher-server
docker create --volumes-from rancher-server --name rancher-server-data rancher/server:stable
docker run -d --volumes-from rancher-server-data --name rancher-server --restart=unless-stopped -p 8080:8080 -p 9345:9345 rancher/server:stable --db-host cattle.c7nexxhgy3h5.eu-central-1.rds.amazonaws.com --db-port 3306 --db-user rancher --db-pass "**3gwE&^TnA5" --db-name cattle --advertise-address $(ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
