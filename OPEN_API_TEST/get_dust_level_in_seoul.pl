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

my $url = 'http://openAPI.seoul.go.kr:8088/756e6d666b6a656f38346e764e734e/xml/ForecastWarningMinuteParticleOfDustService/1/1/';

my $response = $ua->get($url);
 
if (! $response->is_success) {
    die $response->status_line;
}
#print $response->decoded_content; 

use XML::LibXML;

my $parser = XML::LibXML->new();
my $doc = $parser->parse_string($response->decoded_content); 
my $root = $doc->documentElement();

my @elem = $root->getElementsByTagName("CAISTEP");
my $step = $elem[0]->firstChild->nodeValue;

my @ch = $root->getElementsByTagName("ALARM_CNDT");
my $val = $ch[0]->firstChild->nodeValue;
print "$step, $val\n";

=comment
use HTML::TagParser;
<?xml version="1.0"?><ForecastWarningMinuteParticleOfDustService>
<list_total_count>1</list_total_count>
<RESULT>
<CODE>INFO-000</CODE>
<MESSAGE>정상 처리되었습니다</MESSAGE>
</RESULT>
<row>
<APPLC_DT>201606242300</APPLC_DT>
<FA_ON>f</FA_ON>
<POLLUTANT>pm10</POLLUTANT>
<CAISTEP>보통</CAISTEP>
<ALARM_CNDT><![CDATA[외출 등 실외활동에 지장 없음]]></ALARM_CNDT>
<ALERTSTEP/>
<CNDT1/>
</row>
</ForecastWarningMinuteParticleOfDustService>
