#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Encode;
binmode STDOUT, ":utf8";

use WWW::Telegram::BotAPI;
use LWP::UserAgent;
use DBD::mysql;
use Log::Log4perl qw(:easy);
use POSIX qw(strftime);

use HTML::TagParser;
use XML::LibXML;

my $TELEGRAM_TOKEN = '***************y6ZE2BoTrBbw49PVhe-Pqwnm9M16Es';

my $RENT_KEY = '***************2uKPj%2B1zmjDPiJEzt%2BkLXpoLiKMTua6fsl5PWikGlgIuNthm1WXm2WVtMTdwSoIjuH5fR0g%3D%3D';
my $APT_RENT_URL = 'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptRent';
my $SEOUL_DUST_URL = 'http://openAPI.seoul.go.kr:8088/756e6d666b6a656f38346e764e734e/xml/ForecastWarningMinuteParticleOfDustService/1/1/';

my $POST_URL = 'http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdSearchAllService/retrieveNewAdressAreaCdSearchAllService/getNewAddressListAreaCdSearchAll';
my $POST_KEY = '***************F3LaMkX1frj5%2BpM%2Bl6YKE00ftdDWZwMyavHKY31LYhiR%2FfwMKSyT9zFW32KTXAn7wpux9jEpb3%2FCg%3D%3D';

my $api = WWW::Telegram::BotAPI->new (
    token => $TELEGRAM_TOKEN
) or die "I can't connect";
# Bump up the timeout when Mojo::UserAgent is used (LWP::UserAgent uses 180s by default)
$api->agent->can ("inactivity_timeout") and $api->agent->inactivity_timeout (45);
my $me = $api->getMe or die;
my ($offset, $updates) = 0;

# The commands that this bot supports.
my $current_chat_id = 0;
my $pic_id; # file_id of the last sent picture

# DB
my $database='TELEGRAM';
my $host='127.0.0.1';
my $port=3306;
my $dsn = "DBI:mysql:database=$database;host=$host;port=$port";
my $user='****db';
my $password='******2';
my $dbh = DBI->connect($dsn, $user, $password);
$dbh->do("set names utf8");

my @databases = DBI->data_sources("mysql",
        {"host" => $host, "port" => $port, "user" => $user, password => $password});

# Log
Log::Log4perl->easy_init( {level => $DEBUG, , utf8 => 1, file => ">>telegram_bot_dump"});
#    DEBUG("Debug this!");
#    INFO("Info this!");
#    WARN("Warn this!");
#    ERROR("Error this!");

sub get_my_postcode {

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    my $req_url = sprintf ("%s?ServiceKey=%s&countPerPage=10&currentPage=1&srchwrd=******6",
        $POST_URL, $POST_KEY);

	my $response = $ua->get($req_url); 

	if (! $response->is_success) {
		die $response->status_line;
	}

    my $parser = XML::LibXML->new();
    my $doc = $parser->parse_string($response->decoded_content);
    my $root = $doc->documentElement();

    my @elem = $root->getElementsByTagName("zipNo");
    my $zip_number = $elem[0]->firstChild->nodeValue;

    @elem = $root->getElementsByTagName("lnmAdres");
    my $new_addr = $elem[0]->firstChild->nodeValue;

    my $result = "";
    $result .= $zip_number;
    $result .= $new_addr; 

    if (length $result == 0) {
        return "***** no result";
    }

    return $result;
}

sub get_seoul_dust {

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;
	my $response = $ua->get($SEOUL_DUST_URL); 

	if (! $response->is_success) {
		die $response->status_line;
	}

    my $parser = XML::LibXML->new();
    my $doc = $parser->parse_string($response->decoded_content);
    my $root = $doc->documentElement();

    #<CAISTEP>보통</CAISTEP>
    my @elem = $root->getElementsByTagName("CAISTEP");
    my $step = $elem[0]->firstChild->nodeValue;

    #<ALARM_CNDT><![CDATA[외출 등 실외활동에 지장 없음]]></ALARM_CNDT>
    my @ch = $root->getElementsByTagName("ALARM_CNDT");
    my $val = $ch[0]->firstChild->nodeValue;

	my $mise_res = sprintf("[%s] %s", $step, $val);
    
    INFO($step, $val);
    return $mise_res;
    #return encode("UTF-8", $mise_res);
}

