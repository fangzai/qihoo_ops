#!/usr/bin/perl
# 测试dancer框架的使用
# by ht
# 2015-3-1

use Dancer;

get '/' => sub {
    #"Hello There!"
	system("ls -al");  
	return $ENV{'PWD'};
};
#get '/hello/:name' => sub {
    # do something
    # 这段代码需要用 http://localhost:3000/hello/wang 访问
    #return "Hello ".param('name');
#};


Dancer->dance;
