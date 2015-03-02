#!/usr/bin/perl
#本文件通过perl获取当前目录内文件的名称以及时间，这是一个测试脚本
# by ht
# 2015-3-1
my $basedir = '.';
my $d;
my $length;
my @files = ();
my @dirs = ($basedir);
die "error $basedir: $!" unless(-d $basedir); 
my %myHash; 
my $count=0;  
if(@dirs){
   $d = $dirs[0];
   $d .= "/" unless($d=~/\/$/);

   opendir folder, $d || die "Can not open this directory";
   my @filelist = readdir folder;  ##数组
   closedir folder;
   my $f;
   $length=@filelist-2;
   print $length."\n";  #输出文件个个数
   $myHash{"name"}="time";
   foreach (@filelist) {
      #need to remove . and ..
      if($_ eq "." || $_ eq "..")
      {
          #print "ignore"."\n";
          next;
      }
	  my $fileName=$_;
	  print $fileName."	  ";
	  
	  $mtime=(stat $_)[9];
	  @t = localtime $mtime;
	  $date = sprintf "%02u-%02u-%02u %02u:%02u:%02u", $t[4] + 1, $t[3], $t[5] % 100, $t[2], $t[1], $t[0];
      # 格式化时间输出，如02-28-15 18:32:50
	  print $date, "\n";
      $myHash{"$fileName"}=$date;
	  $count=$count+1;
	  #$f = $d.$_;
      #push(@dirs, $f) if(-d $f) ;
      #push(@files,$f)if(-f $f);
    }

}
print "==================================================\n";
my  @key=keys %myHash;
print @key[0]."\n";
print "==================================================\n";
while((my $key,my $value)=each%myHash)
{
        print "$key  =>  $value\n";
} 
$hash_size=keys%myHash;
print $hash_size."\n";

#print "$count";
