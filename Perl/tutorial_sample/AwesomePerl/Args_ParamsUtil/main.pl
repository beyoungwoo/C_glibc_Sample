#!/usr/bin/perl

use Params::Util qw{_SCALAR _HASH _INSTANCE};

use Params::Util ':ALL';


sub foo {
    my $name = _STRING(shift) or die "bad name";
    print "$name \n";

    my $string = _STRING($_[0]) ? shift : die "Bad string";
    print "$string \n";

    my $object  = _INSTANCE(shift, 'Foo') or return undef;
    my $image   = _SCALAR(shift)          or return undef;
    my $options = _HASH(shift)            or return undef;

    print "$object, $image, $options \n";


}
#foo('0', 43, 234,  "test", 123 );
foo("test");


