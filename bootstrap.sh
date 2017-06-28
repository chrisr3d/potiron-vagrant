#! /usr/bin/env bash


echo -e "\n--- Installing now... ---\n"

echo -e "\n--- Updating packages list ---\n"
apt-get -qq update > /dev/null 2>&1

echo -e "\n--- Install base packages ---\n"
apt-get install -y python3-pip libgeoip-dev > /dev/null 2>&1
# it would maybe be better to install Python 3.6.1 from sources
# (https://gist.github.com/cedricbonhomme/35e81e295fd4baed83d6ccb2cb9fde79) or
# to simply use a virtualenv (https://github.com/berdario/pew)


# installation of redis, etc.


echo -e "\n--- Retrieving potiron ---\n"
git clone https://github.com/CIRCL/potiron.git > /dev/null 2>&1

chown -R ubuntu potiron
chgrp -R ubuntu potiron
chmod -R 700 potiron

cd potiron/

echo -e "\n--- Installing potiron ---\n"
pip3 install -r requirements.txt
cd ./var/www
bash ./update_thirdparty.sh
# some errors in this script : http 404 not found...

# how to launch the web server? I don't have read all... ;-)


echo -e "\n--- potiron is ready! Point your Web browser to  ? ;-) ---\n"
