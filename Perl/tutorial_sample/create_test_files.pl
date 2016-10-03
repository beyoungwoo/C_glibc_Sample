#!/usr/bin/perl


#################
# create test file 
#
# % test.pl 100
# --> create temp1 ~ temp100
#################

use v5.18.2;
use strict;
use warnings;


my $num_args = $#ARGV +1 ;

if ($num_args != 1) {
    print "\nUsage : $0 num\n";
    exit;
}

sub create_test_files {

    my $fh;
    my $idx;
    my $max_num = $_[0];

    foreach $idx (1 .. $max_num) {
        my $file_name = "temp$idx";
        open ($fh, ">", $file_name) or die "cannot open > $file_name: $!";
        print $fh "$idx\n";
        close ($fh);
    }
}

create_test_files($ARGV[0]);
