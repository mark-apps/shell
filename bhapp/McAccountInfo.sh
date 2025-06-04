#!/bin/bash
acctNo=$1
subAcct=$2
curl "https://m.cbhb.com.cn/mbank/public/corebanking.MCAccountInfoQry.do" \
 -H 'Content-type:application/json' \
 --data "{\"AcctNo\":\"$acctNo\",\"Ccy\":\"CNY\",\"SubAcct\":\"$subAcct\"}"|jq .
