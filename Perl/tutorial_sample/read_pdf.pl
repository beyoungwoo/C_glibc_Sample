#!/usr/bin/perl

use strict;
use warnings;

use CAM::PDF;

my $file = '/sysadmin.pdf'; # file path

my $pdf = CAM::PDF->new($file);

printf "page number = %d\n", $pdf->numPages();
for my $page (1.. $pdf->numPages()) {
    my $text = $pdf->getPageText($page);
    my @lines = split (/\n/, $text);
    foreach (@lines) {
        print "$_\n";
    }

    sleep 1;
}
