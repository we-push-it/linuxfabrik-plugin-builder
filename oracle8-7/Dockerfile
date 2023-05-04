FROM oraclelinux:8.7
SHELL ["/bin/bash", "-c"]
WORKDIR /app
COPY . ./


RUN yum -y update
RUN yum -y install git zip binutils python39 python39-devel ruby-devel gcc make rpm-build libffi-devel

RUN alias python3=python3.9

RUN gem install fpm

RUN chmod +x /app/docker-run.sh
ENTRYPOINT ["/app/docker-run.sh"]
