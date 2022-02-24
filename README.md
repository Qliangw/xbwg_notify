## xbwg_notify

这是一个通过调用bwg服务器API接口推送服务器状态的脚本。

------

### 使用方法

1. 登录服务器
2. 获取脚本：`git clone https://github.com/Qliangw/xbwg_notify.git`
3. 复制config目录下的`user.conf.default`重命名为`user.conf`，并按照里面的描述进行配置
4. 修改脚本目录的权限 `chmod -R 755 /path/to/xbwg_notify`
5. 运行`bash /path/to/notify.sh -r`脚本进行测试
6. 添加定时任务
(**注意，凌晨12点必须运行一次，才能记录当天所用流量，不然第二天的当日流量不准确**）


## 更新日志

使用 `git pull`若不成功，使用强制更新`git fetch --all && git reset --hard origin/main`
然后修改脚本目录的权限 `chmod -R 755 /path/to/xbwg_notify`

------

### v0.1.1

1. 修复当日使用不准确
2. 修复企业微信详情页排版问题

------

### v0.0.1

完成基础功能
