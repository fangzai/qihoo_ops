#!/bin/bash
# 本文件实现的提取cpu的使用信息，并输出占用排前10的进程信息，输出到cupInfo.log里面
#2015-3-1
#cpu=`top -b -n 1 | head -n 17 | tail -n +8 | awk '{print $2}'`
#cpu=`top -b -n 1 | head -n 27 | tail -n +8`  #表示输出8到27
cpu=`top -b -n 1 `  #表示从第8行开始计数
rm data.txt 
echo "$cpu" > data.txt

#echo "$cpu" |tr -s " "|sed 's/^[ \t]*//g' |sort -t' ' -k 1n
#echo "$cpu"
cpuPer=`echo "$cpu" | grep "%Cpu(s)"`
columnTitle=`echo "$cpu" | grep "PID"`
#echo $cpuPer
#echo $columnTitle
#content=`cat  data.txt| tail -n +8 |tr -s " "| sed 's/^[ \t]*//g' |sort -t' ' -k 9n | head -n 10 | column -t`
content=`cat  data.txt| tail -n +8 |tr -s " "| sed 's/^[ \t]*//g' |sort -t' ' -k 9nr | head -n 10`

content=`echo "$columnTitle"&& echo "$content"`
content=`echo "$content" | column -t`
wholeFile=` date && echo "$cpuPer" && echo "$content"`

echo "$wholeFile" >> cpuInfo.log



#sort -t ' ' -k 1 > data.txt
#for i in `top -b -n 1 | head -n 17 | tail -n +7`
echo "====================================================="

exit 0