sub get_local_code {
    my $cmd = shift @_;
    my $my_district = shift @_;

    if (! defined $my_district) {
        return "usage : /loc 서구";
    }

    my $query = sprintf ("SELECT * FROM LOCAL_CODE WHERE KOR_DISTRICT LIKE \"%%%s\";", 
		$my_district); 
	my $sth = $dbh->prepare($query);
    $sth->execute;

    my $loc_result = "";

    while (my $ref = $sth->fetchrow_hashref()) {
        $loc_result .= sprintf ("%s %s %s\n", 
			$ref->{'LOCAL_CODE'}, $ref->{'KOR_CITY'}, $ref->{'KOR_DISTRICT'});
	}

	if (length $loc_result == 0) {
		$loc_result = "$my_district get failed";
		return $loc_result;
	}
    INFO($loc_result);

    if (length $loc_result == 0) {
        return "$my_district local_code not found";
    }

    return $loc_result;
    #return decode("UTF-8", $loc_result);
}

sub get_taeyoung_rent {
    my $cmd = shift @_;
    my $my_size = shift @_;
    my $year = shift @_;

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    if (! defined $my_size) {
        $my_size = 59.4;
    }
    if (! defined $year) {
        $year = 2016; 
    }

    my $loc = 00000;
    my $my_district = "***";
    my $my_apt = "마***";

    my $check_year;
    my $result = "";
    my $result1 = "";
    my $result2 = "";
    $result .= sprintf ("%s %s %sm²\n", $my_district, $my_apt, $my_size);
    my $month = strftime "%m", localtime;

    for (my $i = 1; $i < 13; $i++) {

        last if ($i > $month); 
        
        if ($i < 10) {
            $check_year = sprintf ("%d0%d", $year, $i);
        } else {
            $check_year = sprintf ("%d%d", $year, $i);
        }

        my $req_url = sprintf ("%s?LAWD_CD=%s&DEAL_YMD=%s&serviceKey=%s",
            $APT_RENT_URL, $loc, $check_year, $RENT_KEY);

        my $response = $ua->get($req_url);

        if (! $response->is_success) {
            die $response->status_line;
        }

		my $html = HTML::TagParser->new($response->decoded_content);

        my @deposit_list = $html->getElementsByTagName("보증금액");
        my @fee_list = $html->getElementsByTagName("월세금액");
        my @district_list = $html->getElementsByTagName("법정동");
        my @apt_list = $html->getElementsByTagName("아파트");
        my @size_list = $html->getElementsByTagName("전용면적");
        my @month_list = $html->getElementsByTagName("월");
        my @day_list = $html->getElementsByTagName("일");
        my @floor_list = $html->getElementsByTagName("층");

        my $len = 0;

        for (my $j=0; $j < scalar @fee_list; $j++) {

            my $district = $district_list[$j]->innerText;
            #print "district-> $district";
            next if ($my_district ne $district); 
            my $apt = $apt_list[$j]->innerText;
            #print "apt-> $apt";
            next if ($my_apt ne $apt); 

            my $size = $size_list[$j]->innerText;
            next if ($my_size ne $size); 

            my $deposit = $deposit_list[$j]->innerText;
            my $fee = $fee_list[$j]->innerText;
            my $month = $month_list[$j]->innerText;
            my $day = $day_list[$j]->innerText;
            my $floor = $floor_list[$j]->innerText;

            if ($fee == 0) {
                $result1 .= sprintf ("전세:   %s, %s층 %s/%s\n", $deposit, $floor, $month, $day);
            }
            else {
                $result2 .= sprintf ("반전세: %s(%s), %s층 %s/%s\n", $deposit, $fee, $floor, $month, $day);
            }

            $len = (length $result1) + (length $result2);
            if ($len > 3000) {
                $result .= $result1;
                $result .= $result2;
                $api->sendMessage ({
                        chat_id => $current_chat_id, 
                        text => encode("UTF-8", $result),
                    });

                #INFO($result);
				undef $result;
            }
        }
    }

    if (length $result == 0) {
        return "[$check_year] not found";
    }

    $result .= $result1;
    $result .= $result2;
    #INFO($result);
	return $result;
    #return encode("UTF-8", $result);
}

