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

my @callCenter_list = $html->getElementsByTagName("callCenter");

my @interest1_1_list = $html->getElementsByTagName("interest1_1");
my @interest2_1_list = $html->getElementsByTagName("interest2_1");
my @interest3_1_list = $html->getElementsByTagName("interest3_1");
my @interest4_1_list = $html->getElementsByTagName("interest4_1");

my @interest1_2_list = $html->getElementsByTagName("interest1_2");
my @interest2_2_list = $html->getElementsByTagName("interest2_2");
my @interest3_2_list = $html->getElementsByTagName("interest3_2");
my @interest4_2_list = $html->getElementsByTagName("interest4_2");

my $bssYmdStart = $bssYmdStart_list[0]->innerText;
my $bssYmdEnd = $bssYmdEnd_list[0]->innerText;
printf "\n기준년월 : %s~%s\n", $bssYmdStart, $bssYmdEnd;
print "\n[1]\n";
printf "%19s 부분보증비율 기준금리 가산금리 적용금리\n", " ";
for (my $i=0; $i < scalar @organId_list; $i++) {

    my $organId = $organId_list[$i]->innerText;
    my $interest1_1 = $interest1_1_list[$i]->innerText;
    my $interest2_1 = $interest2_1_list[$i]->innerText;
    my $interest3_1 = $interest3_1_list[$i]->innerText;
    my $interest4_1 = $interest4_1_list[$i]->innerText;
    my $callCenter = $callCenter_list[$i]->innerText;

    next if ($interest2_1 == 0);
    
    printf "%s(%9s) %10s%% %8s %8s %8s\n", 
    $organId, $callCenter, $interest1_1, $interest2_1, $interest3_1, $interest4_1;
}
print "\n\n[2]\n";
printf "%19s 부분보증비율 기준금리 가산금리 적용금리\n", " ";
for (my $i=0; $i < scalar @organId_list; $i++) {

    my $organId = $organId_list[$i]->innerText;
    my $interest1_2 = $interest1_2_list[$i]->innerText;
    my $interest2_2 = $interest2_2_list[$i]->innerText;
    my $interest3_2 = $interest3_2_list[$i]->innerText;
    my $interest4_2 = $interest4_2_list[$i]->innerText;
    my $callCenter = $callCenter_list[$i]->innerText;

    next if ($interest2_2 == 0);
    
    printf "%s(%9s) %10s%% %8s %8s %8s\n", 
    $organId, $callCenter, $interest1_2, $interest2_2, $interest3_2, $interest4_2;
}
