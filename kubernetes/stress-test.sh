#!/bin/bash

curl -D /tmp/headers.txt -s -o /dev/null  -w "%{http_code}" -d "username=jordan&password=password" -H "Content-Type: application/x-www-form-urlencoded" -XPOST "http://$HOST/doorman/rest/login"
Authorization=`cat /tmp/headers.txt | grep "Authorization" | awk '{print $2,$3}'`
echo "$http_code"
if [ -z "$Authorization" ];then
  echo " get token failed"
  exit 0
fi

while true
do
  echo "get fibonacci number"
  sleep 0.005
  FIBONA_NUM=`curl -s -H "Authorization: $Authorization" -XGET "http://$HOST/worker/fibonacci/term?n=6"`
  if [ -z "$FIBONA_NUM" ];then
    echo "Get fibonacci number failed"
  fi
  echo $FIBONA_NUM
done