sub apt_rent_help() {
    return "사용법: \n \
/rent 11410 201512 \
/rent 11410 201512 **동";
}

sub get_apartment_rent {
    my $cmd = shift @_;
    my $loc_code = shift @_;
    my $ymd = shift @_;
    my $input_district = shift @_;

    if (! defined $loc_code or ! defined $ymd) {
        return apt_rent_help();
    }

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    my $req_url = sprintf ("%s?LAWD_CD=%s&DEAL_YMD=%s&serviceKey=%s",
        $APT_RENT_URL, $loc_code, $ymd, $RENT_KEY);

    my $response = $ua->get($req_url);

    if (! $response->is_success) {
        die $response->status_line;
    }

	#printf "%s\n", decode("UTF-8", $response->decoded_content);
	my $html = HTML::TagParser->new($response->decoded_content);
    #my $html = HTML::TagParser->new(decode("UTF-8", $response->decoded_content));

    my @deposit_list = $html->getElementsByTagName("보증금액");
    my @fee_list = $html->getElementsByTagName("월세금액");
    my @district_list = $html->getElementsByTagName("법정동");
    my @apt_list = $html->getElementsByTagName("아파트");
    my @size_list = $html->getElementsByTagName("전용면적");
    my @month_list = $html->getElementsByTagName("월");
    my @day_list = $html->getElementsByTagName("일");
    my @floor_list = $html->getElementsByTagName("층");

    my $result = "";
    my $result1 = "";
    my $result2 = "";
    my $len = 0;

    for (my $i=0; $i < scalar @fee_list; $i++) {

        my $district = $district_list[$i]->innerText;
        if (defined $input_district) {
            next if ($district !~ /^$input_district/);
            #print "$district != $input_district\n";
        }

        my $deposit = $deposit_list[$i]->innerText;
        my $fee = $fee_list[$i]->innerText;
        my $apt = $apt_list[$i]->innerText;
        my $size = $size_list[$i]->innerText;
        my $month = $month_list[$i]->innerText;
        my $day = $day_list[$i]->innerText;
        my $floor = $floor_list[$i]->innerText;

        if ($fee == 0) {
            $result1 .= sprintf ("전세   :%s, %s %s(%s층), %sm² (%s/%s)\n", 
				$deposit, $district, $apt, $floor, $size, $month, $day);
		}
        else {
            $result2 .= sprintf ("반전세 :%s(%s), %s %s(%s층), %sm² (%s/%s)\n", 
				$deposit, $fee, $district, $apt, $floor, $size, $month, $day);
		}

		$len = (length $result1) + (length $result2);
        if ($len > 3000) {
            $result .= $result1;
            $result .= $result2;
			#printf "[%s]%s\n", $current_chat_id, $result;
			$api->sendMessage ({
                    chat_id => $current_chat_id, 
                    text => encode("UTF-8", $result),
                });

			#INFO($result);
			undef $result;
        }
    }

    if (length $result == 0) {
        return "[$ymd] not found";
    }
	#printf "%s\n", $result;
    #INFO($result);
    
    $result .= $result1;
    $result .= $result2;

    return "$result\n";
    #return encode("UTF-8", $result);
}

