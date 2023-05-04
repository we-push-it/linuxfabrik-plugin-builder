#!/bin/bash

for file in $(cd /tmp/dist/summary/check-plugins; find . -type f | sort); do
    # strip leading './'
    file="${file#./}"
    echo "$file=/usr/lib64/nagios/plugins/$file" >> .fpm
done
