#!/bin/bash
userId=$1
curl "https://m.cbhb.com.cn/mbank/public/ecif.MCPerQryCifinfoByUserID.do" \
 -H 'Content-type:application/json' \
 --data "{\"UserId\":\"$userId\",\"MChannel\":\"PMBS\"}"|jq .
