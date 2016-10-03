#!/usr/bin/perl

package main;

use Person;

my $person = Person->new(firstname => "Chas.", lastname => "Owens");

print $person->name, "\n";
