package Age;
use Moose::Role;

has birth_year => ( is => 'ro', isa => 'Int');

requires qw/speak/;

sub age {
    my ($self) = @_;
    my $current_year = 1900 + ( localtime() )[5];
    return $current_year - $self->birth_year();
}

1;
