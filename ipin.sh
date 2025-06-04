#!/bin/sh
ROOT_PATH=/nas/app/app_icons/
TEMP_PATH=/nas/app/temp/
echo "当前处理文件：$1"
cd $TEMP_PATH
python ipin.py
mv $1 $ROOT_PATH
