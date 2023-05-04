FROM registry.access.redhat.com/ubi8:8.7-1112
SHELL ["/bin/bash", "-c"]
WORKDIR /app
COPY . ./


RUN yum -y update
RUN yum -y install git zip
RUN yum -y install binutils

RUN yum -y install python39 python39-devel
RUN alias python3=python3.9

RUN yum -y install ruby-devel gcc make rpm-build libffi-devel

RUN gem install fpm

RUN chmod +x /app/docker-run.sh
ENTRYPOINT ["/app/docker-run.sh"]
