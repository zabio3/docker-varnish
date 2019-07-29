#!/bin/bash

# Start varnish and log
/usr/local/sbin/varnishd -f /etc/varnish/default.vcl -s malloc,100M -a 0.0.0.0:${VARNISH_PORT}
/usr/src/varnish-cache/bin/varnishlog/varnishlog
