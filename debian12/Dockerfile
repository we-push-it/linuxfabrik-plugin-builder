FROM debian:bookworm
SHELL ["/bin/bash", "-c"]
WORKDIR /app
COPY . ./

RUN apt-get -y update
RUN apt-get install -y git python3-venv python3-pip pipx ruby ruby-dev rubygems build-essential policycoreutils
RUN gem install fpm

RUN pip install --break-system-packages pyinstaller

# install any libraries specific for the project:
RUN apt -y install python3-argparse-manpage
RUN apt -y install python3-certifi
RUN apt -y install python3-colorama
RUN apt -y install python3-jinja2
RUN apt -y install python3-lxml
RUN apt -y install python3-netifaces
RUN apt -y install python3-path
RUN apt -y install python3-psutil
RUN apt -y install python3-pymysql
RUN apt -y install python3-xmltodict

RUN chmod +x /app/docker-run.sh
ENTRYPOINT ["/app/docker-run.sh"]
