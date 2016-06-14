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
my $url = 'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade';

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
my @money_list = $html->getElementsByTagName("거래금액");
my @area_list = $html->getElementsByTagName("법정동");
my @apt_list = $html->getElementsByTagName("아파트");
my @size_list = $html->getElementsByTagName("전용면적");
my @month_list = $html->getElementsByTagName("월");
my @day_list = $html->getElementsByTagName("일");

my $result = "";

for (my $i=0; $i < scalar @money_list; $i++) {


	my $money = $money_list[$i]->innerText;
	my $area = $area_list[$i]->innerText;
	my $apt = $apt_list[$i]->innerText;
	my $size = $size_list[$i]->innerText;
	my $month = $month_list[$i]->innerText;
	my $day = $day_list[$i]->innerText;

	$result .= sprintf ("%s, %s %s, %s (%s/%s)\n", $money, $area, $apt, $size, $month, $day);
}
print "$result\n";

=comm

0.03</전용면적><지번>446</지번><층>5</층></item><item><거래금액>    38,900</거래금액><년>2015</년><법정동>성산동</법정동><아파트>성산시영(대우)</아파트><월>12</월><일>1~10</일><전용면적>50.03</전용면적><지번>446</지번><층>6</층></item><item><거래금액>    46,000</거래금액><년>2015</년><법정동>성산동</법정동><아파트>성산시영(유원)</아파트><월>12</월><일>1~10</일><전용면적>59.43</전용면적><지번>446</지번><층>6</층></item><item><거래금액>    39,950</거래금액><년>2015</년><법정동>성산동</법정동><아파트>성산시영(선경)</아파트><월>12</월><일>1~10</일><전용면적>50.54</전용면적><지번>446</지번><층>4</층></item><item><거래금액>    42,000</거래금액><년>2015</년><법정동>성산동</법정동><아파트>월드컵아이파크(667-0)</아파트><월>12</월><일>1~10</일><전용면적>59.73</전용면적><지번>667</지번><층>17</층></item><item><거래금액>    40,300</거래금액><년>2015</년><법정동>성산동</법정동><아파트>성산시영(선경)</아파트><월>12</월><일>1~10</일><전용면적>50.54</전용면적><지번>446</지번><층>11</층></item><item><거래금액>    50,400</거래금액><년>2015</년><법정동>성산동</법정동><아파트>성산2차e-편한세상</아파트><월>12</월><일>11~20</일><전용면적>84.95</전용면적><지번>604</지번><층>12</층></item><item><거래금액>    37,800</거래금액><년>2015</년><법정동>성산동</법정동><아파트>성산시영(대우)</아파트><월>12</월><일>11~20</일><전용면적>50.03</전용면적><지번>446</지번><층>4</층></item><item><거래금액>

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
