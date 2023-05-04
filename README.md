# linuxfabrik-plugin-builder
a Docker container to build the Monitoring Plugins from linuxfabrik


    chmod +x start.sh
    ./start.sh parameter

Possible parameter:

    - all

    - rhel-all
    - rhel7
    - rhel8
    - rhel9

    - debian-all
    - debian10
    - debian11

    - ubuntu-all
    - ubuntu18
    - ubuntu20
    - ubuntu22

    - oracle-all
    - oracle8-6
    - oracle8-7


the plugins will be stored in the respective subfolders, e.g. using debian10:

    ./debian10/check-plugins/*
    ./debian10/notification-plugins/*
