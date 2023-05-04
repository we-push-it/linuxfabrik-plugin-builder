FROM registry.access.redhat.com/ubi7:7.9-1031
SHELL ["/bin/bash", "-c"]
WORKDIR /app
COPY . ./
ARG REDHAT_USERNAME
ARG REDHAT_PASSWORD
ENV REDHAT_USERNAME=$REDHAT_USERNAME
ENV REDHAT_PASSWORD=$REDHAT_PASSWORD

RUN yum-config-manager --enable rhel-server-rhscl-7-rpms
RUN yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/rhscl/centos-release-scl/repo/epel-7/rhscl-centos-release-scl-epel-7.repo

RUN sed -i 's/\(def in_container():\)/\1\n    return False/g' /usr/lib64/python*/*-packages/rhsm/config.py
RUN subscription-manager register --username $REDHAT_USERNAME --password $REDHAT_PASSWORD --auto-attach
RUN subscription-manager repos --enable rhel-server-rhscl-7-rpms

RUN yum -y update
RUN yum -y install wget git binutils centos-release-scl rh-python38 rh-python38-dev rh-python38-python-devel ruby-devel.x86_64 gcc redhat-rpm-config rpm-build squashfs-tools rh-ruby30 rh-ruby30-ruby-devel make rubygems

# use latest python available from scl
RUN scl enable rh-python38 bash
RUN echo "source scl_source enable rh-python38" >> /root/.bash_profile

# use latest ruby available from scl
RUN scl enable rh-ruby30 bash
RUN echo "source scl_source enable rh-ruby30" >> /root/.bash_profile

RUN source /root/.bash_profile

RUN chmod +x /app/docker-run.sh
ENTRYPOINT ["/app/docker-run.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
