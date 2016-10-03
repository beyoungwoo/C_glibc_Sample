#!/usr/bin/perl
package F;

use Moose;
use Smart::Args;

sub func2 {
    args my $p => 'Int',
         my $q => { isa => 'Int', optional => 1 };
}

sub func3 {
    args my $p => {isa => 'Int', default => 3},
}

sub method {
    args my $self,
         my $p => 'Int';
}

sub class_method {
    args my $class => 'ClassName',
         my $p => 'Int';
}

sub simple_method {
    args_pos my $self, my $p;
}

my $f = F->new();
$f->method(p => 3);

F->class_method(p => 3);
F->simple_method(3);
