#!/usr/bin/perl
use 5.18.2;
use strict;
use warnings;

my @lamps = qw(perl php python);
my @uc_lamps = map { uc($_) } @lamps;
say "[1 map]", @uc_lamps;   
say "[1-1]", $uc_lamps[0];   
say "[1-1]", $uc_lamps[1];   
say "[1-1]", $uc_lamps[2];   
say "--";

my $in = "a1,b:2,d:3,e:f:g";
my %outp = map { split(/:/, $_) } split(/,/, $in);
say "[2 map & split]", %outp;   
say "[2-1]", $outp{'a1'};
say "[2-1]", $outp{'2'};
say "[2-1]", $outp{'3'};
say "[2-2]", $outp{'e'}; # uninitialize value
say "[2-1]", $outp{'f'};
say "--";

my $input = "a1,b:2,d:3";
my @grep_out = grep { m/:/ } split(/,/, $input);
say "[3 grep & split]", @grep_out;
say "[3-1]", $grep_out[0];
say "[3-1]", $grep_out[1];
my %output =
   map  { split(/:/, $_, 2) }
   grep { m/:/ }
   split(/,/, $input);
say "[4 map & grep & split]", %output;
say "[4-1]", $output{'b'};
say "[4-1]", $output{'d'};
say "--";

sub make_query_string {
   my ( $vals ) = @_;
   return join("&", map { "$_=$vals->{$_}" } keys %$vals);
}
my %query_params = (
   a => 1,
   b => 2,
   c => 3,
   d => 4,
);
my $query_string = make_query_string(\%query_params);
say "[5]", $query_string;


my @desired = qw(a c);
my %new_params;
foreach my $key ( @desired ) {
   $new_params{$key} = $query_params{$key};
}
my $query_str = make_query_string(\%new_params);
say "[6]", $query_str;
