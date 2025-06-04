#!/bin/bash
echo "clean log file..."
find /logs -type f -name "*.log" -mtime +1 -exec ls {} \;
find /logs -type f -name "*.log" -mtime +1 -exec rm {} \;



#linux的一个find命令配合rm删除某天前的文件
#语句写法：find 对应目录 -mtime +天数 -name "文件名" -exec rm -rf {} \;


# 例1：　将/usr/local/backups目录下所有10天前带"."的文件删除
# find /usr/local/backups -mtime +10 -name "*.*" -exec rm -rf {} \;
#
#　　find：linux的查找命令，用户查找指定条件的文件
#
#　　/usr/local/backups：想要进行清理的任意目录
#
#　　-mtime：标准语句写法
#
#
# 　＋10：查找10天前的文件，这里用数字代表天数，＋30表示查找30天前的文件
#
#　　"*.*"：希望查找的数据类型，"*.jpg"表示查找扩展名为jpg的所有文件，"*"表示查找所有文件，这个可以灵活运用，举一反三
#
#　　-exec：固定写法
#　　rm -rf：强制删除文件，包括目录
#　　{} \; ：固定写法，一对大括号+空格+\

