#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Encode;

use WWW::Telegram::BotAPI;

use LWP::UserAgent;
use HTML::TagParser;

use DBD::mysql;

my $TOKEN = 'my_token';
my $key = 'my_key';
my $url = 'my_url';
my $api = WWW::Telegram::BotAPI->new (
    token => $TOKEN
) or die "I can't connect";

# Bump up the timeout when Mojo::UserAgent is used (LWP::UserAgent uses 180s by default)
$api->agent->can ("inactivity_timeout") and $api->agent->inactivity_timeout (45);

my $me = $api->getMe or die;
my ($offset, $updates) = 0;

# The commands that this bot supports.
my $pic_id; # file_id of the last sent picture

my $database='my_db';
my $host='127.0.0.1';
my $port=3306;

my $dsn = "DBI:mysql:database=$database;host=$host;port=$port";

my $user='my_db_user';
my $password='my_db_passwd';
my $dbh = DBI->connect($dsn, $user, $password);


my @databases = DBI->data_sources("mysql",
        {"host" => $host, "port" => $port, "user" => $user, password => $password});

sub get_local_code {
    my $cmd = shift @_;
    my $my_district = shift @_;

    if (! defined $my_district) {
        return "usage : /loc 서구";
    }

    my $query = sprintf ("SELECT * FROM LOCAL_CODE WHERE KOR_DISTRICT LIKE \"%%%s\";", $my_district); 
    my $sth = $dbh->prepare($query);
    $sth->execute;

    my $loc_result = "";

    while (my $ref = $sth->fetchrow_hashref()) {
        $loc_result .= sprintf ("%s %s %s\n", $ref->{'LOCAL_CODE'}, $ref->{'KOR_CITY'}, $ref->{'KOR_DISTRICT'});
    }
    print "$loc_result\n";
    return decode("UTF-8", $loc_result);
}

sub get_taeyoung_rent {
    my $cmd = shift @_;
    my $my_district = shift @_;
    my $my_apt = shift @_;
    my $my_size = shift @_;
    my $year = shift @_;

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    my $loc = 11440; 

    if (! defined $year) {
        $year = 2016; 
    }
    if (! defined $my_district || ! defined $my_apt || ! defined $my_size) {
        return "usage : /y1 동 아파트 면적 연도";
    }

    my $check_year;
    my $result = "";
    $result .= sprintf ("%s %s %sm²\n", $my_district, $my_apt, $my_size);
    for (my $i = 1; $i < 13; $i++) {
        if ($i < 10) {
            $check_year = sprintf ("%d0%d", $year, $i);
        } else {
            $check_year = sprintf ("%d%d", $year, $i);
        }


        print "$check_year\n";
        my $req_url = sprintf ("%s?LAWD_CD=%s&DEAL_YMD=%s&serviceKey=%s",
            $url, $loc, $check_year, $key);

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
                $result .= sprintf ("전세:   %s, %s층 %s/%s\n", $deposit, $floor, $month, $day);
            }
            else {
                $result .= sprintf ("반전세: %s(%s), %s층 %s/%s\n", $deposit, $fee, $floor, $month, $day);
            }
            #print "$result\n";

            $len = length $result;
            if ($len > 4000) {
                last;
            }
        }
    }

    return $result;
}

sub help() {
    return "사용법: \
    ex) /real 11410 201512";

}



sub get_apartment_rent {
    my $cmd = shift @_;
    my $loc = shift @_;
    my $input_district = shift @_;
    my $ymd = shift @_;

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    if (! defined $loc) {
        $loc = 11440; 
    }
    if (! defined $ymd) {
        $ymd = 201512; 
    }

    my $req_url = sprintf ("%s?LAWD_CD=%s&DEAL_YMD=%s&serviceKey=%s",
        $url, $loc, $ymd, $key);

    my $response = $ua->get($req_url);

    if (! $response->is_success) {
        die $response->status_line;
    }

    print "$response->decoded_content\n";
    my $html = HTML::TagParser->new($response->decoded_content);

    my @deposit_list = $html->getElementsByTagName("보증금액");
    my @fee_list = $html->getElementsByTagName("월세금액");
    my @district_list = $html->getElementsByTagName("법정동");
    my @apt_list = $html->getElementsByTagName("아파트");
    my @size_list = $html->getElementsByTagName("전용면적");
    my @month_list = $html->getElementsByTagName("월");
    my @day_list = $html->getElementsByTagName("일");
    my @floor_list = $html->getElementsByTagName("층");

    my $result = "";
    my $len = 0;

    for (my $i=0; $i < scalar @fee_list; $i++) {

        my $district = $district_list[$i]->innerText;
        if (defined $input_district) {
            next if ($district !~ /^$input_district/);
        }

        my $deposit = $deposit_list[$i]->innerText;
        my $fee = $fee_list[$i]->innerText;
        my $apt = $apt_list[$i]->innerText;
        my $size = $size_list[$i]->innerText;
        my $month = $month_list[$i]->innerText;
        my $day = $day_list[$i]->innerText;
        my $floor = $floor_list[$i]->innerText;

        $result .= sprintf ("%s(%s), %s %s(%s층), %s (%s/%s)\n", $deposit, $fee, $district, $apt, $floor, $size, $month, $day);

        $len = length $result;
        if ($len > 3000) {
            last;
        }
    }

    return $result;
}

sub help() {
    return "사용법: \
    ex) /rent 11410 대흥201512";

}

my $commands = {
    "start"    => "Hello! Try: /whoami - /say - /lastphoto - /keyboard - /knock",
    # Example demonstrating the use of parameters in a command.
    "say"      => sub { join " ", splice @_, 1 or "Usage: /say something" },
    # Example showing how to use the result of an API call.
    "whoami"   => sub {
        sprintf "Hello %s, I am %s! How are you?", shift->{from}{username}, $me->{result}{username}
    },
    "rent"    => sub {
        get_apartment_rent(@_);
    },
    "y1"    => sub {
        get_taeyoung_rent(@_);
    },
    "loc"    => sub {
        get_local_code(@_);
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

printf "Hello! I am %s. Starting...\n", $me->{result}{username};

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
            printf "Incoming text message from \@%s\n", $u->{message}{from}{username};
            printf "Text: %s\n", $text;
            next if $text !~ m!^/!; # Not a command
            my ($cmd, @params) = split / /, $text;
            printf "Command -->> $cmd\n";
            my $res = $commands->{substr ($cmd, 1)} || $commands->{_unknown};
            # Pass to the subroutine the message object, 
            # and the parameters passed to the cmd.


            $res = $res->($u->{message}, @params) if ref $res eq "CODE";
            next unless $res;
            my $method = ref $res && $res->{method} ? delete $res->{method} : "sendMessage";
            $api->$method ({
                    chat_id => $u->{message}{chat}{id},
                    ref $res ? %$res : ( text => $res )
                });
            print "Reply sent.\n";
        } elsif ($u->{message}{photo}) {
            print "Incoming picture...\n";
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
