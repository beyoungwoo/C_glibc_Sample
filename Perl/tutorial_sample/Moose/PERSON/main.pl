#!/usr/bin/perl
#
use strict;
use warnings;

use Person;
use Student;
use Dog;

my $person = Person->new( name => 'Tom', birth_year => 1980 );
$person->speak;
 
my $student = Student->new( name => 'John', birth_year => 1985, school => 'MIT' );
$student->speak;
 
my $dog = Dog->new( birth_year => 2005 );
$dog->speak;

my $dage;
$dage = $dog->age;
print "$dage\n";
