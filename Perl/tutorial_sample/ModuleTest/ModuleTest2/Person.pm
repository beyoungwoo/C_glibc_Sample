#!/usr/bin/perl

package Person;

use strict;
use warnings;
use Carp;

sub new {
    my $class = shift;
    my $self  = { @_ };
    croak "bad arguments" unless defined $self->{firstname} and defined $self->{lastname}; 
    return bless $self, $class; #this is what makes a reference into an object
}

sub name {
    my $self = shift;
    return "$self->{firstname} $self->{lastname}";
}
