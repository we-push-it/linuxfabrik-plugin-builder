FROM debian:buster
SHELL ["/bin/bash", "-c"]
WORKDIR /app
COPY . ./


RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install python3-venv python3-pip
RUN apt-get install -y ruby ruby-dev rubygems build-essential
RUN gem install fpm

RUN python3 -m venv --system-site-packages pyinstaller
RUN source pyinstaller/bin/activate

RUN pip3 install --upgrade pip

RUN pip3 install --upgrade wheel
RUN pip3 install --upgrade setuptools
RUN pip3 install pyinstaller

# install any libraries specific for the project:
RUN pip3 install argparse
RUN pip3 install beautifulsoup4
RUN pip3 install certifi
RUN pip3 install cffi
RUN pip3 install colorama
RUN pip3 install counter
RUN pip3 install datetime
RUN pip3 install jinja2
RUN pip3 install lxml
RUN pip3 install netifaces
RUN pip3 install path
RUN pip3 install psutil
RUN pip3 install pymysql
RUN pip3 install pysmbclient
RUN pip3 install python-keystoneclient
RUN pip3 install python-swiftclient
RUN pip3 install smbprotocol
RUN pip3 install uuid
RUN pip3 install vici
RUN pip3 install xmltodict

RUN chmod +x /app/docker-run.sh
ENTRYPOINT ["/app/docker-run.sh"]
