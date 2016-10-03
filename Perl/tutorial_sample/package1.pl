#!/usr/bin/perl 
#
use 5.18.2;
use strict; 
use diagnostics;
use warnings; 

use strict;
use warnings;

sub subroutine {
    say "universe";
}

package Food::Potatoes;

# 이름 충돌이 없다:
sub subroutine {
    say "kingedward";
}

package Animal::Duck;

sub subroutine {
    say "quakquak";
}

subroutine();                 # "kingedward"
main::subroutine();           # "universe"
Food::Potatoes::subroutine(); # "kingedward"
Animal::Duck::subroutine(); # "kingedward"
