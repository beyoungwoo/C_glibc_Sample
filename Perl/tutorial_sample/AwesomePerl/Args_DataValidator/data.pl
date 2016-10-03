#!/usr/bin/perl
#

package Foo;

use 5.10.0;
use Data::Validator;

# functions
sub get {
    state $rule = Data::Validator->new(
        uri         => { isa => 'Str', xor => [qw(schema host path_query)] },
        schema      => { isa => 'Str', default => 'http'},
        host        => { isa => 'Str'},
        path_query  => { isa => 'Str', default => '/'},
        method      => { isa => 'Str', default => 'GET'},
    );

    my ($class, $args) = $rule->validate(@_);
    is $class, 'example';
    
    # ...
}   
#get( uri => 'ayowhatthemple.com/');
get( uri => 'http://exemple.com/');

# methods
sub method {
    state $rule = Data::Validator->new(
        foo => 'Str',
    )->with('Method');

    my($self, $args) = $rule->validate(@_);
    #...
    print "$args \n";
} 
Foo->method( foo => 'bar' );

# sequence parameter
sub seq {
    state $rule = Data::Validator->new(
        foo => 'Str',
    )->with('StrictSequenced');

    my $args = $rule->validate(@_);
    # ...
    
}
seq( 'bar' );
#seq({ foo => 'bar' });

# method and StrinctSequenced together
sub seq_method {
    state $rule = Data::Validator->new(
        foo => 'Str',
    )->with('Method', 'StrictSequenced');

    my ($self, $args) = $rule->validate(@_);
    # ...
}
Foo->seq_method( 'bar' );

# sequenced and named parameters
sub smart_seq {
    my $rule = Data::Validator->new(
        r1 => 'Str',
        r2 => 'HashRef',
        o1 => { isa => 'Str', default => 'yes' },
        o2 => { isa => 'Num', optional => 1 },
    )->with('SmartSequenced');

    my $args = $rule->validate(@_);
    # ...
}
smart_seq('foo', { val => 'bar' }, { o1 => 'yes' } );
smart_seq('foo', { val => 'bar' } );

smart_seq('foo', { val => 'bar' }, 'yes' );
smart_seq('foo', { val => 'bar' } );

smart_seq( {r1 => 'foo', r2 => { val => 'bar' }, o1 => 'yes' } );
smart_seq( {r1 => 'foo', r2 => { val => 'bar' } } );

my $v = Data::Validator->new(
    foo => { default => 99 },
    bar => { default => sub {
        my($validator, $this_rule, $args) = @_;
        return $args->{foo} + 1;
    } },
);
$v->validate();          # bar is 100
print "$v->validate() \n";          # bar is 100
$v->validate(foo => 42); # bar is 43
print "$v->validate(foo => 42) \n"; # bar is 43

=start_comment
=cut

