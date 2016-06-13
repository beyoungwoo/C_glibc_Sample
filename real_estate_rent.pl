#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use WWW::Telegram::BotAPI;

use LWP::UserAgent;
use HTML::TagParser;

my $TOKEN = '195271277:AAEXxDw6kCd66yXe5enS8Qk4KTLk3XpcJqI'; 
my $api = WWW::Telegram::BotAPI->new (
    token => $TOKEN
) or die "I can't connect";

# Bump up the timeout when Mojo::UserAgent is used (LWP::UserAgent uses 180s by default)
$api->agent->can ("inactivity_timeout") and $api->agent->inactivity_timeout (45);

my $me = $api->getMe or die;
my ($offset, $updates) = 0;

# The commands that this bot supports.
my $pic_id; # file_id of the last sent picture

sub get_apartment_rent {
    shift @_; # command pass
    my $loc = shift @_;
    my $ymd = shift @_;

    print "$loc\n" if defined $loc;
    print "$ymd\n" if defined $ymd;

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    if (! defined $loc) {
        $loc = 11440; 
    }
    if (! defined $ymd) {
        $ymd = 201512; 
    }

    # TODO : change to snprintf
    my $url = 'http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade';
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

    my $html = HTML::TagParser->new($response->decoded_content);

    my @money_list = $html->getElementsByTagName("거래금액");
    my @area_list = $html->getElementsByTagName("법정동");
    my @apt_list = $html->getElementsByTagName("아파트");
    my @size_list = $html->getElementsByTagName("전용면적");
    my @month_list = $html->getElementsByTagName("월");
    my @day_list = $html->getElementsByTagName("일");

    my $result = "";
    my $len = 0;

    for (my $i=0; $i < scalar @money_list; $i++) {

        my $money = $money_list[$i]->innerText;
        my $area = $area_list[$i]->innerText;
        my $apt = $apt_list[$i]->innerText;
        my $size = $size_list[$i]->innerText;
        my $month = $month_list[$i]->innerText;
        my $day = $day_list[$i]->innerText;

        $result .= sprintf ("%s, %s %s, %s (%s/%s)\n", $money, $area, $apt, $size, $month, $day);

        $len = length $result;
        if ($len > 3000) {
            last;
        }
    }

    return $result;
}

my $commands = {
    "start"    => "Hello! Try: /whoami - /say - /lastphoto - /keyboard - /knock",
    # Example demonstrating the use of parameters in a command.
    "say"      => sub { join " ", splice @_, 1 or "Usage: /say something" },
    # Example showing how to use the result of an API call.
    "whoami"   => sub {
        sprintf "Hello %s, I am %s! How are you?", shift->{from}{username}, $me->{result}{username}
    },
    "real"    => sub {
        get_apartment_rent(@_);
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
