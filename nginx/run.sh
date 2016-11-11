#!/bin/bash

service php5-fpm restart 
service nginx restart

tail -f /dev/null
