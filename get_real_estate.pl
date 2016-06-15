#!/usr/bin/perl
#

use strict;
use warnings;
use utf8;

use 5.18.2;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;

#my $url = 'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade?LAWD_CD=11440&DEAL_YMD=201512&serviceKey=';
#my $url = 'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade';
my $url = 'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptRent';

my ($loc, $ymd);

if (defined $ARGV[1]) {
    $loc = $ARGV[1];
} else { 
    $loc = 11440;
}

if (defined $ARGV[2]) { 
    $ymd = $ARGV[2]; }
else {
    $ymd = 201512;
}

# TODO : change to snprintf
my $req_url .= $url;
$req_url .= '?LAWD_CD=';
$req_url .= $loc;
$req_url .= '&DEAL_YMD=';
$req_url .= $ymd; 
$req_url .= '&serviceKey=';

my $key = 'jxHYst4sbGXo39M2uKPj%2B1zmjDPiJEzt%2BkLXpoLiKMTua6fsl5PWikGlgIuNthm1WXm2WVtMTdwSoIjuH5fR0g%3D%3D';
$req_url .= $key;

my $response = $ua->get($req_url);
 
if (! $response->is_success) {
    die $response->status_line;
}
#print $response->decoded_content; 

use HTML::TagParser;

my $html = HTML::TagParser->new($response->decoded_content);
my @deposit_list = $html->getElementsByTagName("보증금액");
my @money_list = $html->getElementsByTagName("월세금액");
my @area_list = $html->getElementsByTagName("법정동");
my @apt_list = $html->getElementsByTagName("아파트");
my @size_list = $html->getElementsByTagName("전용면적");
my @month_list = $html->getElementsByTagName("월");
my @day_list = $html->getElementsByTagName("일");

my $result = "";

for (my $i=0; $i < scalar @money_list; $i++) {

	my $deposit = $deposit_list[$i]->innerText;
	my $money = $money_list[$i]->innerText;
	my $area = $area_list[$i]->innerText;
	my $apt = $apt_list[$i]->innerText;
	my $size = $size_list[$i]->innerText;
	my $month = $month_list[$i]->innerText;
	my $day = $day_list[$i]->innerText;

	$result .= sprintf ("%s(%s), %s %s, %s (%s/%s)\n", $deposit, $money, $area, $apt, $size, $month, $day);
}
print "$result\n";

=comm

><지번>1643</지번><층>15</층></item><item><년>2015</년><법정동>상암동</법정동><보증금액>    20,000</보증금액><아파트>상암월드컵파크6단지</아파트><월>12</월><월세금액>       140</월세금액><일>21~31</일><전용면적>104.32</전용면적><지번>1689</지번><층>8</층></item><item><년>2015</년><법정동>상암동</법정동><보증금액>    12,795</보증금액><아파트>상암월드컵파크9단지</아파트><월>12</월><월세금액>         0</월세금액><일>21~31</일><전용면적>59.73</전용면적><지번>1752</지번><층>12</층></item><item><년>2015</년><법정동>상암동</법정동><보증금액>    39,000</보증금액><아파트>상암월드컵파크7단지</아파트><월>12</월><월세금액>        35</월세금액><일>21~31</일><전용면적>84.45</전용면적><지번>1660</지번><층>10</층></item><item><년>2015</년><법정동>상암동</법정동><보증금액>    47,000</보증금액><아파트>상암월드컵파크7단지</아파트><월>12</월><월세금액>         0</월세금액><일>21~31</일><전용면적>84.45</전용면적><지번>1660</지번><층>4</층></item><item><년>2015</년><법정동>상암동</법정동><보증금액>     3,500</보증금액><아파트>상암월드컵파크2단지</아파트><월>12</월><월세금액>       120</월세금액><일>21~31</일><전용면적>59.92</전용면적><지번>1637</지번><층>1</층></item><item><년>2015</년><법정동>상암동</법정동><보증금액>    46,000</보증금액><아파트>상암월드컵파크10단지</아파트><월>12</월><월세금액>         0</월세금액><일>21~31</일><전용면적>84.66</전용면적><지번>1736</지번><층>9</층></item><item><년>2015</년><법정동>상암동</법정동><보증금액>    38,000</보증금액><아파트>상암월드컵파크2단지</아파트><월>12</월><월세금액>         0</월세금액><일>21~31</일><전용면적>59.92</전용면적><지번>1637</지번><층>3</층></item><item><년>2015</년><법정동>상암동</법정동><보증금액>    50,000</보증금액><아파트>상암월드컵파크4단지</아파트><월>12</월><월세금액>         0</월세금액><일>21~31</일><전용면적>84.89</전용면적><지번>1655</지번><층>18</층></item></items></body></response>

    my $html = HTML::TagParser->new( "http://www.kawa.net/xp/index-e.html" );
    my @list = $html->getElementsByTagName( "a" );
    foreach my $elem ( @list ) {
        my $tagname = $elem->tagName;
        my $attr = $elem->attributes;
        my $text = $elem->innerText;
        print "<$tagname";
        foreach my $key ( sort keys %$attr ) {
            print " $key=\"$attr->{$key}\"";
        }
        if ( $text eq "" ) {
            print " />\n";
        } else {
            print ">$text</$tagname>\n";
        }
    }
=cut
