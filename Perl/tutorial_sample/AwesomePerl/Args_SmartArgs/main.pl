#!/usr/bin/perl

use Smart::Args;

sub func2 {
    args my $p => 'Int',
         my $q => { isa => 'Int', optional => 1 };
}
func2(p => 3, q => 4);
#func2(p => "ad");
func2(p => 6666666666666666666);

sub func3 {
    args my $p => {isa => 'Int', default => 3},
}
func3(p => 4);
func3();
