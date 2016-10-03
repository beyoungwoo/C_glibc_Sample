#!/usr/bin/perl

use Apache::Logregex;


filename="/Users/jeonbyeong-u/src/alog";
#$filename="/Users/jeonbyeong-u/src/apache_log_short";

open($INPUT, $filename)
    or die "file open failed $filename";

my @var;
my @user;
my $idx = 0;
while ( <$INPUT> ) {
    chomp;

     @var = split(/ /, $_);
     @user[$idx] = @var[14];
     $idx++;
}

@user = sort @user;
print "@user\n";

=asd
my $max_idx;
my $max_user;
my $last_user = $user[0];
$idx = 0;
foreach my $login_user (@user) {
    if ($last_user eq $login_user) {
        $idx++;
    }
    else {
        if ($last_user ne "-") {
            if ($max_idx < $idx) {
                $max_idx = $idx;
                $max_user = $last_user;
            }
        }
        $idx = 0;
        $last_user = $login_user;
    }
}
print "$max_user, $max_idx\n";
=cut

close $INPUT;
