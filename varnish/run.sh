#!/bin/bash

sleep 180

service varnish restart 

tail -f /dev/null
