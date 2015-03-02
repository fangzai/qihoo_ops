#!/usr/bin/env perl

#奇虎运营实习第八题,使用perl+dancer实现
#用perl中的web框架dancer实现一个简单的功能。
#在web端能展示一个table，table有两列，分别是你指定的一个目录下面的文件的时间和文件名。
# by ht
# 2015-3-1

# 执行完该文件之后，去浏览器地址输入 http://localhost:3000/myWeb/param
# 最后的param可以换成你想要的任何值

use Dancer;
use myApp;
use Dancer;
use strict;
#use Template;
#set layout => 'main' ;
 
sub getInfo{
	# 获取当前目录内的文件信息，返回值是一个hash：key是名称，value是时间
	my $basedir = '.';  #当前目录
	my $d;
	my @dirs = ($basedir);
	my %myHash;         #最后函数返回的hash
	die "error $basedir: $!" unless(-d $basedir);    
	if(@dirs)  #如果目录非空
	{
    	$d = $dirs[0];
   		$d .= "/" unless($d=~/\/$/);

   		opendir folder, $d || die "Can not open this directory";   #打开目录
   		my @filelist = readdir folder;   #读取文件存到@filelist中
   		closedir folder;                                           #关闭目录
   		foreach (@filelist)   # 遍历
		{
     		 #去除掉 . and ..，这两个不是文件或者文件夹
      		if($_ eq "." || $_ eq "..")
      		{
          		#print "ignore"."\n";
          		next;            #continue
      		}
	  		#print $_."	";
			my $fileName=$_;     #读取文件名

	  		my $mtime=(stat $_)[9]; #读取文件最近改动时间，stat命令会显示n多属性，这里要的就是第9个属性
	  		my @t = localtime $mtime;
	  		my $date = sprintf "%02u-%02u-%02u %02u:%02u:%02u", $t[4] + 1, $t[3], $t[5] % 100, $t[2], $t[1], $t[0];
			# 格式化时间输出，如02-28-15 18:32:50
      		#print $date, "\n";
        	$myHash{"$fileName"}=$date;
      
    	}
	}
	# 返回hash
	return %myHash;
}

get '/myWeb/:name' => sub {
	# 用于web端展示数据
	my %myHash=getInfo();   # 调用子函数
	my @key=keys%myHash;    # 提取出hash里面的key
	my @value=values%myHash;# 提取出hash里面的value
	#my $size=keys%myHash;
	my $size=@key;
	#$key[0]="app";
    template 'myWeb' => { 
			number => $size,                  # 传入参数  表示显示表格的size
			mykey => [join(",",@key)],        # 用括号处理一下，要不然显示出来，传入数组参数
			myvalue => [join(",",@value)] };  # 同上面的mykey
};
dance;
