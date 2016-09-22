#!/usr/bin/perl

use strict;
use warnings;
use utf8;
binmode STDOUT, ":utf8";

use LWP::UserAgent;
use HTML::TagParser;

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;

my $req_url = sprintf ("%s", "http://api.hf.go.kr:8090/service/rest/rentloanrat/getRentLoanRat?ServiceKey=***********************frj5%2BpM%2Bl6YKE00ftdDWZwMyavHKY31LYhiR%2FfwMKSyT9zFW32KTXAn7wpux9jEpb3%2FCg%3D%3D&numOfRows=999&pageNo=1");
print "$req_url\n";
my $response = $ua->get($req_url);

if (! $response->is_success) {
    die $response->status_line;
}


#printf "%s\n", $response->decoded_content;

my $html = HTML::TagParser->new($response->decoded_content);
my @resultMsg_list = $html->getElementsByTagName("resultMsg");
my @resultCode_list = $html->getElementsByTagName("resultCode");
my @organId_list = $html->getElementsByTagName("organId");
my @bssYmdStart_list = $html->getElementsByTagName("bssYmdStart");
my @bssYmdEnd_list = $html->getElementsByTagName("bssYmdEnd");
my @interest2_1_list = $html->getElementsByTagName("interest2_1");
my @interest3_1_list = $html->getElementsByTagName("interest3_1");
my @interest2_2_list = $html->getElementsByTagName("interest2_2");

for (my $i=0; $i < scalar @organId_list; $i++) {

    my $organId = $organId_list[$i]->innerText;
    #my $bssYmdStart = $bssYmdStart_list[$i]->innerText;
    #my $bssYmdEnd = $bssYmdEnd_list[$i]->innerText;
    my $interest2_1 = $interest2_1_list[$i]->innerText;
    my $interest3_1 = $interest3_1_list[$i]->innerText;
    my $interest2_2 = $interest2_2_list[$i]->innerText;


    #print "$organId $bssYmdStart~$bssYmdEnd $interest2_1, $interest3_1\n";
    print "$organId $interest2_1, $interest3_1\n";

}
