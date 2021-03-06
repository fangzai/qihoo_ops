#!/bin/bash
#奇虎运维实习第六题 shell 实现
#写一个本地服务，定时的搜集系统的cpu使用情况并记录下来。
# by ht 
# 2015-3-1
flag=true
i=0
logFile="cpuInfo.log"   # 日志文件名称（全称）
prefixOfFile="cpuInfo"  # 日志文件名称（前缀）

# 设置日志最大的SIZE
#LIMIT=$((1024*1024*1024*10)) #10G Bytes
#LIMIT=$((1024*1024)) #1K Bytes
LIMIT=$((1024*4)) #1K/100 Bytes   为了测试用的所以就设置了小一些


if [ -f "$logFile" ]   #检测文件存在 删掉
then
	rm "$logFile"  # 直接清除文件
fi
if [ ! -f "$logFile" ] 
then
	touch "$logFile"      # 检测文件如果不存在
	chmod 700 "$logFile"  # 将rwx------权限赋给该文件
	#chmod 777 "$logFile"  # 将rwxrwxrwx权限赋给该文件
fi 
while [ flag ]
do
	fileSize=`stat -c%s $logFile`     # 获取文件大小信息
	if [ "$fileSize" -gt "$LIMIT" ]
	then
		##切割文件
		mv "$logFile" "$prefixOfFile$(date -d "Today" +"%Y%m%d"_"%s").log"  
		# 重命名为年月日+时间，这下可以任意操作旧日志
		echo "文件太大了"
		touch "$logFile"      # 把新建一个与原来名称及权限一样的日志文件
		chmod 700 "$logFile"  # 将rwx------权限赋给该文件
		#chmod 777 "$logFile"  # 将rwxrwxrwx权限赋给该文件
	fi

	cpu=`top -b -n 1 `  #获取cpu的各种信息，总共有12列，前几行是汇总信息
	# cpu的使用情况包括 PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
	# 这里先把所有程序的使用情况列举出来，按照cpu占用率由高到低排序，输出前10个占用较高的程序
	# 当然也可以改变这个数字，还可以选择 PID，USER，PR等信息不输出
	cpuPer=`echo "$cpu" | grep "%Cpu(s)"`  # top命令前几行有一个汇总信息，输出包含  %Cpu(s)的这一行
	columnTitle=`echo "$cpu" | grep "PID"` # 把Title这一行拿出来，因为后面的需要排序
	content=`echo "$cpu"| tail -n +8 |tr -s " "| sed 's/^[ \t]*//g' |sort -t' ' -k 9nr | head -n 10`
	#  管道依次功能为 输出第8行以后的内容， 8 这个数字是数出来的
	#                删除多余的空格，以及首行空格
	#                按照第9列（CPU）从高到低排序
	#                取前10行
	content=`echo "$columnTitle"&& echo "$content"`  # 表头与内容拼接
	content=`echo "$content" | column -t`            # 格式化输出
	wholeFile=` date && echo "$cpuPer" && echo "$content" \\
    && echo "======================================================================================="` 
	# 拼接时间日期，cpu汇总以及内容
	echo "$wholeFile" >> $logFile  #附加文本到cpuInfo.log这个文件中去
	let "i+=1"
	echo $i
	sleep 1    # 表示每隔1s检测一次
	#sleep 3 h  #表示每隔3h检测一次
done
exit 0

