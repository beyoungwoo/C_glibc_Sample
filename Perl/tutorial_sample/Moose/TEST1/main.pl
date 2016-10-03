#!/usr/bin/perl 

use Point3D qw(new);
 
sub main {
    #my $p = Point3D->new( x=>10, y=>20, z=>30 );
    my $p = new( x=>10, y=>20, z=>30 );
    print $p->x," ",$p->y," ",$p->z,"\n";
    $p->x(15);
    print $p->x," ",$p->y," ",$p->z,"\n";
    $p->clear;
    print $p->x," ",$p->y," ",$p->z,"\n";
}

main();
