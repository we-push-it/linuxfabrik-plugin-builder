FROM debian:bullseye
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

RUN pip install --upgrade pip

RUN pip install --upgrade wheel
RUN pip install --upgrade setuptools
RUN pip install pyinstaller

# install any libraries specific for the project:
RUN pip install argparse
RUN pip install beautifulsoup4
RUN pip install certifi
RUN pip install cffi
RUN pip install colorama
RUN pip install counter
RUN pip install datetime
RUN pip install jinja2
RUN pip install lxml
RUN pip install netifaces
RUN pip install path
RUN pip install psutil
RUN pip install pymysql
RUN pip install pysmbclient
RUN pip install python-keystoneclient
RUN pip install python-swiftclient
RUN pip install smbprotocol
RUN pip install uuid
RUN pip install vici
RUN pip install xmltodict


RUN chmod +x /app/docker-run.sh
ENTRYPOINT ["/app/docker-run.sh"]
