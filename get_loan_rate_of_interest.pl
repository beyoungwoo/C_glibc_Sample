#!/usr/bin/perl
#

use strict;
use warnings;
use utf8;
binmode STDOUT, ":utf8";

use LWP::UserAgent;
use HTML::TagParser;

my $RENTAL_LOAN_URL = 'http://api.hf.go.kr:8090/service/rest/rentloanrat/getRentLoanRat?servicekey';
my $RENTAL_LOAN_KEY = 'TT%2B0PoN6%2B%2F3LaMkX1frj5%2BpM%2Bl6YKE00ftdDWZwMyavHKY31LYhiR%2FfwMKSyT9zFW32KTXAn7wpux9jEpb3%2FCg%3D%3D';

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;

my $req_url = sprintf ("%s=%s", $RENTAL_LOAN_URL, $RENTAL_LOAN_KEY);
my $response = $ua->get($req_url);

if (! $response->is_success) {
    die $response->status_line;
}

my $html = HTML::TagParser->new($response->decoded_content);

my @resultMsg_list = $html->getElementsByTagName("resultMsg");
my @resultCode_list = $html->getElementsByTagName("resultCode");

for (my $i=0; $i < scalar @resultMsg_list; $i++) {

    my $resultMsg = $resultMsg_list[$i]->innerText;
    my $resultCode = $resultCode_list[$i]->innerText;

    print "$resultCode, $resultMsg \n";

}
