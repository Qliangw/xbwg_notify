#!/bin/bash

VER_X="0.0.1"
UP_X="2022-01-26"

#获取脚本根目录
CODE_ROOT_DIR=$(cd `dirname $0`; pwd)
echo "获取脚本根目录："${CODE_ROOT_DIR}

# 导入用户配置
source "${CODE_ROOT_DIR}/config/user.conf"
echo "导入用户配置"

# 导入获取服务器脚本
source "${CODE_ROOT_DIR}/scripts/get_info.sh"


bash ${CODE_ROOT_DIR}/scripts/push.sh ${msg} ${msg}

version()
{
	echo -e "--Version:${VER_X}" "\\n--update time:${UP_X}"
	exit 0
}

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
	version
fi
exit 0