#!/usr/bin/perl -W

package LIB::Array;

use strict;
use diagnostics;
use warnings;


sub new {
    my ($class, %args) = @_;
    return bless { %args }, $class;
}


sub arraysLoop {
    my @browser = ("NS", "IE", "OP");

    print "My favorite books $browser[0]\n";

    #sort keyword
    foreach my $br(sort @browser) {
        print "$br\n";
    }

    #sort
    #sort(ascend @browser);
    #print "@browser";
}

