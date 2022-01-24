#!/bin/bash

#获取脚本根目录
CODE_ROOT_DIR=$(cd `dirname $0`; pwd)
echo "获取脚本根目录："${CODE_ROOT_DIR}

# 导入用户配置
source "${CODE_ROOT_DIR}/config/user.conf"
echo "导入用户配置"

# 导入获取服务器脚本
source "${CODE_ROOT_DIR}/scripts/get_info.sh"

#cd ${CODE_ROOT_DIR}
exit 0