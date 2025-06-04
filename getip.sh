#!/bin/bash
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }

getip(){
  IP=`ifconfig|grep inet|grep -v 'inet6'`
  /bin/echo -e  "${magenta}$IP${none}"
}

getipw(){
  echo -e "${yellow}==>>>https://2022.ipchaxun.com/${none}"
  res=`curl -k -s --connect-timeout 3 -m 3 'https://2022.ipchaxun.com/'`
  echo -e "${green} $res ${none}"
  echo ""
  echo -e "${yellow}==>>>http://cip.cc/ ${none}"
  res=`curl -k -s --connect-timeout 3 -m 3 'http://cip.cc'`
  echo -e "${green} ${res} ${none}"
}

echo "---------------获取ip开始---------------"

echo -e "\n========本地IP========="
getip

echo -e "\n========外网IP========="
getipw

echo -e "\n\n----------获取ip结束---------------"
