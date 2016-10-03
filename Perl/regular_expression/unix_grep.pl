#!/usr/bin/perl

use v5.18.2;
use strict;
use warnings;

# argv[0] : pattern 
# argv[1] : file
#
#   usage   : ./unix_grep.pl POST apache_http.pl

$regexp = shift;
while ( <> ) {
    print if /$regexp/;
}
