#!/usr/bin/env bash

###################################
#      UOF-STATUS-CLIENT-BASH     #
# (c) 2023 THE UNIVERSITY OF FOOL #
#   -licensed under MIT license-  #
###################################

##### Config_START #####

# 回报服务器状态的间隔,请加上合适的单位(一般不需要更改)
_INTERVAL=60s

# 回报状态类型（不需要更改）
_STATUS=True

# Token (会自动生成)
_TOKEN=

# 客户端 ID (会自动生成)
_ID=

# status 服务器 api 地址
_SERVER_IP="http://127.0.0.1:4044"

##### Config_END #####

# Check CURL
curl 2>&1 >/dev/null
if [[ $? -ne 0 ]];then
cat << EOF
Please make sure "curl" has installed.
Then restart the scripts.
EOF
exit 1
fi

## SOURCE_CONFIG.SH ##
$*
######################

# 获取服务器列表
GET_LIST() {
curl -X GET "$_SERVER_IP/api/server/get"
}
# 获取状态信息
GET_STAT() {
curl -X GET "$_SERVER_IP/api/status/get/$_id"
}
# 检测主服务器状态,遇到错误请注释
GET_LIST || echo -e "\033[31mERROT:Can't connect to main server.\033[0m" & exit 1
# 新增服务器
if [[ $1 == "-i" || $1 == "--init" ]];then
curl -X POST $_SERVER_IP/api/server/put << EOF

{
    "token":"$2",
    "name": "$3",
    "description": "$4"
}
EOF
