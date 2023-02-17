#!/bin/bash

###################################
#      UOF-STATUS-CLIENT-BASH     #
# (c) 2023 THE UNIVERSITY OF FOOL #
#   -licensed under MIT license-  #
###################################

##### Config_START #####

# 回报服务器状态的间隔，以秒为单位
_interval=60  

# 回报状态类型（只在特殊情况下修改）
_status=True

# 客户端 token
_token=""

# 客户端 ID
_id=1

# status 服务器 api 地址
_serverIP="http://127.0.0.1:4044/"

##### Config_END #####

# Check CURL
if [[ $CURL -ne 1 ]];then
cat << EOF
Please make sure "curl" has installed.
Run "let CURL=1".
Then restart the scripts.
EOF
exit 1
fi

## SOURCE_CONFIG.SH ##
$*
######################

# 获取服务器列表
GET_LIST() {
curl -X GET "$_serverIP/api/server/get"
}
# 获取状态信息
GET_STAT() {
curl -X GET "$_serverIP/api/status/get/$_id"
}
