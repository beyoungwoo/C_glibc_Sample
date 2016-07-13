#!/usr/bin/perl
#

use strict;
use warnings;
use utf8;

use 5.18.2;
use LWP::UserAgent;

binmode STDOUT, ":utf8:";

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;

my $url = 'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptRent';

my ($loc, $ymd);

if (defined $ARGV[1]) {
    $loc = $ARGV[1];
} else { 
    $loc = 11440;
}

my $result = "";
my @z1;
my @z2;

for (my $i=1; $i < 13; $i++) {
    if ($i < 10) {
        $ymd = sprintf ("20160%d", $i);
    } else {
        $ymd = sprintf ("2016%d", $i);
    }

    my $req_url .= $url;
    $req_url .= '?LAWD_CD=';
    $req_url .= $loc;
    $req_url .= '&DEAL_YMD=';
    $req_url .= $ymd; 
    $req_url .= '&serviceKey=';

    my $key = '******4sbGXo39M2uKPj%2B1zmjDPiJEzt%2BkLXpoLiKMTua6fsl5PWikGlgIuNthm1WXm2WVtMTdwSoIjuH5fR0g%3D%3D';
    $req_url .= $key;

    my $response = $ua->get($req_url);

    if (! $response->is_success) {
        die $response->status_line;
    }
#print $response->decoded_content; 

    use HTML::TagParser;

    my $html = HTML::TagParser->new($response->decoded_content);
    my @deposit_list = $html->getElementsByTagName("보증금액");
    my @rental_fee_list = $html->getElementsByTagName("월세금액");
    my @area_list = $html->getElementsByTagName("법정동");
    my @apt_list = $html->getElementsByTagName("아파트");
    my @size_list = $html->getElementsByTagName("전용면적");
    my @floor_list = $html->getElementsByTagName("층");
    my @month_list = $html->getElementsByTagName("월");
    my @day_list = $html->getElementsByTagName("일");


    for (my $j=0; $j < scalar @deposit_list; $j++) {

        my $deposit = $deposit_list[$j]->innerText;
        my $area = $area_list[$j]->innerText;
        my $apt = $apt_list[$j]->innerText;
        next if ($apt ne "마포태영"); 
        my $size = $size_list[$j]->innerText;
        next if ($size ne "59.4");
        my $month = $month_list[$j]->innerText;
        my $day = $day_list[$j]->innerText;
        my $rental_fee = $rental_fee_list[$j]->innerText;
        my $floor = $floor_list[$j]->innerText;

        my @deposit_res = split(/,/, $deposit);

        # TODO
        # 100억 이상은 아직 고려 안함
        # 백만원 단위 미만 버림

        my $rest = substr ($deposit_res[1], 0, 1);

        if ($rental_fee == 0) {
            if ($deposit_res[0]/10 < 1) {
                if ($rest == 0) {
                    $result = sprintf "전세 %d천 %s층 %s (%s/%s)\n", 
                    $deposit_res[0]%10, $floor, $size, $month, $day;
                } else {
                    $result = sprintf "전세 %d.%s천 %s층 %s (%s/%s)\n", 
                    $deposit_res[0]%10, $rest, $floor, $size, $month, $day;
                }
            } elsif ($rest == 0) {
                $result = sprintf "전세 %d.%d억 %s층 %s (%s/%s)\n", 
                $deposit_res[0]/10, $deposit_res[0]%10, $floor, $size, $month, $day ;
            } else {
                $result = sprintf "전세 %d.%d%s억 %s층 %s (%s/%s)\n", 
                $deposit_res[0]/10, $deposit_res[0]%10, $rest, $floor, $size, $month, $day ;
            }
            push @z1, $result;
        }
        else {
            if ($deposit_res[0]/10 < 1) {
                if ($rest == 0) {
                    $result = sprintf "반전세 %d천(%s만원) %s층 %s (%s/%s)\n", 
                    $deposit_res[0]%10, $rental_fee, $floor, $size, $month, $day ;
                } else {
                    $result = sprintf "반전세 %d.%s천(%s만원) %s층 %s (%s/%s)\n", 
                    $deposit_res[0]%10, $rest, $rental_fee, $floor, $size, $month, $day;
                }
            } elsif ($rest == 0) {
                $result = sprintf "반전세 %d.%d억(%s만원) %s층 %s (%s/%s)\n", 
                $deposit_res[0]/10, $deposit_res[0]%10, $rental_fee, $floor, $size, $month, $day ;
            } else {
                $result = sprintf "반전세 %d.%d%s억(%s만원) %s층 %s (%s/%s)\n", 
                $deposit_res[0]/10, $deposit_res[0]%10, $rental_fee, $rest, $floor, $size, $month, $day ;
            }
            push @z2, $result;
        }
    }
}

#for (my $i = 0; $i < scalar @z1; $i++) {
#    print "$z1[$i]";
#}
#for (my $i = 0; $i < scalar @z2; $i++) {
#    print "$z2[$i]";
#}


