#!/bin/bash
log_file=$1
cat $log_file |awk '{print $1}' |sort -n |uniq -c |sort -n 
