#!/usr/bin/perl 
#
use strict;                 # use all three strictures
$|++;                       # set command buffering

use Data::Dumper;
use feature 'say';

my $hash_ref1 = { 1=> 1 };
my $hash_ref2 = $hash_ref1;

print "hash_ref1 $hash_ref1\n";
print "hash_ref2 $hash_ref2\n"; # same, same

say Dumper($hash_ref1);
say Dumper($hash_ref2); # same, same

$hash_ref1->{2} = 2;

say Dumper($hash_ref1);
say Dumper($hash_ref2); # same, same

#$hash_ref1 = {}; # if you did this instead of the for-loop, hash_ref2 would be different
for (keys %$hash_ref1)
{
    delete $hash_ref1->{$_};
}

print "hash_ref1 $hash_ref1\n";
print "hash_ref2 $hash_ref2\n"; # same, same?

say Dumper($hash_ref1);
say Dumper($hash_ref2); # same, same?
