#!/bin/bash
VER_X="0.1.1"
UP_X="2022-02-24"

function sh_init()
{
#获取脚本根目录
CODE_ROOT_DIR=$(cd `dirname $0`; pwd)
echo "获取脚本根目录："${CODE_ROOT_DIR}
source "${CODE_ROOT_DIR}/config/user.conf"
source "${CODE_ROOT_DIR}/scripts/get_info.sh"
}

function run_notify()
{
	bash ${CODE_ROOT_DIR}/scripts/push.sh ${msg} ${msg}
}

function sh_help()
{
	echo "Usage: $0 [option...] {manual|auto}" >&2
	echo "   -r, --run               运行脚本"
	echo "   -v, --version           版本信息"
	echo "   -h, --help              帮助信息"
	echo
	# echo some stuff here for the -a or --add-options 
	exit 0
}

version()
{
	echo -e "--Version:${VER_X}" "\\n--update time:${UP_X}"
	exit 0
}

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
	version
elif [[ "$1" == "-r" || "$1" == "--run" ]]; then
	sh_init
	run_notify
elif [[ "$1" == "-h" || "$1" == "--help" ]]; then
	sh_help
else
	echo "请输出-h 查看正确命令！"
	exit 0
fi	
exit 0
