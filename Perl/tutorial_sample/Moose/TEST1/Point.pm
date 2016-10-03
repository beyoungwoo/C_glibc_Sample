#!/usr/bin/perl 

package Point;
use Moose;
 
has 'x' => (is => 'rw', isa => 'Int');
has 'y' => (is => 'rw', isa => 'Int');
 
sub clear {
    my $self = shift;
    $self->x(0);
    $self->y(0);
}
 
