#!/bin/bash

cd /app && git clone https://github.com/Linuxfabrik/monitoring-plugins.git
cd /app/monitoring-plugins
export RELEASE="$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y%m%d)"

cd /app && git clone https://github.com/Linuxfabrik/lib.git

python3 -m venv --system-site-packages pyinstaller
source pyinstaller/bin/activate

pip install --upgrade pip

pip install --upgrade wheel
pip install --upgrade setuptools
pip install pyinstaller

# install any libraries specific for the project:
pip install argparse
pip install beautifulsoup4
pip install certifi
pip install cffi
pip install colorama
pip install counter
pip install datetime
pip install jinja2
pip install lxml
pip install netifaces
pip install path
pip install psutil
pip install pymysql
pip install pysmbclient
pip install python-keystoneclient
pip install python-swiftclient
pip install smbprotocol
pip install uuid
pip install vici
pip install xmltodict

cd /app
chmod +x make
./make

chmod +x /app/check-plugins/rpm-post-install
chmod +x /app/notification-plugins/rpm-post-install

chmod +x /app/check-plugins/runFor.sh
/app/check-plugins/runFor.sh

chmod +x /app/notification-plugins/runFor.sh
/app/notification-plugins/runFor.sh


cd /app/check-plugins
cat > .fpm << EOF
--after-install rpm-post-install
--architecture all
--chdir /tmp/dist/summary/check-plugins
--description "This Enterprise Class Check Plugin Collection offers a bunch of Nagios-compatible check plugins for Icinga, Naemon, Nagios, OP5, Shinken, Sensu and other monitoring applications. Each plugin is a stand-alone command line tool that provides a specific type of check. Typically, your monitoring software will these check plugins to determine the current status of hosts and services on your network."
--input-type dir
--license "The Unlicense"
--maintainer "info@linuxfabrik.ch"
--name linuxfabrik-monitoring-plugins
--rpm-summary "The Linuxfabrik Monitoring Plugins Collection (Check Plugins)"
--url "https://github.com/Linuxfabrik/monitoring-plugins"
--vendor "Linuxfabrik GmbH, Zurich, Switzerland"
--version $RELEASE
EOF

fpm --output-type rpm
fpm --output-type tar
fpm --output-type zip

cd /app/notification-plugins
cat > .fpm << EOF
--after-install rpm-post-install
--architecture all
--chdir /tmp/dist/summary/check-plugins
--description "This Enterprise Class Check Plugin Collection offers a bunch of Nagios-compatible check plugins for Icinga, Naemon, Nagios, OP5, Shinken, Sensu and other monitoring applications. Each plugin is a stand-alone command line tool that provides a specific type of check. Typically, your monitoring software will these check plugins to determine the current status of hosts and services on your network."
--input-type dir
--license "The Unlicense"
--maintainer "info@linuxfabrik.ch"
--name linuxfabrik-monitoring-plugins
--rpm-summary "The Linuxfabrik Monitoring Plugins Collection (Check Plugins)"
--url "https://github.com/Linuxfabrik/monitoring-plugins"
--vendor "Linuxfabrik GmbH, Zurich, Switzerland"
--version $RELEASE
EOF

fpm --output-type rpm
fpm --output-type tar
fpm --output-type zip

rm -R /app/monitoring-plugins
rm -R /app/lib
rm -R /app/pyinstaller
find /app/ -name "get-pip.py*" -type f -delete
