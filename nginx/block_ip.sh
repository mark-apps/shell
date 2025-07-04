#!/bin/bash
## 日志文件路径
log_file="/home/logs/client/access.log"
## 当前时间减一分钟的时间
d1=`date -d "-1 minute" +%H:%M`
## 当前时间的分钟段
d2=`date +%M`
## iptables命令所在的路径
ipt="/sbin/iptables"
## 用于存储访问日志里的ip
ips="/tmp/ips.txt"
 
## 封ip
block(){
   ## 把日志文件中的ip过滤出来，去掉重复的ip，并统计ip的重复次数以及对ip进行排序，最后将结果写到一个文件中
   grep "$d1:" $log_file |awk '{print $1}' |sort -n |uniq -c |sort -n > $ips
   ## 将文件里重复次数大于100的ip迭代出来
   for ip in `awk '$1 > 100 {print $2}' $ips`
   do
      ## 通过防火墙规则对这些ip进行封禁
      $ipt -I INPUT -p -tcp --dport 80 -s $ip -j REJECT
      ## 将已经封禁的ip输出到一个文件里存储
      echo "`date +%F-%T` $ip" >> /tmp/badip.txt
   done
}
 
## 解封ip
unblock(){
   ## 将流量小于15的规则索引过滤出来
   for i in `$ipt -nvL --line-number |grep '0.0.0.0/0' |awk '$2 < 15 {print $1}' |sort -nr`
   do
      ## 通过索引来删除规则
      $ipt -D INPUT $i
   done
   ## 清空规则中的数据包计算器和字节计数器
   $ipt -Z
}
 
## 为整点或30分钟就是过了半个小时，就需要再进行分析
if [ $d2 == "00" ] || [ $d2 == "30" ]
then
   unblock
   block
else
   block
fi