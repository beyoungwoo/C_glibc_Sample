#!/usr/bin/perl
#
use strict;
use diagnostics;
use warnings;

use Apache::LogRegex;
use Data::Dumper;
use feature 'say';

print "=== apache log check ===\n";


my $filename = '/Users/jeonbyeong-u/src/alog';

my $format = '%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"';
my $newRegex = Apache::LogRegex->new($format);
my $r = $newRegex->regex();
open (my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open $filename' $!";

my @apacheUser;
my $idx = 0;
while (my $row = <$fh>) {
    my %data = $newRegex->parse($row);
    $apacheUser[$idx] = "$data{'%u'}";
    #print "$apacheUser[$idx]\n";
    $idx++;
}

@apacheUser = sort @apacheUser;

my $lastUser = "\0";
$idx = 1;
my $maxIdx = 0;
my $maxId = 0;

my $hashUser;

foreach my $user(@apacheUser) {
    #print "$lastUser $user \t";
    if ($lastUser eq $user) {
        $idx++;
    }
    else {
        if ($idx > $maxIdx) {
            if ($lastUser ne "-") {
                $maxId = $lastUser;
                $maxIdx = $idx;
            }
        }
        print "$lastUser, $idx\n";

        $hashUser->{$lastUser} = $idx;

        $idx = 1;
        $lastUser = $user;
    }
}
print "\n\n\nMAX: $maxId, $maxIdx\n";


say Dumper($hashUser);

#foreach my $hUser (sort values %hashUser) {
#    say $hUuser
#}



#my $lineNum = `cat $filename | wc -l | awk '{print \$1}'`;
#print $lineNum;
#foreach $elem (0.. $lineNum)


#foreach my $user(@apacheUser) {
#    print "$user\n";
#}

#    print "$data{'%h'}\t";
#    print "$data{'%l'}\t";
#    print "$data{'%u'}\t";
#    print "$data{'%t'}\t";
#    print "$data{'%r'}\t";
#    print "$data{'%>s'}\t";
#    print "$data{'%b'}\t";
#    print "$data{'%{Referer}i'}\t";
#    print "$data{'%{User-Agent}i'}\t";
#
#    print "[1 h] $data{'%h'}\n";
#    print "[2 l] $data{'%l'}\n";
#    print "[3 u] $data{'%u'}\n";
#    print "[4 t] $data{'%t'}\n";
#    print "[5 r] $data{'%r'}\n";
#    print "[6 >s]$data{'%>s'}\n";
#    print "[7 b] $data{'%b'}\n";
#    print "[8 %{Referer}i] $data{'%{Referer}i'}\n";
#    print "[9 %{User-Agent}i] $data{'%{User-Agent}i'}\n";
