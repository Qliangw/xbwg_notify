#!/bin/bash

SC_ROOT_DIR=$(cd `dirname $0`; pwd)
cd $SC_ROOT_DIR
source ../config/user.conf

# get key
RET=$(curl -s https://qyapi.weixin.qq.com/cgi-bin/gettoken?"corpid=$CORPID&corpsecret=$CORP_SECRET")
KEY=$(echo ${RET} | jq -r .access_token)

cat>./tmp<<EOF
{
   "touser" : "${TOUSER}",
   "msgtype" : "mpnews",
   "agentid" : "${AGENTID}",
   "mpnews" : {
       "articles":[
           {
               "title": "搬瓦工通知", 
               "thumb_media_id": "${MEDIA_ID}",
               "author": "BWHost",
               "content_source_url": "URL",
               "content": "$1",
               "digest": "$2"
            }
       ]
   },
   "safe":0,
   "enable_id_trans": 0,
   "enable_duplicate_check": 0,
   "duplicate_check_interval": 1800
}
EOF

curl -d @tmp -XPOST https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=${KEY}
echo ""
rm tmp