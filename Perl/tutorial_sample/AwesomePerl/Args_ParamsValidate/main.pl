#!/usr/bin/perl

use Params::Validate qw(:all);

sub foo {
    validate(
        @_, {
            foo => 1,
            bar => 0,
        }
    );
}

sub bar {
    validate_pos( @_, 1, 1, 0 );
}

sub foo2 {
    validate(
        @_, {
            foo =>
            { type => ARRAYREF },
            bar =>
            { can => [ 'print', 'flush', 'frobnicate' ] },
            baz => {
                type    => SCALAR,
                regex   => qr/^\d+$/,
                callbacks => {
                    'less than 90' => sub { shift() < 90 },
                },
            }
        }
    );
}

sub callback_with_custom_error {
    validate(
        @_,
        {
            foo => callbacks => {
                'is an integer' => sub {
                    return 1 if $_[0] =~ /^-?[1-9][0-9]*$/;
                    die "$_[0] is not a valid integer value";
                },
            }
        }
    );
}

sub with_defaults {
    my %p = validate(
        @_, {
            foo => 1,
            bar => { default => 99 }
        }
    );
}

sub pos_with_defaults {
    my @p = validate_pos ( @_, 1, { default => 99 } );
}

sub sets_options_on_call {
    my %p = validate_with(
        params  => \@_,
        spec    => { foo => { type => SCALAR, default => 2 } },
        normalize_keys => sub { $_[0] =~ s/^-//; lc $_[0] },
    );
}
