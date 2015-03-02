#!/bin/bash
#设置日志文件存放目录
logs_path="/usr/local/nginx/logs/"
#设置pid文件
pid_path="/usr/local/nginx/nginx.pid"

#重命名日志文件
#date -d "yesterday" +"%Y%m%d" 表示获取昨天的日期
mv ${logs_path}access.log ${logs_path}access_$(date -d "yesterday" +"%Y%m%d").log


#向nginx主进程发信号重新打开日志，必须有这句，因为linux靠文件描述而不是文件名来定位文件的
#如果没有这句的话，nginx会继续向重命令后的文件写日志的，这样就没有分割的效果了
kill -USR1 `cat ${pid_path}
