#!/bin/bash
cat /dev/null > node.conf 
urls=`curl -s -X POST https://rpc.mainnet.near.org -H "Content-Type: application/json" -d '{"jsonrpc": "2.0","method": "network_info","params": [],"id": "dontcare"}'|jq .|grep addr|grep -v null|cut -d '"' -f4`
for url in $urls 
do
  ip=`echo $url|cut -d ':' -f1`
  server_ip_port="$ip:3030"
  echo -e "test node: $server_ip_port \t\c" 
  res=`curl --connect-timeout 1 -m 1 -k -s "http://$server_ip_port" \
 -H 'Content-type:application/json' \
 --data '{"method":"query","params":{"request_type":"view_account","account_id":"386c181ce6ac75e9b133ef61e36f1c023b63ee56ef6681fb89adf625519d81b5","finality":"optimistic"},"id":186,"jsonrpc":"2.0"}'`
 result="echo $res|grep amount|grep block_height"
 if [ -n "$result" ] ;then
	echo "$可用"
	echo $server_ip_port >> node.list
else
	echo "$不可用"
 fi 
done

ngx_file='/etc/nginx/conf.d/near_node_upstream.conf'
cat /dev/null > $ngx_file
echo "upstream near_node {" >> $ngx_file
while read ip_port
do
  echo " server $ip_port;" >> $ngx_file
done < node.list

echo "}" >> $ngx_file

echo "nginx config generate success. path=$ngx_file"
