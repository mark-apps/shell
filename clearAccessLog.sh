#!/bin/bash
echo "clean log file..."
find /logs -type f -name "*.log" -mtime +1 -exec ls {} \;
find /logs -type f -name "*.log" -mtime +1 -exec rm {} \;
