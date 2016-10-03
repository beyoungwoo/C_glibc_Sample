package Dog;
use Moose;
with qw/Age/;

sub speak {
    my ($self) = @_;
    print "Bark " x $self->age . "\n";
};

1;
