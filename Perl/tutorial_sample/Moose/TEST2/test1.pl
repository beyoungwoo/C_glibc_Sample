#!/usr/bin/perl

use strict;
use warnings;

use User;
 
my $user = User->new(
  first_name => 'Example',
  last_name  => 'User',
  password   => 'letmein',
);
 
$user->login('letmein');
 
say $user->date_of_last_login;

