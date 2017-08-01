#! /usr/bin/env bash


echo -e "\n--- Installing now... ---\n"

echo -e "\n--- Updating packages list ---\n"
apt-get -qq update > /dev/null 2>&1

echo -e "\n--- Install base packages ---\n"
apt-get install -y python3-pip libgeoip-dev > /dev/null 2>&1
# it would maybe be better to install Python 3.6.1 from sources
# (https://gist.github.com/cedricbonhomme/35e81e295fd4baed83d6ccb2cb9fde79) or
# to simply use a virtualenv (https://github.com/berdario/pew)

apt-get install -y git npm nodejs-legacy redis-server parallel > /dev/null 2>&1
echo -e "\n--- Install tshark ---\n"
DEBIAN_FRONTEND=noninteractive apt-get -y install tshark > /dev/null 2>&1

echo -e "\n--- Retrieving potiron ---\n"
git clone https://github.com/CIRCL/potiron.git > /dev/null 2>&1

chown -R ubuntu potiron
chgrp -R ubuntu potiron
chmod -R 700 potiron

cd potiron/

echo -e "\n--- Installing potiron ---\n"
pip3 install -r requirements.txt > /dev/null 2>&1
npm install -g phantomjs-prebuilt > /dev/null 2>&1
redis-cli shutdown
chown ubuntu /etc/redis/redis.conf
chgrp ubuntu /etc/redis/redis.conf
chmod 700 /etc/redis/redis.conf
chown ubuntu /var/log/redis/redis-server.log
chgrp ubuntu /var/log/redis/redis-server.log
chmod 700 /var/log/redis/redis-server.log
cat /etc/redis/redis.conf | sed -e "s_# unixsocket /var/run/redis/redis.sock_unixsocket /tmp/redis.sock_g" | sed -e "s_# unixsocketperm_unixsocketperm_g" > redis.conf
cat redis.conf > /etc/redis/redis.conf
redis-server /etc/redis/redis.conf
update-rc.d redis-server enable
# cd ./var/www
# bash ./update_thirdparty.sh
# some errors in this script : http 404 not found...

# how to launch the web server? I don't have read all... ;-)


echo -e "\n--- potiron is ready! Point your Web browser to  ? ;-) ---\n"
