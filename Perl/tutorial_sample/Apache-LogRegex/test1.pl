#!/usr/bin/perl 
#
use strict; 
use diagnostics;
use warnings; 

use Apache::LogRegex
print "=== test ===\n";

my $line1  = '212.74.15.68 - - [23/Jan/2004:11:36:20 +0000] "GET /images/previous.png HTTP/1.1" 200 2607 "http://peterhi.dyndns.org/bandwidth/index.html" "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202"';

my $format = '%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"';
my $newRegex = Apache::LogRegex->new($format);
my $r = $newRegex->regex();

print "$r\n\n\n";
print "$line1\n";

my %data = $newRegex->parse($line1);
print "[1 h] $data{'%h'}\n";
print "[2 l] $data{'%l'}\n";
print "[3 u] $data{'%u'}\n";
print "[4 t] $data{'%t'}\n";
print "[5 r] $data{'%r'}\n";
print "[6 >s]$data{'%>s'}\n";
print "[7 b] $data{'%b'}\n";
print "[8 %{Referer}i] $data{'%{Referer}i'}\n";
print "[9 %{User-Agent}i] $data{'%{User-Agent}i'}\n";

=comment1

212.74.15.68 - - [23/Jan/2004:11:36:20 +0000] "GET /images/previous.png HTTP/1.1" 200 2607 "http://peterhi.dyndns.org/bandwidth/index.html" "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202"

[1 h] 212.74.15.68
[2 l] -
[3 u] -
[4 t] [23/Jan/2004:11:36:20 +0000]
[5 r] GET /images/previous.png HTTP/1.1
[6 >s]200
[7 b] 2607
[8 %{Referer}i] http://peterhi.dyndns.org/bandwidth/index.html
[9 %{User-Agent}i] Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202

=cut
