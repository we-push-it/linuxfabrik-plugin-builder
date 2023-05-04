#!/bin/bash

#rhel7
function rhel7 () {

  docker login registry.redhat.io -u USER -p PASSWORD

  docker build \
  --no-cache \
  --build-arg REDHAT_USERNAME=USER \
  --build-arg REDHAT_PASSWORD=PASSWORD \
  --force-rm \
  -t linuxfabrik-plugin-builder:rhel7 \
  ./rhel7

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/rhel7",target=/app \
  linuxfabrik-plugin-builder:rhel7

}

#rhel8
function rhel8 () {

  docker login registry.redhat.io -u USER -p PASSWORD

  docker build \
  --no-cache \
  --build-arg REDHAT_USERNAME=USER \
  --build-arg REDHAT_PASSWORD=PASSWORD \
  --force-rm \
  -t linuxfabrik-plugin-builder:rhel8 \
  ./rhel8

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/rhel8",target=/app \
  linuxfabrik-plugin-builder:rhel8

}

#rhel9
function rhel9 () {

  docker login registry.redhat.io -u USER -p PASSWORD

  docker build \
  --no-cache \
  --build-arg REDHAT_USERNAME=USER \
  --build-arg REDHAT_PASSWORD=PASSWORD \
  --force-rm \
  -t linuxfabrik-plugin-builder:rhel9 \
  ./rhel9

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/rhel9",target=/app \
  linuxfabrik-plugin-builder:rhel9
  
}

#debian10
function debian10 () {

  docker build \
  --no-cache \
  --force-rm \
  -t linuxfabrik-plugin-builder:debian10 \
  ./debian10

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/debian10",target=/app \
  linuxfabrik-plugin-builder:debian10
  
}

#debian11
function debian11 () {
  
  docker build \
  --no-cache \
  --force-rm \
  -t linuxfabrik-plugin-builder:debian11 \
  ./debian11

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/debian11",target=/app \
  linuxfabrik-plugin-builder:debian11
  
}

#ubuntu18
function ubuntu18 () {
  
  docker build \
  --no-cache \
  --force-rm \
  -t linuxfabrik-plugin-builder:ubuntu18 \
  ./ubuntu18

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/ubuntu18",target=/app \
  linuxfabrik-plugin-builder:ubuntu18
  
}

#ubuntu20
function ubuntu20 () {
  
  docker build \
  --no-cache \
  --force-rm \
  -t linuxfabrik-plugin-builder:ubuntu20 \
  ./ubuntu20

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/ubuntu20",target=/app \
  linuxfabrik-plugin-builder:ubuntu20
  
}

#ubuntu22
function ubuntu22 () {
  
  docker build \
  --no-cache \
  --force-rm \
  -t linuxfabrik-plugin-builder:ubuntu22 \
  ./ubuntu22

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/ubuntu22",target=/app \
  linuxfabrik-plugin-builder:ubuntu22
  
}

#oracle8-6
function oracle8-6 () {

  docker build \
  --no-cache \
  --force-rm \
  -t linuxfabrik-plugin-builder:oracle8-6 \
  ./oracle8-6

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/oracle8-6",target=/app \
  linuxfabrik-plugin-builder:oracle8-6

}

#oracle8-7
function oracle8-7 () {

  docker build \
  --no-cache \
  --force-rm \
  -t linuxfabrik-plugin-builder:oracle8-7 \
  ./oracle8-7

  docker run \
  --rm \
  --mount type=bind,source="$(pwd)/oracle8-7",target=/app \
  linuxfabrik-plugin-builder:oracle8-7

}

#all
function all () {

  rhel7;
  rhel8;
  rhel9;
  debian10;
  debian11;
  ubuntu18;
  ubuntu20;
  ubuntu22;

}

#rhel-all
function rhel-all () {

  rhel7;
  rhel8;
  rhel9;

}

#debian-all
function debian-all () {

  debian10;
  debian11;

}

#ubuntu-all
function ubuntu-all () {

  ubuntu18;
  ubuntu20;
  ubuntu22;

}

#oracle-all
function oracle-all () {

  oracle8-6;
  oracle8-7;

}

case "$1" in
    'all') "$@"; exit;;
    'rhel-all') "$@"; exit;;
    'rhel7') "$@"; exit;;
    'rhel8') "$@"; exit;;
    'rhel9') "$@"; exit;;
    'debian-all') "$@"; exit;;
    'debian10') "$@"; exit;;
    'debian11') "$@"; exit;;
    'ubuntu-all') "$@"; exit;;
    'ubuntu18') "$@"; exit;;
    'ubuntu20') "$@"; exit;;
    'ubuntu22') "$@"; exit;;
    'oracle-all') "$@"; exit;;
    'oracle8-6') "$@"; exit;;
    'oracle8-7') "$@"; exit;;
*)
    echo '';
    echo 'Possible cases:';
    echo '';
    echo '- all';
    echo '';
    echo '- rhel-all';
    echo '- rhel7';
    echo '- rhel8';
    echo '- rhel9';
    echo '';
    echo '- debian-all';
    echo '- debian10';
    echo '- debian11';
    echo '';
    echo '- ubuntu-all';
    echo '- ubuntu18';
    echo '- ubuntu20';
    echo '- ubuntu22';
    echo '';
    echo '- oracle-all';
    echo '- oracle8-6';
    echo '- oracle8-7';
    echo '';
    ;;
esac





