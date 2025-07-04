#!/bin/bash
#ifconfig | grep inet | grep -v 'inet6\|127.0.0.1'
ifconfig |grep inet | grep -v 'inet6'
