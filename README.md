# 未经过测试的屎山，暂时不建议使用

# uof-status-client-bash
A client of uof-status written in Bash

https://github.com/University-Of-Fool/uof-status

# 配置方法:

1. 确保curl已安装

2. 克隆此项目
```
git clone https://github.com/University-Of-Fool/uof-status-client-bash.git
cd uof-status-client-bash
```

3. 编辑脚本，更改以下部分
```
# status 服务器 api 地址
_SERVER_IP="服务器IP"

```

3. 初始化客户端
```
chmod +x uof-status.sh
./uof-status.sh --init [全局Token] [名称] [描述]
```

4. 根据输出更改脚本的配置部分
```
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
```
5.测试脚本是否正常运行
```
./uof-status.sh
```

# 在服务器使用:

1. 移动脚本到`/usr/bin`
```
sudo mv uof-status.sh /usr/bin/uof-status
```

2. 分离配置文件

把环境变量单独写在一个文件中，即可通过以下方式运行脚本
```
uof-status source [配置文件路径]
```
[配置文件示例](https://github.com/University-Of-Fool/uof-status-client-bash/blob/main/uof-status.conf)，修改后可以放在/etc/uof-status.conf

3. 配置为Systemd服务
`/etc/systemd/system/uof-status.service`示例
```
[Unit]
Description=UOF-Status Client for Bash
[Service]
ExecStart=/usr/bin/uof-status source /etc/uof-status.conf
[Install]
WantedBy=multi-user.target
```

4. 启动服务
```
sudo systemctl daemon-reload
sudo systemctl enable --now uof-status.service
```
