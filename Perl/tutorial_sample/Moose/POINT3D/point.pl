#!/usr/bin/perl
#

package Point;
use Moose;

has 'x' => (is => 'rw', isa => 'Int');
has 'y' => (is => 'rw', isa => 'Int');

sub clear {
    my $self = shift;
    $self->x(0);
    $self->y(0);
}

package Point3D;
use Moose;

extends 'Point';

has 'z' => (is => 'rw', isa => 'Int');

after 'clear' => sub {
    my $self = shift;
    $self->z(0);
};

package main;

my $p = Point3D->new( x=>10, y=>20, z=>30);
print $p->x, " ", $p->y, " ", $p->z, "\n";
$p->x(15);
print $p->x, " ", $p->y, " ", $p->z, "\n";
$p->clear;
print $p->x, " ", $p->y, " ", $p->z, "\n";

1;
