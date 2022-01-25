#!/bin/bash
DIVISOR="1073741824"
OLD_USAGE="0"
CUR_DATE=$(date +'%s')

TODAY_DAY=$(date +'%Y-%m-%d')
TODAY_SEC=$(date -d "${TODAY_DAY}" +'%s')
CUR_SEC=$(date +'%s')
DIFF_SEC=$((CUR_SEC-TODAY_SEC))

# 判断环境时候有安装jq和bc工具

# 安装工具

# 获取信息
function get_msg(){
    USAGE=$(curl -s https://api.64clouds.com/v1/getLiveServiceInfo?"veid=${V_EID}&api_key=${API_KEY}"|jq -r .data_counter)
    TOTAL=$(curl -s https://api.64clouds.com/v1/getLiveServiceInfo?"veid=${V_EID}&api_key=${API_KEY}"|jq -r .plan_monthly_data)
    LEFT=$((TOTAL - USAGE))
    RESET_DATE=$(curl -s https://api.64clouds.com/v1/getLiveServiceInfo?"veid=${V_EID}&api_key=${API_KEY}"|jq -r .data_next_reset)
}

# 整理有用信息
function org_msg(){
	USAGE=$(echo "scale=4;$USAGE / ${DIVISOR}" |bc | awk '{printf "%.2f", $0}')
	TOTAL=$(echo "scale=4;${TOTAL} / ${DIVISOR}" |bc | awk '{printf "%.2f", $0}')
	LEFT=$(echo "scale=4;${LEFT} / ${DIVISOR}" |bc | awk '{printf "%.2f", $0}')
	LEFT_DATE=$(echo "scale=4;(57600 + ${RESET_DATE} - ${CUR_SEC}) / 86400" |bc | awk '{printf "%.2f", $0}')
	USAGE_RATIO=$(echo "scale=4;(${USAGE} / ${TOTAL} ) * 100" |bc | awk '{printf "%.2f",$0}')
	LEFT_RATIO=$(echo "scale=4;(${LEFT} / ${TOTAL}) * 100" |bc |awk '{printf "%.2f",$0}')
	echo "RESET_DATE:"${RESET_DATE}

	if [ -f ./config/old_usage.txt ];then
	    OLD_USAGE=$(cat ./config/old_usage.txt)
	fi

	if [[ ${CUR_DATE} -ge ${RESET_DATE} ]];then
	    OLD_USAGE=0
	fi

	DIFF=$(echo "$USAGE - $OLD_USAGE" | bc | awk '{printf "%.2f", $0}')

	if [ $DIFF \< 0 ];then
	    DIFF=$USAGE
	    echo $USAGE>./config/old_usage.txt
	fi

	#msg=`echo "BWHServer\n总共流量:${TOTAL}G\n已用流量:${USAGE}G|${USAGE_RATIO}%\n剩余流量:${LEFT}G|${LEFT_RATIO}%\n当日流量:${DIFF}G\n剩余天数:${LEFT_DATE}天"`

	msg=$(echo "当日流量:${DIFF}G\n已用流量:${USAGE}G|${USAGE_RATIO}%\n剩余流量:${LEFT}G|${LEFT_RATIO}%\n剩余天数:${LEFT_DATE}天\n总共流量:${TOTAL}G\n")
	#des=$(sed -i "/s/\n/<br\/>/g" "${msg}")
	echo ${msg}

	if [ $DIFF_SEC -lt 60 ];then
	    echo $USAGE>./config/old_usage.txt
	fi
}

echo "运行getusage函数"
get_msg
org_msg