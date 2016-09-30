#!/usr/bin/perl
#

use strict;
use warnings;
use utf8;
binmode STDOUT, ":utf8";

use LWP::UserAgent;
use HTML::TagParser;

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;

my $url = 'http://203.247.66.146/iros/RetrieveLifeIndexService/getFsnLifeList';

my $key = '?ServiceKey=TT%2B0PoN6%2B%2F3LaMkX1frj5%2BpM%2Bl6YKE00ftdDWZwMyavHKY31LYhiR%2FfwMKSyT9zFW32KTXAn7wpux9jEpb3%2FCg%3D%3D';
my $local_code = '&AreaNo=1144060000';

my $req_url .= $url;
$req_url .= $key;
$req_url .= $local_code;

my $response = $ua->get($req_url);
 
if (! $response->is_success) {
    die $response->status_line;
}
#print $response->decoded_content; 

my $html = HTML::TagParser->new($response->decoded_content);

my $elem = $html->getElementsByTagName("SuccessYN");
my $ret = $elem->innerText;
if ($ret eq 'Y') {
    $elem = $html->getElementsByTagName("today");
    my $today = $elem->innerText;
    $elem = $html->getElementsByTagName("tomorrow");
    my $tomorrow = $elem->innerText;

    printf "[식중독지수]\n오늘: %s\n내일: %s\n", $today, $tomorrow;
}
else {
    printf "[식중독지수]\nget failed\n";
}



=comm
<?xml version="1.0" standalone="yes"?><Response><Header><SuccessYN>Y</SuccessYN><ReturnCode>00</ReturnCode><ErrMsg></ErrMsg></Header><Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="idxBody"><IndexModel><code>A01_2</code><areaNo>1144060000</areaNo><date>2016071106</date><today>97</today><tomorrow>86</tomorrow><theDayAfterTomorrow>90</theDayAfterTomorrow></IndexModel></Body></Response>%
use XML::LibXML;

my $parser = XML::LibXML->new();
my $doc = $parser->parse_string($response->decoded_content); 
my $root = $doc->documentElement();

my @elem = $root->getElementsByTagName("CAISTEP");
my $step = $elem[0]->firstChild->nodeValue;

my @ch = $root->getElementsByTagName("ALARM_CNDT");
my $val = $ch[0]->firstChild->nodeValue;
print "$step, $val\n";


=cut
