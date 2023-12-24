#!/bin/bash

cd /app && git clone https://github.com/Linuxfabrik/monitoring-plugins.git
cd /app/monitoring-plugins
export RELEASE="$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y%m%d)"

cd /app && git clone https://github.com/Linuxfabrik/lib.git

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
mkdir -p debian10-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/check-plugins
cd debian10-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/check-plugins
cp /app/check-plugins/rpm-post-install .

cat > .fpm << EOF
--after-install rpm-post-install
--architecture all
--chdir /tmp/dist/summary/check-plugins
--description "This Enterprise Class Check Plugin Collection offers a bunch of Nagios-compatible check plugins for Icinga, Naemon, Nagios, OP5, Shinken, Sensu and other monitoring applications. Each plugin is a stand-alone command line tool that provides a specific type of check. Typically, your monitoring software will run these check plugins to determine the current status of hosts and services on your network."
--input-type dir
--license "The Unlicense"
--maintainer "info@linuxfabrik.ch"
--name linuxfabrik-monitoring-check-plugins-debian10
--rpm-summary "The Linuxfabrik Monitoring Plugins Collection (Check Plugins)"
--url "https://github.com/Linuxfabrik/monitoring-plugins"
--vendor "Linuxfabrik GmbH, Zurich, Switzerland"
--version $RELEASE
EOF

#fpm --output-type deb
fpm --output-type tar



cd /shareall/
mkdir -p debian10-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/notification-plugins
cd debian10-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/notification-plugins
cp /app/notification-plugins/rpm-post-install .

cat > .fpm << EOF
--after-install rpm-post-install
--architecture $(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')
--chdir /tmp/dist/summary/check-plugins
--description "This Enterprise Class Check Plugin Collection offers a bunch of Nagios-compatible check plugins for Icinga, Naemon, Nagios, OP5, Shinken, Sensu and other monitoring applications. Each plugin is a stand-alone command line tool that provides a specific type of check. Typically, your monitoring software will run these check plugins to determine the current status of hosts and services on your network."
--input-type dir
--license "The Unlicense"
--maintainer "info@linuxfabrik.ch"
--name linuxfabrik-monitoring-notification-plugins-debian10
--rpm-summary "The Linuxfabrik Monitoring Plugins Collection (Check Plugins)"
--url "https://github.com/Linuxfabrik/monitoring-plugins"
--vendor "Linuxfabrik GmbH, Zurich, Switzerland"
--version $RELEASE
EOF

#fpm --output-type deb
fpm --output-type tar

rm debian10-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/check-plugins/rpm-post-install
rm debian10-$(lscpu | grep -oP "Architecture:\K.*" | sed -e 's/^[ \t]*//')/notification-plugins/rpm-post-install

rm -R /app/monitoring-plugins
rm -R /app/lib
rm -R /app/pyinstaller
find /app/ -name "get-pip.py*" -type f -delete
