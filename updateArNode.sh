#!/bin/bash
WORK_DIR=/app
server_list=$WORK_DIR/server.list
ngx_file=$WORK_DIR/ar_node_upstream.conf


cat /dev/null > $server_list
lastestBlockHeight=`curl -s  "https://arweave.net/info"|jq .height`
if [ -z $lastestBlockHeight ];then
  echo "获取最新高度失败，稍后重试...."
  exit 1
fi
echo "最新高度：$lastestBlockHeight"
sleep 1

curl -s "https://arweave.net/peers"|jq .|grep -v "\[" | grep -v "\]" |grep -v "127.0"|grep "1984" | while read line
do
  ip_port=`echo $line|sed -e 's/"//g'|sed -e 's/,//g'`
  #echo "test $ip_port...."
  res=`curl -s  --connect-timeout 1 -m 1 "http://$ip_port/info"`
  if [ -z "$res" ] ; then
    continue;
  fi
  network=`echo $res|jq .network|sed -e 's/"//g'`
  if [[ $newwork == "arweave.fast.testnet" ]] || [[ "$network" != "arweave.N.1" ]]; then
       echo "$ip_port  network: $network  network not match,skip...."
        continue;
  fi
  height=`echo $res|jq .height`
  if [ -n "$height" ] ; then
     height_diff=$(($height-$lastestBlockHeight))
     echo "ip_port: $ip_port height: $height height_diff ==> $height_diff"
     if [ $height_diff -ge 0 ] && [ $height_diff -lt 10 ] ;then
        echo "$ip_port" >>$server_list
        echo "add node: $ip_port  block_height:$height height_diff: $height_diff"
     fi
  fi
done

if [ ! -s $server_list ] ;then
  echo "Server list is empty,do not update configuration."
  exit 1
fi

cat /dev/null > $ngx_file
echo "upstream arweave_node {" >> $ngx_file
while read ip_port
do
  echo "  server $ip_port;" >> $ngx_file
done < $server_list

echo "}" >> $ngx_file

echo "nginx config generate success. path=$ngx_file"
echo ""
echo "copy $ngx_file to /etc/nginx/conf.d/ar_node_upstream.conf"
cp $ngx_file /etc/nginx/conf.d/ar_node_upstream.conf

echo "test nginx configuration"
/usr/sbin/nginx -t

echo "restart nginx"
#systemctl restart nginx
/usr/sbin/nginx -s reload

echo "nginx restart success."
echo ""
