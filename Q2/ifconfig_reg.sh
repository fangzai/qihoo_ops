#!/bin/bash
#奇虎运营实习第二题,使用shell实现
#解析ifconfig命令的标准输出，返回一个hash。key是网卡名称 value是对应的ip
# by ht
# 2015-2-28
declare -A myEth  ##定义关联数组
num_of_eth=`ifconfig | grep -c "eth"`  # 获取关联数组的长度
hash()
{
	
	#自定义的一个hash函数，在shell里面支持关联数组，这里用关联数组实现
	i=0    #记录网卡的个数
	#echo $num_of_eth  表示这里只有一个网卡
	
	while [ $i -lt $num_of_eth ]
	do
		key="eth"$i
		#echo $key
		ip=`ifconfig $key | grep "inet 地址" | awk -F: '{print $2}' | awk '{print $1}'`
		# 注意这里是中文系统，如果是英文系统的话需要将管道后的grep 改为 grep "inet addr"
		#echo $ip
		myEth[$key]=$ip
		echo -n $key:
		echo ${myEth[$key]}
	let "i+=1"
	done
}
hash
#echo ${myEth["eth0"]}

exit 0
