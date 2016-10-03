package Person;
use Moose;
with qw/Age/;

has name => (is => 'ro', isa => 'Str');

sub speak {
    my ($self) = @_;
    print "I'm ".$self->name.', age '.$self->age."\n";
}

1;

