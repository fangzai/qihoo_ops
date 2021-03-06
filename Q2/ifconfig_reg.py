#!/usr/bin/python

#奇虎运营实习第二题,使用python实现
#解析ifconfig命令的标准输出，返回一个hash。key是网卡名称 value是对应的ip
# by ht
# 2015-2-28
import os
import socket  
import fcntl  
import struct 
def get_ip():
	f=os.popen("ifconfig -s|grep -v Iface|grep -v lo|awk '{print $1}'")  
	##这条shell命令的意思就是读取网卡的名字eth0 eth1等等
	interface=f.readlines()  ##把网卡名放入interface中，可能有多个网卡
	#print interface
	f.close()
	ip_dic={}
	ip_list=[]
	for ifname in interface:
		ifname=ifname.strip()
		s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
		ipaddr=socket.inet_ntoa(fcntl.ioctl(
			s.fileno(),
			0x8915,  # SIOCGIFADDR
			struct.pack('256s', ifname[:15])
			)[20:24])
		
		ip_dic[ifname]=ipaddr    ## 直接就是hash了
		ip_list.append(ipaddr)   ## 加入到ip_list中，可能有几个
        #return ip_list
	return ip_dic
 
if __name__ == '__main__':
    print get_ip()
