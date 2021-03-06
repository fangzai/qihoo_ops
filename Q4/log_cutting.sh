#!/bin/bash
#奇虎运维实习第四题 shell 实现
#日志切割，有这样一个access.log每天会打出大量的日志。实现一个日志切割的功能，并说明该实现方式会有什么缺陷。
# by ht from  nginx服务器日志切割管理
# 2015-2-28
# 使用说明和缺陷分析见log_cutting_instruction

#设置日志文件存放目录,以nginx服务器为例
logs_path="/usr/local/nginx/logs/"
#设置pid文件
pid_path="/usr/local/nginx/nginx.pid"

#重命名日志文件
#date -d "yesterday" +"%Y%m%d" 表示获取昨天的日期
mv ${logs_path}access.log ${logs_path}access_$(date -d "yesterday" +"%Y%m%d").log


#向nginx主进程发信号重新打开日志，必须有这句，因为linux靠文件描述而不是文件名来定位文件的
#如果没有这句的话，nginx会继续向重命令后的文件写日志的，这样就没有分割的效果了
kill -USR1 `cat ${pid_path}
exit 0
