#!/bin/bash

source /root/.bash_profile

gem uninstall backports --force
gem install backports -v 3.21.0 && gem install fpm

rm -R /app/monitoring-plugins
rm -R /app/lib

cd /app && git clone https://github.com/Linuxfabrik/monitoring-plugins.git
cd /app/monitoring-plugins
export RELEASE="$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y%m%d)"

cd /app && git clone https://github.com/Linuxfabrik/lib.git

wget https://bootstrap.pypa.io/pip/3.6/get-pip.py
python get-pip.py
pip install --upgrade setuptools

pip install --upgrade wheel
python -m pip install virtualenv
python -m virtualenv --system-site-packages pyinstaller
source pyinstaller/bin/activate
pip install pyinstaller==4.4
# install any libraries specific for the project:
python -m pip install argparse
python -m pip install beautifulsoup4
python -m pip install certifi
python -m pip install cffi
python -m pip install colorama
python -m pip install counter
python -m pip install datetime
python -m pip install jinja2
python -m pip install lxml
python -m pip install netifaces
python -m pip install path
python -m pip install psutil
python -m pip install pymysql
python -m pip install pysmbclient
python -m pip install python-keystoneclient
python -m pip install python-swiftclient
python -m pip install smbprotocol
python -m pip install uuid
python -m pip install vici
python -m pip install xmltodict

cd /app
chmod +x make
./make

chmod +x /app/check-plugins/rpm-post-install
chmod +x /app/notification-plugins/rpm-post-install

chmod +x /app/check-plugins/runFor.sh
/app/check-plugins/runFor.sh

chmod +x /app/notification-plugins/runFor.sh
/app/notification-plugins/runFor.sh





cd /shareall/
mkdir -p rhel7-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/check-plugins
cd rhel7-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/check-plugins
cp /app/check-plugins/rpm-post-install .

cat > .fpm << EOF
--after-install rpm-post-install
--architecture $(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')
--chdir /tmp/dist/summary/check-plugins
--description "This Enterprise Class Check Plugin Collection offers a bunch of Nagios-compatible check plugins for Icinga, Naemon, Nagios, OP5, Shinken, Sensu and other monitoring applications. Each plugin is a stand-alone command line tool that provides a specific type of check. Typically, your monitoring software will run these check plugins to determine the current status of hosts and services on your network."
--input-type dir
--license "The Unlicense"
--maintainer "info@linuxfabrik.ch"
--name linuxfabrik-monitoring-check-plugins-rhel7
--rpm-summary "The Linuxfabrik Monitoring Plugins Collection (Check Plugins)"
--url "https://github.com/Linuxfabrik/monitoring-plugins"
--vendor "Linuxfabrik GmbH, Zurich, Switzerland"
--version $RELEASE
EOF

fpm --output-type rpm
fpm --output-type tar
fpm --output-type zip

cd /shareall/
mkdir -p rhel7-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/notification-plugins
cd rhel7-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/notification-plugins
cp /app/notification-plugins/rpm-post-install .

cat > .fpm << EOF
--after-install rpm-post-install
--architecture $(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')
--chdir /tmp/dist/summary/notification-plugins
--description "This Enterprise Class Check Plugin Collection offers a bunch of Nagios-compatible check plugins for Icinga, Naemon, Nagios, OP5, Shinken, Sensu and other monitoring applications. Each plugin is a stand-alone command line tool that provides a specific type of check. Typically, your monitoring software will run these check plugins to determine the current status of hosts and services on your network."
--input-type dir
--license "The Unlicense"
--maintainer "info@linuxfabrik.ch"
--name linuxfabrik-monitoring-notification-plugins-rhel7
--rpm-summary "The Linuxfabrik Monitoring Plugins Collection (Check Plugins)"
--url "https://github.com/Linuxfabrik/monitoring-plugins"
--vendor "Linuxfabrik GmbH, Zurich, Switzerland"
--version $RELEASE
EOF

fpm --output-type rpm
fpm --output-type tar
fpm --output-type zip

rm /shareall/rhel7-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/check-plugins/rpm-post-install
rm /shareall/rhel7-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/notification-plugins/rpm-post-install
rm -R /app/monitoring-plugins
rm -R /app/lib
rm -R /app/pyinstaller
find /app/ -name "get-pip.py*" -type f -delete
