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
_STATUS=true

# Token,初始化服务器后手动更改
_TOKEN=

# 客户端 ID,初始化服务器后手动更改
_ID=

# status 服务器 api 地址
_SERVER_IP="http://127.0.0.1:4044"

##### Config_END #####

# Check CURL
curl 2>&1 >/dev/null
if [[ $? -ne 0 ]];then
cat << EOF
\033[31m
Please make sure "curl" has installed.
Then restart the scripts.
\033[0m
EOF
exit 1
fi

## SOURCE_CONFIG.SH ##
$*
######################

# 帮助信息
if [[ $1 == "-h" || $1 =="--help" ]];then
cat << EOF
Usage:

$0
Start running status upload.

$0  -h --help
--Displays help information.

$0  [-i or --init] [Api.global_token] [client-name] [description] 
--Add the client to main server.

$0  [-d or --drop] [Api.global_token] [client-id]
--Remove this client from the server.

EOF
exit 0
fi

# 获取服务器列表
GET_LIST() {
curl -X GET "$_SERVER_IP/api/server/get"
}
# 获取状态信息
GET_STAT() {
curl -X GET "$_SERVER_IP/api/status/get/$_ID"
}
# 检测主服务器状态,遇到错误请注释
GET_LIST || echo -e "\033[31mERROT:Can't connect to main server.\033[0m" & exit 1

# 初始化
if [[ $1 == "-i" || $1 == "--init" ]];then
curl -X POST $_SERVER_IP/api/server/put << EOF

{
    "token":"$2",
    "name": "$3",
    "description": "$4"
}
EOF
echo -e \033[32mPlease edit the scripts and restart.[0m""
exit 0
fi

# 删除服务器
if [[ $1 == "-d" || $1 == "--drop" ]];then
curl -X POST $_SERVER_IP/api/server/drop << EOF

{
    "token":"$2",
    "serverId":"$_ID"
}
EOF
exit 0
fi

# 开始检测状态并上传
__RUN=true
while [[ $__RUN == "true" ]]
do
curl -X POST $_SERVER_IP/api/status/put <<EOF

{
    "serverId": "$_ID",
    "token": "$_TOKEN",
    "online": "$_STATUS"
}
GET_STAT()
sleep $_INTERVAL
done
