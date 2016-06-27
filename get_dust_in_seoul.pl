#!/usr/bin/perl
#

use strict;
use warnings;
use utf8;

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
print $response->decoded_content; 

my $html = HTML::TagParser->new($response->decoded_content);

my $elem = $html->getElementsByTagName("CAISTEP");
my $current = $elem->innerText;
print "$current\n";

#my $elem = $html->getElementsByTagName("ALARM_CNDT");

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
