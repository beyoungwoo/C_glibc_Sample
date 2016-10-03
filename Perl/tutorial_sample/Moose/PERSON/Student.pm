package Student;
use Moose;
extends 'Person';

has school => (is => 'rw', isa => 'Str');

after speak => sub {
    my ($self) = @_;
    print 'and my school is '. $self->school . "\n";
};

1;