sub help() {
    return "사용법: \n\
1.  부동산 전세 조회 : /rent 11410 201512 [**동] \
2.  태영아파트 조회 : /ty [면적] [연도] \
3.  부동산 지역 번호 조회 : /loc 서구 \
4.  미세먼지 농도 조회 : /mise";
}

my $commands = {
    "start"    => "Hello! Try: /rent - /ty - /loc - /mise - /help",
    "say"      => sub { join " ", splice @_, 1 or "Usage: /say something" },
    "whoami"   => sub {
        sprintf "Hello %s, I am %s! How are you?", 
        shift->{from}{username}, $me->{result}{username}
    },
    "rent"    => sub {
        get_apartment_rent(@_);
        # "usage : /rent 11410 201512 [**동]";
    },
    "ty"    => sub {
        get_taeyoung_rent(@_);
        # "usage : /ty [면적] [연도]";
    },
    "loc"    => sub {
        get_local_code(@_);
        # "usage : /loc 서구";
    },
    "mise"    => sub {
        get_seoul_dust(@_);
    },
    "mypost"    => sub {
        get_my_postcode(@_);
    },
    "?"    => sub {
        help();
    },
    "help"    => sub {
        help();
    },
    # Example showing how to send multiple lines in a single message.
    "knock"    => sub {
        sprintf "Knock-knock.\n- Who's there?\n@%s!", $me->{result}{username}
    },
    # Example displaying a keyboard with some simple options.
    "keyboard" => sub {
        +{
            text => "Here's a cool keyboard.",
            reply_markup => JSON::MaybeXS::encode_json ({
                    keyboard => [ [ "a" .. "c" ], [ "d" .. "f" ], [ "g" .. "i" ] ],
                    one_time_keyboard => JSON::MaybeXS::JSON->true
                })
        }
    },
    # Example sending a photo with a known picture ID.
    "lastphoto" => sub {
        return "You didn't send any picture!" unless $pic_id;
        +{
            method  => "sendPhoto",
            photo   => $pic_id,
            caption => "Here it is!"
        }
    },
    # Internal target called when a photo is received.
    "_photo" => sub { $pic_id = shift->{photo}[0]{file_id} },
    # Internal target used to handle unknown commands.
    "_unknown" => "Unknown command :("
};

INFO("$me->{result}{username} start");

while (1) {
    $updates = $api->getUpdates ({
            timeout => 30, # Use long polling
            $offset ? (offset => $offset) : ()
        });
    unless ($updates and ref $updates eq "HASH" and $updates->{ok}) {
        warn "WARNING: getUpdates returned a false value - trying again...";
        next;
    }
    for my $u (@{$updates->{result}}) {
        $offset = $u->{update_id} + 1 if $u->{update_id} >= $offset;

        if (my $text = $u->{message}{text}) { # Text message

            next if $text !~ m!^/!; # Not a command

            INFO("recv, user:$u->{message}{from}{username}, $text");

            my ($cmd, @params) = split / /, $text;

            my $res = $commands->{substr ($cmd, 1)} || $commands->{_unknown};
            # Pass to the subroutine the message object, 
            # and the parameters passed to the cmd.

            $current_chat_id = $u->{message}{chat}{id};
            $res = $res->($u->{message}, @params) if ref $res eq "CODE";
            next unless $res;
            my $method = ref $res && $res->{method} ? delete $res->{method} : "sendMessage";
            $api->$method ({
                    chat_id => $u->{message}{chat}{id},
                    ref $res ? %$res : ( text => $res )
                });
            #print "Reply sent.\n";
        } elsif ($u->{message}{photo}) {
            #print "Incoming picture...\n";
            $commands->{_photo}->($u->{message}) if ref $commands->{_photo} eq "CODE";
        }
        # TODO: other message types...
    }
}

sub _sendTextMessage {
    $api->sendMessage ({
            chat_id => shift->{message}{chat}{id},
            %{+shift}
        })
}
